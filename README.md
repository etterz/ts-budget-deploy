# Budget App Deployment

## Quick Start

```bash
mkdir -p ~/app && cd ~/app
curl -sO https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/docker-compose.yml
echo 'CORS_ORIGINS=https://yourdomain.com' > .env
docker compose pull
docker compose up -d
```

## Configuration

Edit `.env` and set `CORS_ORIGINS` to your domain.

## Images

Pre-built images from GitHub Container Registry:
- `ghcr.io/etterz/ts-budget/frontend:latest`
- `ghcr.io/etterz/ts-budget/backend:latest`
