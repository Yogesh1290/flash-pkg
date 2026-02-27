# Windows Guide for flash-pkg

## Installation Options

### Option 1: Native Windows PowerShell (v1.1.1+) ⭐ Recommended

**Install in PowerShell:**
```powershell
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
. $PROFILE
```

**Features:**
- ✅ Native Windows support (no WSL needed)
- ✅ Uses .zip format for cache (Windows-native)
- ✅ All flash commands work
- ✅ Auto-installs uv and Bun
- ✅ Mirror selection and proxy detection

**Test it works:**
```powershell
flash
flash bootstrap-ml
```

### Option 2: Windows WSL (Linux subsystem)

**Install WSL first:**
```powershell
# In PowerShell (as Administrator)
wsl --install
# Restart your computer
```

**Then install flash-pkg in WSL:**
```bash
# In WSL terminal
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
source ~/.bashrc
```

**Test it works:**
```bash
cd test-examples
bash quick-test.sh
```

## Which Should I Use?

| Feature | PowerShell | WSL |
|---------|-----------|-----|
| Setup complexity | Simple | Requires WSL install |
| Performance | Native | Excellent |
| Cache format | .zip | .tar.zst |
| Install time | 10-30s | 60s (filesystem limitation) |
| Recommendation | ✅ Best for most users | ✅ If you need Linux tools |

## Native Windows PowerShell Guide

### Quick Start

1. **Install:**
   ```powershell
   irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
   . $PROFILE
   ```

2. **Bootstrap once (on good WiFi):**
   ```powershell
   flash bootstrap-ml
   ```

3. **Create projects:**
   ```powershell
   flash ml my-ai-project
   cd my-ai-project
   uv add numpy pandas scikit-learn
   ```

### Cache Sharing (Windows)

**Export cache:**
```powershell
flash export-cache
# Creates: flash-cache-20260227.zip
```

**Import cache:**
```powershell
flash import-cache flash-cache-20260227.zip
```

**Share with team:**
- Upload to Google Drive, OneDrive, or GitHub Release
- Team downloads and imports
- Everyone gets instant setup!

### Common Commands

```powershell
flash ml <name>              # Create Python ML project
flash mern <name>            # Create MERN app
flash bootstrap-ml           # Pre-cache ML packages
flash export-cache           # Export cache to .zip
flash import-cache <file>    # Import cache from .zip
flash sbom                   # Generate SBOM
```

## Windows WSL Guide

## WSL-Specific Optimizations (v1.1.1)

### Export Cache (Now 10x Faster!)

**Before v1.1.1:**
```bash
flash export-cache
# ⏳ 5-10 minutes (painful!)
```

**After v1.1.1:**
```bash
flash export-cache
# ⚠️  WSL detected: Using optimized compression for Windows filesystem
# ⚡ 30-90 seconds (10x faster!)
```

### What Changed?

1. **Auto-detection**: Automatically detects WSL environment
2. **Hardlink fix**: Uses `--dereference` to avoid WSL filesystem issues
3. **Faster compression**: Uses level 10 instead of 19 (still excellent!)
4. **Result**: 5-10 minutes → 30-90 seconds

### File Sizes

| Platform | Compression | Time | File Size |
|----------|-------------|------|-----------|
| Linux/Mac | Level 19 | 30-60s | 400-500 MB |
| WSL | Level 10 | 30-90s | 500-700 MB |

**Trade-off**: Slightly larger file (20-30%) but 10x faster!

## Common WSL Issues & Solutions

### Issue 1: Slow installs (56 seconds instead of 30)

**Why?**
- WSL can't create hardlinks across filesystems
- uv copies files instead of hardlinking
- Still 16x faster than downloading!

**Solution:**
- This is expected behavior on WSL
- 56 seconds is still excellent!
- On native Linux it would be 10-20 seconds

### Issue 2: Cache location

**WSL path:** `/home/username/.cache/uv`  
**Windows path:** `\\wsl$\Ubuntu\home\username\.cache\uv`

You can access WSL files from Windows Explorer:
```
\\wsl$\Ubuntu\home\username\.cache\uv
```

### Issue 3: Disk space

WSL uses a virtual disk (ext4.vhdx) that grows dynamically:
- Default max: 256 GB (WSL 1) or 1 TB (WSL 2)
- Cache size: ~1-2 GB for ML setup
- Check size: `du -sh ~/.cache/uv`

### Issue 4: Performance

**Tips for better performance:**
1. Store projects in WSL filesystem (`/home/username/projects`)
2. Don't store in Windows filesystem (`/mnt/c/Users/...`)
3. Use WSL 2 (faster than WSL 1)
4. Enable WSL 2: `wsl --set-version Ubuntu 2`

## Sharing Cache Between Windows and WSL

### Option 1: Export/Import (Recommended)

```bash
# In WSL
flash export-cache
# Creates: flash-cache-20260227.tar.zst (~600 MB)

# Copy to Windows
cp flash-cache-20260227.tar.zst /mnt/c/Users/YourName/Downloads/

# On another WSL instance or machine
flash import-cache /mnt/c/Users/YourName/Downloads/flash-cache-20260227.tar.zst
```

### Option 2: Direct Copy (Not Recommended)

```bash
# Backup cache
tar -czf cache-backup.tar.gz ~/.cache/uv

# Copy to Windows
cp cache-backup.tar.gz /mnt/c/Users/YourName/Downloads/

# On another WSL instance
tar -xzf /mnt/c/Users/YourName/Downloads/cache-backup.tar.gz -C ~/
```

**Why Option 1 is better:**
- 5x smaller file (600 MB vs 2 GB)
- Faster transfer
- Optimized for WSL

## WSL vs Native Windows PowerShell

| Feature | WSL | Native PowerShell |
|---------|-----|-------------------|
| flash-pkg support | ✅ Full (v1.1.1) | ✅ Full (v1.1.1) |
| Performance | Excellent | Native |
| Cache format | .tar.zst | .zip |
| Cache sharing | ✅ Optimized | ✅ Native |
| Setup time | 60s (filesystem) | 10-30s |
| Recommendation | Linux tools needed | ✅ Most users |

## Troubleshooting

### Check WSL version
```bash
wsl -l -v
# Should show: VERSION 2
```

### Upgrade to WSL 2
```powershell
# In PowerShell (as Administrator)
wsl --set-version Ubuntu 2
```

### Check disk usage
```bash
# In WSL
df -h
du -sh ~/.cache/uv
```

### Clean cache if needed
```bash
# Free up space
uv cache clean
# or
rm -rf ~/.cache/uv
```

### Reinstall if broken
```bash
# Remove old installation
rm -rf ~/.local/bin/uv ~/.cargo/bin/uv

# Reinstall
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
source ~/.bashrc
```

## Performance Benchmarks (WSL)

### Test Environment
- Windows 11 + WSL 2 (Ubuntu 22.04)
- 10 Mbps internet
- Intel i5 / 16 GB RAM

### Results

| Task | First Time | After Cache | Speedup |
|------|-----------|-------------|---------|
| Simple ML | 45 sec | 15 sec | 3x |
| Heavy ML | 45 min | 60 sec | 45x |
| Export cache | 33 sec | - | - |
| Import cache | 19 sec | - | - |

## Best Practices for WSL

1. **Store projects in WSL filesystem**
   ```bash
   # Good
   cd ~/projects
   
   # Bad (slow)
   cd /mnt/c/Users/YourName/projects
   ```

2. **Use WSL 2 (not WSL 1)**
   ```bash
   wsl --set-version Ubuntu 2
   ```

3. **Bootstrap once on good WiFi**
   ```bash
   flash bootstrap-ml
   # Then export and share with team
   flash export-cache
   ```

4. **Share cache with team**
   ```bash
   # Upload to Google Drive / GitHub Release
   # Team downloads and imports
   flash import-cache flash-cache.tar.zst
   ```

5. **Clean cache periodically**
   ```bash
   # Check size
   du -sh ~/.cache/uv
   
   # Clean if too large
   uv cache clean
   ```

## FAQ for WSL Users

**Q: Why is export-cache faster now?**  
A: v1.1.1 auto-detects WSL and uses optimized settings (--dereference + level 10 compression)

**Q: Is the file larger on WSL?**  
A: Yes, 500-700 MB vs 400-500 MB on Linux. Still excellent compression!

**Q: Can I use the same cache file on Linux and WSL?**  
A: Yes! Cache files are cross-platform compatible.

**Q: Should I use WSL 1 or WSL 2?**  
A: WSL 2 is faster and recommended.

**Q: Can I access WSL files from Windows?**  
A: Yes, use `\\wsl$\Ubuntu\home\username\` in Windows Explorer

**Q: Why is my install 56 seconds instead of 30?**  
A: WSL filesystem limitation. Still 16x faster than downloading!

## Next Steps

1. ✅ Install flash-pkg in WSL
2. ✅ Test with quick-test.sh
3. ✅ Bootstrap ML packages
4. ✅ Export cache (now fast!)
5. ✅ Share with team
6. 🚀 Build amazing projects!

**Questions?** See [FAQ.md](FAQ.md) or open an issue on GitHub.

---

**flash-pkg v1.1.1** — Now with native Windows PowerShell support! 🚀
