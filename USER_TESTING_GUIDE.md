# Real User Testing Guide - flash-pkg

## Purpose
Test flash-pkg from scratch as a real user following the README instructions exactly.

---

## Prerequisites

Before starting, make sure you have:
- [ ] Windows with VS Code installed
- [ ] Internet connection
- [ ] Fresh terminal (no flash-pkg installed yet)

---

## Test 1: Installation (Windows PowerShell)

### Step 1: Open PowerShell in VS Code
1. Open VS Code
2. Press `` Ctrl + ` `` to open terminal
3. Make sure it says "PowerShell" in the dropdown (not CMD or Git Bash)

### Step 2: Run Installation Command
Copy and paste this EXACT command from README:

```powershell
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
```

**Expected output:**
- Should download and install uv
- Should download and install Bun
- Should create flash command
- Should take 10-30 seconds

**✅ Success criteria:**
- No errors
- See "Installation complete!" message

### Step 3: Reload Profile
```powershell
. $PROFILE
```

### Step 4: Verify Installation
```powershell
flash
```

**Expected output:**
- Should show flash-pkg help/commands
- Should NOT say "command not found"

**✅ Success criteria:**
- flash command works

---

## Test 2: Create Simple Python ML Project

### Step 1: Create New Project Directory
```powershell
cd ~
mkdir test-flash-ml
cd test-flash-ml
```

### Step 2: Create requirements.txt
Create a file called `requirements.txt` with this content:

```txt
numpy==1.26.4
pandas==2.2.0
scikit-learn==1.4.0
matplotlib==3.8.2
```

**How to create:**
1. In VS Code, click File > New File
2. Paste the content above
3. Save as `requirements.txt` in `test-flash-ml` folder

### Step 3: Create main.py
Create a file called `main.py` with this content:

```python
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

print("✅ All imports successful!")
print(f"NumPy version: {np.__version__}")
print(f"Pandas version: {pd.__version__}")

# Simple test
X = np.array([[1], [2], [3], [4], [5]])
y = np.array([2, 4, 6, 8, 10])

model = LinearRegression()
model.fit(X, y)

print(f"Model coefficient: {model.coef_[0]:.2f}")
print("✅ ML test passed!")
```

**How to create:**
1. In VS Code, click File > New File
2. Paste the content above
3. Save as `main.py` in `test-flash-ml` folder

### Step 4: Create Virtual Environment
```powershell
uv venv
```

**Expected output:**
- Creates `.venv` folder
- Takes 1-2 seconds

**✅ Success criteria:**
- `.venv` folder appears in your directory

### Step 5: Install Dependencies (First Time - No Cache)
```powershell
uv pip install -r requirements.txt
```

**Expected output:**
- Downloads packages from internet
- Takes 30-120 seconds (depending on internet speed)
- Shows progress bars

**✅ Success criteria:**
- All packages installed successfully
- No errors

**⏱️ Record the time:** __________ seconds

### Step 6: Run the Test
```powershell
uv run python main.py
```

**Expected output:**
```
✅ All imports successful!
NumPy version: 1.26.4
Pandas version: 2.2.0
Model coefficient: 2.00
✅ ML test passed!
```

**✅ Success criteria:**
- Script runs without errors
- Shows all success messages

---

## Test 3: Test Cache Speed (Second Project)

### Step 1: Create Another Project
```powershell
cd ~
mkdir test-flash-ml-2
cd test-flash-ml-2
```

### Step 2: Copy requirements.txt
Copy the same `requirements.txt` from previous project:

```txt
numpy==1.26.4
pandas==2.2.0
scikit-learn==1.4.0
matplotlib==3.8.2
```

### Step 3: Create Virtual Environment
```powershell
uv venv
```

### Step 4: Install Dependencies (From Cache)
```powershell
uv pip install -r requirements.txt
```

**Expected output:**
- Should be MUCH faster than first time
- Should say "Using cached" for packages
- Takes 10-60 seconds (depending on WSL/native)

**✅ Success criteria:**
- Installs successfully
- Much faster than first time

**⏱️ Record the time:** __________ seconds

**Compare:**
- First install: __________ seconds
- Second install: __________ seconds
- Speedup: __________x faster

---

## Test 4: Bootstrap ML Packages (Optional - Heavy)

**⚠️ WARNING:** This downloads 2+ GB of packages. Only do this if you have:
- Good internet connection
- Time (2-5 minutes)
- Disk space (2+ GB)

### Step 1: Run Bootstrap
```powershell
flash bootstrap-ml
```

**Expected output:**
- Downloads torch, paddleocr, transformers, etc.
- Takes 2-5 minutes
- Shows progress

**✅ Success criteria:**
- Completes without errors
- Shows "Bootstrap complete!" message

**⏱️ Record the time:** __________ minutes

---

## Test 5: Export and Import Cache

### Step 1: Export Cache
```powershell
cd ~
flash export-cache
```

**Expected output:**
- Creates `flash-cache-YYYYMMDD-HHMMSS.tar.zst` file
- File size: 450-500 MB (or larger if you did bootstrap)
- Takes 30-60 seconds

**✅ Success criteria:**
- File created successfully
- File size is reasonable

**⏱️ Record the time:** __________ seconds
**📦 File size:** __________ MB

### Step 2: Simulate Fresh Machine (Delete Cache)
```powershell
# Backup the export first!
# Then delete cache
Remove-Item -Recurse -Force ~/.cache/uv
```

**⚠️ WARNING:** This deletes your cache. Make sure you have the export file!

### Step 3: Import Cache
```powershell
flash import-cache flash-cache-*.tar.zst
```

**Expected output:**
- Extracts cache
- Takes 10-30 seconds
- Shows progress

**✅ Success criteria:**
- Imports successfully
- Cache restored

**⏱️ Record the time:** __________ seconds

### Step 4: Verify Cache Works
```powershell
cd ~/test-flash-ml-2
Remove-Item -Recurse -Force .venv
uv venv
uv pip install -r requirements.txt
```

**Expected output:**
- Should be fast again (using imported cache)
- Takes 10-60 seconds

**✅ Success criteria:**
- Installs successfully from imported cache

---

## Test 6: JavaScript/Bun (Optional)

### Step 1: Create React Project
```powershell
cd ~
flash mern test-react-app
cd test-react-app
```

**Expected output:**
- Creates React project with Vite + TypeScript
- Takes 5-10 seconds

### Step 2: Install Dependencies
```powershell
bun install
```

**Expected output:**
- Installs 178+ packages
- Takes 30-120 seconds (first time)

**✅ Success criteria:**
- All packages installed
- `node_modules` folder created

**⏱️ Record the time:** __________ seconds

### Step 3: Test Cache (Second Project)
```powershell
cd ~
flash mern test-react-app-2
cd test-react-app-2
bun install
```

**Expected output:**
- Should be faster (using cache)
- Takes 20-60 seconds

**✅ Success criteria:**
- Installs successfully
- Faster than first time

**⏱️ Record the time:** __________ seconds

---

## Results Summary

Fill this out after completing all tests:

### Installation
- [ ] PowerShell install worked
- [ ] flash command works
- Time: __________ seconds

### Python ML Project
- [ ] First install worked
- [ ] Second install was faster
- First install time: __________ seconds
- Second install time: __________ seconds
- Speedup: __________x

### Cache Export/Import
- [ ] Export worked
- [ ] Import worked
- Export time: __________ seconds
- Export size: __________ MB
- Import time: __________ seconds

### JavaScript/Bun (Optional)
- [ ] React project created
- [ ] First install worked
- [ ] Second install was faster
- First install time: __________ seconds
- Second install time: __________ seconds

### Overall Experience
- [ ] Everything worked as documented
- [ ] Setup was easy
- [ ] Performance was good
- [ ] Would recommend to others

### Issues Encountered (if any)
Write any problems you faced:

```
[Write here]
```

### Suggestions for Improvement
Write any ideas to make it better:

```
[Write here]
```

---

## Troubleshooting

### Issue: "flash command not found"
**Solution:**
```powershell
. $PROFILE
# Or close and reopen terminal
```

### Issue: "uv not found"
**Solution:**
```powershell
# Reinstall
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
```

### Issue: Install is slow
**Expected:** First install is always slow (downloading from internet)
**Check:** Second install should be much faster

### Issue: "Permission denied"
**Solution:** Run PowerShell as Administrator

### Issue: Bun not working
**Solution:**
```powershell
# Check if Bun is installed
bun --version

# If not, reinstall flash-pkg
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
```

---

## Success Criteria Checklist

Mark each as you complete:

- [ ] Installation completed without errors
- [ ] flash command works
- [ ] Created Python ML project
- [ ] First install worked (slow, expected)
- [ ] Second install was 2-10x faster
- [ ] Cache export worked
- [ ] Cache import worked
- [ ] Imported cache works for new installs
- [ ] (Optional) JavaScript/Bun project worked
- [ ] Overall experience matches README promises

---

## Final Notes

**If everything worked:**
- ✅ flash-pkg is working correctly!
- ✅ README instructions are accurate
- ✅ Ready for production use

**If something failed:**
- Document the issue in "Issues Encountered" section
- Check Troubleshooting section
- Open GitHub issue with details

---

**Testing Date:** __________  
**Tester Name:** __________  
**Windows Version:** __________  
**VS Code Version:** __________  
**Internet Speed:** __________ Mbps

---

## Quick Reference Commands

```powershell
# Install
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex

# Reload
. $PROFILE

# Create project
cd ~
mkdir my-project
cd my-project

# Create venv
uv venv

# Install packages
uv pip install -r requirements.txt

# Run Python
uv run python main.py

# Export cache
flash export-cache

# Import cache
flash import-cache flash-cache-*.tar.zst

# JavaScript
flash mern my-app
cd my-app
bun install
```

---

**Good luck with testing! 🚀**
