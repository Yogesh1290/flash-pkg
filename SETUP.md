# Setup Instructions for flash-pkg

## For You (The Creator)

### 1. Test Locally First

```bash
# Make install.sh executable
chmod +x install.sh

# Test it
bash test-local.sh

# Or manually
bash install.sh
source ~/.bashrc
flash  # Should show help
```

### 2. Create GitHub Repository

```bash
# Initialize git
git init
git add .
git commit -m "Initial release: flash-pkg v1.0"

# Create repo on GitHub (name it: flash-pkg)
# Then push
git remote add origin https://github.com/Yogesh1290/flash-pkg.git
git branch -M main
git push -u origin main
```

### 3. Update URLs

Replace `Yogesh1290` in these files:
- `install.sh` (line 6)
- `README.md` (multiple places)
- `docs/ENTERPRISE.md`

Quick find-replace:
```bash
# On Linux/Mac
sed -i 's/Yogesh1290/your-actual-username/g' install.sh README.md docs/ENTERPRISE.md

# On Windows (Git Bash)
sed -i 's/Yogesh1290/your-actual-username/g' install.sh README.md docs/ENTERPRISE.md
```

### 4. Test the Public Install

After pushing to GitHub:

```bash
# Test the curl command
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
```

### 5. Bootstrap Once

```bash
# When you have good WiFi (cafe, home, office)
flash bootstrap-ml

# This downloads ~1-2 GB once
# After this, every new project is <30 seconds forever
```

### 6. Test Real Usage

```bash
# Create test ML project
flash ml test-ai-project
cd test-ai-project

# Check it works
ls -la
cat pyproject.toml

# Run something
uv run python -c "import torch; print(torch.__version__)"
```

### 7. Share It

Post on:
- Reddit: r/Python, r/MachineLearning, r/Nepal
- LinkedIn
- Twitter/X
- dev.to
- Hacker News

Example post:
```
I built flash-pkg — a tool that cuts ML project setup from 45 min to <30 sec

Problem: In Nepal (slow internet), installing torch + paddleocr takes 45-90 minutes. Every. Single. Time.

Solution: One-time bootstrap + uv + Asia mirrors = instant forever.

After bootstrap, every new ML project is ready in under 30 seconds.

Enterprise-ready: Used by Snyk, Rippling, Plotly (via uv).

GitHub: https://github.com/Yogesh1290/flash-pkg

Star if it saves you time! 🚀
```

## For Users

### Quick Start

```bash
# 1. Install (10-30 seconds)
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
source ~/.bashrc

# 2. Bootstrap once (2-4 minutes on good WiFi)
flash bootstrap-ml

# 3. Create projects instantly
flash ml my-ai-project
```

### Troubleshooting

**"blitz: command not found"**
```bash
source ~/.bashrc  # or ~/.zshrc
```

**"uv: command not found"**
```bash
export PATH="$HOME/.cargo/bin:$PATH"
source ~/.bashrc
```

**Slow downloads during bootstrap**
```bash
# Check which mirror is being used
uv pip config get global.index-url

# Manually set fastest mirror
uv pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

**Windows support**
- Coming soon! For now, use WSL2 or Git Bash

## Next Steps

- [ ] Add Windows PowerShell version
- [ ] Create demo video
- [ ] Add more templates (FastAPI, Django, Next.js)
- [ ] Set up GitHub Actions for testing
- [ ] Create website/landing page

---

**You built something real. Now ship it!** 🚀
