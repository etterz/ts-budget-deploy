# Budget App Deployment

## Install (One-liner)

```bash
curl -sL https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/install.sh | bash -s -- -c https://budget.yourdomain.com
```

## Manual Setup

```bash
mkdir -p ~/app && cd ~/app
curl -sO https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/docker-compose.yml
echo 'PORT=3000' > .env
echo 'CORS_ORIGINS=https://budget.yourdomain.com' >> .env
docker compose up -d
```

## Options

| Flag | Description | Default |
|------|-------------|---------|
| `-c, --cors` | CORS origins (required) | - |
| `-p, --port` | Frontend port | `3000` |
| `-d, --dir` | Install directory | `~/app` |
| `-u, --update` | Update existing installation | - |

## Images

Pre-built images from GitHub Container Registry:
- `ghcr.io/etterz/ts-budget/frontend:latest`
- `ghcr.io/etterz/ts-budget/backend:latest`
