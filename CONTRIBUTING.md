# Contributing to flash-pkg

Thanks for your interest! Here's how you can help make dev setup instant for everyone.

## 🎯 Most Wanted Features (v1.2+)

### High Priority
- **Windows PowerShell version** — Most requested by users
- **JavaScript cache sharing** — `flash export-cache-js` / `flash import-cache-js` (like Python)
- **Bun bootstrap** — `flash bootstrap-mern` to pre-cache React/Next.js/Vue
- **More templates** — FastAPI, Django, Next.js, Svelte, SvelteKit
- **Mirror improvements** — Add more Asia/Africa/LatAm mirrors

### Production & Enterprise (v2.0+)
- **Docker production templates** — Production-ready Dockerfiles with multi-stage builds
- **Kubernetes configs** — Deployment manifests, Helm charts
- **Docker Compose** — Multi-service app templates
- **Pre-built Docker images** — With cached dependencies on Docker Hub
- **CI/CD pipelines** — GitHub Actions, GitLab CI, Jenkins templates

### Developer Experience
- **VS Code extension** — GUI for flash commands
- **TUI interface** — Interactive terminal UI (like `lazygit`)
- **Auto-update** — `flash update` command
- **Config file** — `.flashrc` for project-specific settings

### Language Support
- **Go** — Fast Go module caching
- **Rust** — Cargo cache optimization
- **Java** — Maven/Gradle cache sharing
- **PHP** — Composer cache optimization

### Advanced Features
- **Pre-built cache hosting** — CDN for popular package combinations
- **Kubernetes operators** — Auto-manage caches in K8s clusters
- **Monorepo tools** — Better support for Nx, Turborepo, Lerna
- **Mirror benchmarking** — `flash test-mirrors` command

## 🚀 How to Contribute

### 1. Fork & Clone
```bash
git clone https://github.com/YOUR-USERNAME/flash-pkg.git
cd flash-pkg
```

### 2. Create Feature Branch
```bash
git checkout -b feature/your-feature-name
# Examples:
# feature/windows-support
# feature/js-cache-export
# feature/docker-production
```

### 3. Make Changes
- Keep it simple and readable
- Add comments for complex logic
- Follow existing patterns in `install.sh`
- Update documentation if needed

### 4. Test Thoroughly
```bash
# Test the install script
bash install.sh
source ~/.bashrc

# Test your feature
flash your-new-command

# Test existing features still work
flash ml test-project
flash mern test-app
flash bootstrap-ml
flash export-cache
```

### 5. Commit & Push
```bash
git add .
git commit -m "Add: your feature description"
# Examples:
# "Add: Windows PowerShell support"
# "Add: JavaScript cache export/import"
# "Fix: Mirror selection on slow connections"

git push origin feature/your-feature-name
```

### 6. Open Pull Request
- Describe what you added/fixed
- Include test results
- Reference any related issues

## 📋 Code Style

### Shell Scripts
- Use `bash` (not `sh`)
- Add error handling: `set -e`
- Use meaningful variable names
- Add comments for non-obvious code
- Test on Linux and macOS (Windows if applicable)

### Documentation
- Update README.md if adding major features
- Add examples for new commands
- Keep language simple and clear
- Include performance benchmarks if relevant

## 🐛 Bug Reports

Found a bug? Open an issue with:
1. **Description** — What went wrong?
2. **Steps to reproduce** — How can we see the bug?
3. **Expected behavior** — What should happen?
4. **Environment** — OS, shell, internet speed
5. **Logs** — Error messages, command output

## 💡 Feature Requests

Have an idea? Open an issue with:
1. **Problem** — What pain point does this solve?
2. **Solution** — How would it work?
3. **Use case** — Who would use this?
4. **Alternatives** — What exists today?

## 🎓 Good First Issues

New to the project? Look for issues tagged:
- `good-first-issue` — Easy to implement
- `help-wanted` — We need your expertise
- `documentation` — Improve docs

## 🤝 Community Guidelines

- Be respectful and constructive
- Help others in issues/discussions
- Share your use cases and benchmarks
- Star the repo if it helps you!

## 📈 Roadmap

### v1.1 (Current)
- ✅ Python cache export/import
- ✅ Asia-optimized mirrors
- ✅ Basic MERN support

### v1.2 (Next 1-3 months)
- ⏳ Windows PowerShell support
- ⏳ JavaScript cache sharing
- ⏳ More project templates
- ⏳ VS Code extension

### v2.0 (3-6 months)
- ⏳ Docker production templates
- ⏳ Kubernetes support
- ⏳ More language support (Go, Rust)
- ⏳ GUI/TUI interface

### v3.0 (6-12 months)
- ⏳ Pre-built cache CDN
- ⏳ Enterprise features
- ⏳ Kubernetes operators
- ⏳ Multi-language support

## 🙏 Recognition

Contributors will be:
- Listed in README.md
- Mentioned in release notes
- Part of building something developers love

## 📞 Questions?

- Open a GitHub issue
- Check existing issues/discussions
- Read the docs: README.md, FAQ.md, HOW_IT_WORKS.md

---

**Let's make dev setup instant for everyone!** 🚀

Your contribution, no matter how small, makes a difference.
