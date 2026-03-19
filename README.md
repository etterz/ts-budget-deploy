# Budget App Deployment

## Install (One-liner)

```bash
curl -sL https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/install.sh | bash -s -- -c https://budget.yourdomain.com
```

## Manual Setup

```bash
mkdir -p ~/app && cd ~/app
curl -sO https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/docker-compose.yml
echo 'CORS_ORIGINS=https://budget.yourdomain.com' > .env
docker compose up -d
```

## Notes

- Frontend listens on port 3000 (Caddy routes here)
- Backend is internal-only on Docker network

## Options

| Flag | Description | Default |
|------|-------------|---------|
| `-c, --cors` | CORS origins (required) | - |
| `-d, --dir` | Install directory | `~/app` |
| `-u, --update` | Update existing installation | - |

## Images

Pre-built images from GitHub Container Registry:
- `ghcr.io/etterz/ts_budget/frontend:latest`
- `ghcr.io/etterz/ts_budget/backend:latest`
