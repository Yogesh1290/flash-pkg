# Good First Issues for New Contributors

Welcome! Here are some easy issues to get started with flash-pkg.

## 🟢 Easy (1-2 hours)

### Issue #1: Add Badges to README
**Labels:** `good first issue`, `documentation`

Add badges to README.md:
- Version badge
- License badge
- Platform support badge
- CI status badge
- Stars badge

**Files to edit:** `README.md`

**Example:**
```markdown
![Version](https://img.shields.io/badge/version-1.2.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
```

---

### Issue #2: Fix PowerShell Profile Error
**Labels:** `good first issue`, `bug`, `platform: windows`

Fix the `. $PROFILE` error that appears after installation on Windows.

**Problem:** Profile file doesn't exist when command runs
**Solution:** Ensure directory and file exist before adding content

**Files to edit:** `install.ps1`

---

### Issue #3: Add More Examples to docs/
**Labels:** `good first issue`, `documentation`

Create example projects in `examples/` folder:
- FastAPI project example
- Django project example
- Next.js project example
- Vue project example

**Files to create:** New markdown files in `examples/`

---

## 🟡 Medium (3-5 hours)

### Issue #4: Add Cache Metadata
**Labels:** `enhancement`, `component: cache`

Add metadata to exported cache files showing:
- Creation date
- Package versions
- Total size
- Flash-pkg version

**Files to edit:** `install.sh`, `install.ps1`

---

### Issue #5: Add `flash cache-info` Command
**Labels:** `enhancement`, `component: cache`

Add command to show information about a cache file without importing it.

**Usage:**
```bash
flash cache-info flash-cache-2026-03.tar.zst
```

**Files to edit:** `install.sh`, `install.ps1`

---

### Issue #6: Add `flash validate-cache` Command
**Labels:** `enhancement`, `component: cache`

Add command to validate cache integrity and show what's cached.

**Usage:**
```bash
flash validate-cache
```

**Files to edit:** `install.sh`, `install.ps1`

---

## 🔴 Advanced (5-10 hours)

### Issue #7: Add Automated Tests
**Labels:** `enhancement`, `component: ci/cd`

Create test scripts to verify:
- Installation works
- Cache export/import works
- Commands work correctly

**Files to create:** `tests/` directory with test scripts

---

### Issue #8: Add Poetry/Pipenv Detection
**Labels:** `enhancement`, `component: install`

Detect existing Poetry/Pipenv installations and offer migration guide.

**Files to edit:** `install.sh`, `install.ps1`

---

### Issue #9: Add `flash import-url` Command
**Labels:** `enhancement`, `component: cache`

Add command to download and import cache from URL in one step.

**Usage:**
```bash
flash import-url https://github.com/.../flash-cache.tar.zst
```

**Files to edit:** `install.sh`, `install.ps1`

---

## 📋 How to Claim an Issue

1. Comment on the issue: "I'd like to work on this!"
2. Wait for maintainer to assign it to you
3. Fork the repo
4. Create a branch: `git checkout -b fix-issue-X`
5. Make your changes
6. Test thoroughly
7. Submit a Pull Request

## 🤝 Need Help?

- Ask questions in the issue comments
- Join our [Discussions](https://github.com/Yogesh1290/flash-pkg/discussions)
- Read [CONTRIBUTING.md](../CONTRIBUTING.md)

## 🎉 After Your First Contribution

- You'll be added to contributors list
- You'll get a shoutout in release notes
- You'll have helped make dev setup faster for everyone!

---

**Ready to contribute? Pick an issue and let's go!** 🚀
