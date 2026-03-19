#!/usr/bin/env bash
set -e

PORT=3000
DIR=~/app
UPDATE=false

usage() {
  echo "Usage: $0 -c <cors_origins> [-p <port>] [-d <directory>] [-u]"
  echo ""
  echo "Options:"
  echo "  -c, --cors      CORS origins (required, e.g., https://budget.yourdomain.com)"
  echo "  -p, --port       Frontend port (default: 3000)"
  echo "  -d, --dir        Install directory (default: ~/app)"
  echo "  -u, --update     Update existing installation"
  echo "  -h, --help       Show this help message"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--cors)
      CORS_ORIGINS="$2"
      shift 2
      ;;
    -p|--port)
      PORT="$2"
      shift 2
      ;;
    -d|--dir)
      DIR="$2"
      shift 2
      ;;
    -u|--update)
      UPDATE=true
      shift
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

if [[ -z "$CORS_ORIGINS" ]]; then
  echo "Error: --cors is required"
  usage
fi

if [[ ! "$CORS_ORIGINS" =~ ^https:// ]]; then
  echo "Error: --cors must start with https://"
  usage
fi

if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed"
  exit 1
fi

if ! docker info &> /dev/null; then
  echo "Error: Docker is not running"
  exit 1
fi

echo "Installing Budget App to $DIR..."

mkdir -p "$DIR"
cd "$DIR"

echo "Downloading docker-compose.yml..."
curl -sO https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/docker-compose.yml

if [[ -f .env ]]; then
  if [[ "$UPDATE" == true ]]; then
    cp .env .env.bak
    echo "Backed up existing .env -> .env.bak"
  else
    echo "Warning: .env exists. Use -u to update."
  fi
fi

cat > .env << EOF
PORT=$PORT
CORS_ORIGINS=$CORS_ORIGINS
EOF

echo "Created .env"

if [[ "$UPDATE" == true ]]; then
  echo "Stopping existing containers..."
  docker compose down || true
fi

echo "Pulling and starting containers..."
docker compose pull
docker compose up -d

IP=$(hostname -I | awk '{print $1}')
echo ""
echo "Installation complete!"
echo "Frontend available at http://$IP:$PORT"
echo "Backend is internal-only."
