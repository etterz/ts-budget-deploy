# Budget App Deployment

## Install (One-liner)

```bash
curl -sL https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/install.sh | bash -s -- -c https://budget.yourdomain.com
```

## Install with Custom Port

```bash
curl -sL https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/install.sh | bash -s -- -c https://budget.yourdomain.com -p 8080
```

## Manual Setup

```bash
mkdir -p ~/app && cd ~/app
curl -sO https://raw.githubusercontent.com/etterz/ts-budget-deploy/main/docker-compose.yml
printf 'PORT=3000\nCORS_ORIGINS=https://budget.yourdomain.com\n' > .env
docker compose up -d
```

## Notes

- Frontend listens on port 3000 by default (configurable via PORT env var)
- Backend is internal-only on Docker network

## Options

| Flag | Description | Default |
|------|-------------|---------|
| `-c, --cors` | CORS origins (required) | - |
| `-p, --port` | Frontend port | `3000` |
| `-d, --dir` | Install directory | `~/app` |
| `-u, --update` | Update existing installation | - |

## Images

Pre-built images from GitHub Container Registry:
- `ghcr.io/etterz/ts_budget/frontend:latest`
- `ghcr.io/etterz/ts_budget/backend:latest`
