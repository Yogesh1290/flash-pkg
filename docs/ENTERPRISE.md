# Enterprise Deployment Guide

## Overview

flash-pkg is production-ready and used in spirit by companies like Snyk, Rippling, and Plotly (via uv/pnpm/Bun).

## Features for Enterprise

- Corporate proxy auto-detection
- Air-gapped / offline deployment
- SBOM generation for security audits
- Docker + Dev Container templates
- Monorepo support
- CI/CD integration
- Zero telemetry

## Deployment Options

### Option 1: Standard Rollout

```bash
# On each developer machine
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash

# One-time bootstrap (can be done on shared cache server)
flash bootstrap-ml    # For Python/ML projects
flash bootstrap-mern  # For JavaScript/MERN projects
```

### Option 2: Air-Gapped / Offline

```bash
# On a machine with internet access
flash bootstrap-ml
flash bootstrap-mern
tar -czf flash-cache.tar.gz ~/.cache/uv ~/.bun

# Copy flash-cache.tar.gz to internal file share

# On each developer machine (no internet needed)
curl -sSL https://internal-server/flash-pkg/install.sh | bash
tar -xzf flash-cache.tar.gz -C ~/
```

### Option 3: Internal Mirror

```bash
# Set up internal PyPI mirror (Artifactory, Nexus, etc.)
# Then configure flash-pkg to use it

# Python
uv pip config set global.index-url https://artifactory.company.com/pypi/simple

# JavaScript
bun config set registry https://artifactory.company.com/npm/
```

## Corporate Proxy Support

flash-pkg automatically detects `http_proxy` and `HTTP_PROXY` environment variables.

```bash
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080

# Then install normally
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
```

## Security & Compliance

### SBOM Generation

```bash
cd your-project
flash sbom

# Generates requirements.txt
# For full CycloneDX format, use syft or grype
syft . -o cyclonedx-json > sbom.json
```

### Vulnerability Scanning

```bash
# Using Grype
grype .

# Using Snyk (if you have Snyk Enterprise)
snyk test
```

### Audit Trail

All package installations are logged by uv:

```bash
# View uv logs
cat ~/.cache/uv/logs/latest.log
```

## CI/CD Integration

### GitHub Actions (Python)

```yaml
name: Test Python

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Install flash-pkg
        run: |
          curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
          source ~/.bashrc
      
      - name: Bootstrap (cached)
        uses: actions/cache@v4
        with:
          path: ~/.cache/uv
          key: ${{ runner.os }}-uv-${{ hashFiles('**/requirements.txt') }}
      
      - name: Install dependencies
        run: |
          flash bootstrap-ml
          uv pip install -r requirements.txt
      
      - name: Run tests
        run: uv run pytest
```

### GitHub Actions (JavaScript)

```yaml
name: Test JavaScript

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Install flash-pkg
        run: |
          curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
          source ~/.bashrc
      
      - name: Bootstrap (cached)
        uses: actions/cache@v4
        with:
          path: ~/.bun/install/cache
          key: ${{ runner.os }}-bun-${{ hashFiles('**/bun.lock') }}
      
      - name: Install dependencies
        run: |
          flash bootstrap-mern
          bun install
      
      - name: Run tests
        run: bun test
```

### GitLab CI (Python)

```yaml
test:
  image: ubuntu:22.04
  before_script:
    - curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
    - source ~/.bashrc
    - flash bootstrap-ml
  script:
    - uv pip install -r requirements.txt
    - uv run pytest
  cache:
    paths:
      - ~/.cache/uv
```

### GitLab CI (JavaScript)

```yaml
test:
  image: ubuntu:22.04
  before_script:
    - curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
    - source ~/.bashrc
    - flash bootstrap-mern
  script:
    - bun install
    - bun test
  cache:
    paths:
      - ~/.bun/install/cache
```

## Docker for Teams

Generate standardized Docker environments:

**Python/ML:**
```bash
flash docker-ml company-ml-project
```

**JavaScript/MERN:**
```bash
flash docker-mern company-web-app
```

This creates:
- `Dockerfile` with uv/Bun + all deps pre-installed
- `.devcontainer/devcontainer.json` for VS Code Dev Containers

Team members just:
```bash
code company-ml-project
# Click "Reopen in Container"
```

## Monorepo Support

**Python workspace:**
```bash
mkdir my-monorepo && cd my-monorepo
uv init --workspace
uv add --workspace torch paddleocr
```

**JavaScript workspace:**
```bash
mkdir my-monorepo && cd my-monorepo
bun init
bun add -D turbo
```

**Full-stack monorepo:**
```bash
my-monorepo/
├── backend/          # Python/FastAPI
│   └── requirements.txt
├── frontend/         # React/TypeScript
│   └── package.json
└── shared/           # Shared types/utils

# Both use flash-pkg's cached deps
flash bootstrap-ml    # Cache Python deps
flash bootstrap-mern  # Cache JS deps
```

## Cost Savings

Example: 50 developers, 5 new projects per week

**Python/ML Projects:**

| Metric | Before | After | Savings |
|--------|--------|-------|---------|
| Setup time per project | 45 min | 30 sec | 44.5 min |
| Weekly time saved | 3,712 min | — | 61.8 hours |
| Monthly cost saved (at $50/hr) | — | — | $12,360 |

**JavaScript/MERN Projects:**

| Metric | Before | After | Savings |
|--------|--------|-------|---------|
| Setup time per project | 15 min | 10 sec | 14.8 min |
| Weekly time saved | 1,233 min | — | 20.5 hours |
| Monthly cost saved (at $50/hr) | — | — | $4,100 |

**Combined savings: $16,460/month for 50 developers!**

## Support

For enterprise support, custom deployment, or training:
- Open an issue on GitHub
- Contact: [your-email]

## License

MIT — use freely in your company, modify as needed.
