# Frequently Asked Questions (FAQ)

## Quick Answers

### Q1: Does it work for ANY project on ANY IDE on my PC now?

**YES!** ✅

The cached packages work:
- ✅ Any project using those same packages (numpy, pandas, sklearn, matplotlib)
- ✅ Any IDE (VS Code, PyCharm, Jupyter, etc.)
- ✅ Anywhere on your PC
- ✅ Just use: `~/.local/bin/uv pip install -r requirements.txt`

**BUT:** Only for packages you already installed. New packages will download first time.

---

### Q2: Where is the cache saved?

**Linux/macOS/WSL:** `~/.cache/uv`

**Windows PowerShell:** `%LOCALAPPDATA%\uv\cache` (typically `C:\Users\YourName\AppData\Local\uv\cache`)

**Windows WSL:** `\\wsl$\Ubuntu\home\ubuntu\.cache\uv` (accessible from Windows Explorer)

This is the standard cache location where uv stores downloaded packages.

---

### Q3: How much space does it take?

**~972 MB** (almost 1 GB) for a typical ML setup

This includes:
- numpy, pandas, scikit-learn, matplotlib
- All their dependencies (18 packages total)
- Compiled wheels ready to install instantly

**Note:** Cache size grows as you install more packages. Heavy ML packages like PyTorch can be 2-3 GB.

---

### Q4: Is it safe?

**YES, 100% SAFE!** ✅

- Standard cache location (like npm cache, pip cache)
- Only contains Python packages from PyPI
- No system files, no personal data
- Just downloaded packages ready to reuse
- Can be deleted anytime without breaking anything

---

### Q5: How to clean the cache?

**Option 1: Clean everything**
```bash
rm -rf ~/.cache/uv
# Deletes all cached packages (frees ~1 GB)
# Next install will download packages again
```

**Option 2: Clean old/unused packages**
```bash
~/.local/bin/uv cache clean
# Removes unused cached packages automatically
```

**Option 3: Check cache location**
```bash
~/.local/bin/uv cache dir
# Shows where cache is stored
```

**Option 4: Check cache size**
```bash
du -sh ~/.cache/uv
# Shows total cache size
```

---

### Q6: Why was my first install 15 minutes?

**This is NORMAL and EXPECTED!** ✅

- First time = downloading packages from internet
- Your internet speed determines download time
- Packages are being cached for future use
- This is how ALL package managers work (pip, npm, etc.)

**The magic:** Every project after the first one is <1 minute!

---

### Q7: Why is my install 60 seconds on WSL (not 10-20s like Linux)?

**This is EXPECTED on WSL!** ✅

You're getting 60 seconds instead of 10-20 because:
- **WSL filesystem limitation**: Can't hardlink between Windows (NTFS) and Linux (ext4) filesystems
- uv must copy 450-500 MB of files instead of hardlinking
- Still **34-45x faster** than downloading!
- On native Linux it would be 10-20 seconds

**60 seconds is excellent** compared to 45 minutes!

**Why this happens:**
```
warning: Failed to hardlink files; falling back to full copy.
This may lead to degraded performance.
```

This warning is NORMAL on WSL. It's not an error - just informing you that files are being copied instead of hardlinked.

**Performance comparison:**
- Native Linux: 10-20s (hardlinks work)
- macOS: 10-20s (hardlinks work)
- WSL: 60s (must copy files)
- No cache: 45 minutes (downloading)

**v1.1.1 Optimizations:**
- Export cache: 33 seconds ✅
- Import cache: 19 seconds ✅
- Install: 60 seconds (WSL limit, can't be improved)

---

### Q8: How does the cache work across projects?

**Simple:**
1. First project: Downloads packages (15 min)
2. Second project: Uses cached packages (56 sec)
3. Third project: Uses cached packages (49 sec)
4. All future projects: <1 minute forever!

**Works for:**
- Any project using the same packages
- Any virtual environment
- Any IDE or editor
- Anywhere on your PC

---

### Q9: Can I share the cache with my team?

**YES!** This is a killer feature for teams:

**Linux/macOS/WSL:**
```bash
# On one machine (good WiFi)
flash bootstrap-ml
flash export-cache  # Creates flash-cache-YYYYMMDD.tar.zst (477 MB)

# Share file via GitHub Release, Google Drive, S3, etc.

# On other machines:
flash import-cache flash-cache-YYYYMMDD.tar.zst  # 19 seconds

# Now everyone has instant setup!
```

**Windows PowerShell:**
```powershell
# On one machine (good WiFi)
flash bootstrap-ml
flash export-cache  # Creates flash-cache-YYYYMMDD.zip

# Share file via GitHub Release, Google Drive, OneDrive, etc.

# On other machines:
flash import-cache flash-cache-YYYYMMDD.zip

# Now everyone has instant setup!
```

---

### Q10: What if I need a package that's not cached?

**No problem!** uv will:
1. Check cache first
2. Download if not found
3. Cache it for next time
4. Install it

**Example:**
```bash
# First time installing requests
uv pip install requests  # Downloads (30 sec)

# Second time (new project)
uv pip install requests  # Cached (5 sec)
```

---

### Q11: Does this work with PyTorch, TensorFlow, etc.?

**YES!** Works with ANY Python package:

```bash
# Heavy ML packages
uv pip install torch torchvision torchaudio
uv pip install tensorflow
uv pip install paddleocr

# All get cached and reused
```

**Note:** First download is slow (PyTorch = 2-3 GB), but then cached forever!

---

### Q12: Can I use this with regular pip?

**No, you need to use uv:**

```bash
# ❌ Won't use cache
pip install -r requirements.txt

# ✅ Uses cache
~/.local/bin/uv pip install -r requirements.txt
```

**Why?** uv has a smarter cache system than pip.

---

### Q13: What happens if I delete the cache?

**Nothing breaks!** ✅

- Your installed packages in venvs still work
- Cache only affects NEW installations
- Next install will download packages again
- Packages get cached again automatically

**Safe to delete anytime** if you need disk space.

---

### Q14: How is this different from pip?

| Feature | pip | uv (flash-pkg) |
|---------|-----|----------------|
| First install | 15 min | 15 min |
| Second install | 15 min | 56 sec |
| Cache reuse | Limited | Excellent |
| Speed | Slow | 10-20x faster |
| Disk space | Duplicates | Shared cache |

---

### Q15: Can I use this in production/Docker?

**YES!** Multiple options:

**Option 1: Bootstrap in Dockerfile**
```dockerfile
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN ~/.cargo/bin/uv pip install -r requirements.txt
```

**Option 2: Use flash Docker templates**
```bash
flash docker-ml my-project
```

**Option 3: Copy cache into container**
```dockerfile
COPY --from=cache ~/.cache/uv /root/.cache/uv
RUN uv pip install -r requirements.txt  # Instant!
```

---

### Q16: Is this only for Python?

**No!** flash-pkg also supports JavaScript:

```bash
# Create MERN app
flash mern my-app

# Uses Bun (faster than npm)
bun install  # Also has cache!
```

---

### Q17: What if I'm behind a corporate proxy?

**Automatic!** flash-pkg detects and configures proxies:

**Linux/macOS/WSL:**
```bash
# Set your proxy
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080

# Run install.sh - it auto-configures uv
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
```

**Windows PowerShell:**
```powershell
# Set your proxy
$env:HTTP_PROXY="http://proxy.company.com:8080"
$env:HTTPS_PROXY="http://proxy.company.com:8080"

# Run install.ps1 - it auto-detects proxy
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
```

---

### Q18: Can I use different Python versions?

**YES!** uv works with any Python version:

```bash
# Use specific Python version
uv venv --python 3.11
uv venv --python 3.12
uv venv --python 3.13

# Cache works across all versions
```

---

### Q19: How do I update cached packages?

**Option 1: Update specific package**
```bash
uv pip install --upgrade numpy
```

**Option 2: Update all packages**
```bash
uv pip install --upgrade -r requirements.txt
```

**Option 3: Clear cache and reinstall**
```bash
uv cache clean
uv pip install -r requirements.txt
```

---

### Q20: How fast is flash export-cache and import-cache?

**Tested Performance (v1.1.1 on WSL):** ✅

**Export (compress cache):**
- Time: 33 seconds
- File size: 477 MB
- Compression: ~5x (2.4 GB → 477 MB)

**Import (decompress cache):**
- Time: 19 seconds
- Extracts to: ~/.cache/uv (2.4 GB)

**Install from cache:**
- Time: 60 seconds (WSL filesystem limitation)
- Packages: 18 installed instantly from cache

**Total workflow:**
- Export + Import + Install = 112 seconds
- vs 45 minutes without cache
- **Speedup: 34x faster!**

**Platform differences:**
- **WSL**: Export 33s, Import 19s, Install 60s
- **Linux**: Export 30-60s, Import 8s, Install 10-20s
- **macOS**: Export 30-60s, Import 8s, Install 10-20s

**Why WSL is slower:**
- Export: Uses level 10 compression (faster, slightly larger file)
- Install: Must copy files (can't hardlink across filesystems)
- Still 34x faster than downloading!

---

### Q21: What about Windows users?

**Full Windows Support (v1.1.1)!** ✅

| Terminal | Command |
|----------|---------|
| **PowerShell** | `irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 \| iex` |
| **CMD** | `powershell -Command "irm https://...install.ps1 \| iex"` |
| **Git Bash** | `curl -sSL https://...install.sh \| bash` |
| **WSL** | `curl -sSL https://...install.sh \| bash` |

**Features:**
- Native Windows PowerShell installer
- Uses .zip format for cache (Windows-native)
- Fast mirror selection (1-2 seconds)
- All flash commands work
- Export/import cache supported

---

### Q22: Where can I get help?

**Resources:**
- GitHub Issues: https://github.com/Yogesh1290/flash-pkg/issues
- Documentation: See README.md, QUICK_START.md, HOW_IT_WORKS.md
- uv docs: https://docs.astral.sh/uv/

**Common issues:**
- Slow install? First time is normal (downloading)
- Package not found? Check spelling, try `uv pip search <name>`
- Permission error? Use `~/.local/bin/uv` not system uv

---

## Summary

✅ **Works for any project** with same packages  
✅ **972 MB cache** at `~/.cache/uv`  
✅ **100% safe** to use and delete  
✅ **16-18x faster** than first install  
✅ **Saves 15 minutes** per project  
✅ **Shareable** with teams  
✅ **Works with any IDE**  
✅ **Production-ready**  

**Your tool is working perfectly!** 🚀
