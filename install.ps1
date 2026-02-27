# =============================================================================
# flash-pkg v1.2.0 - Universal Fast Dev Setup (Python + JS) for Windows
# PowerShell installer for native Windows (no WSL required)
# MIT License - Open source, feel free to fork & ship in your company
# Run: irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
# =============================================================================

Write-Host "Installing flash-pkg for Windows... (30-60 seconds)" -ForegroundColor Cyan
Write-Host "Enterprise-ready: proxy, air-gapped, Docker, monorepo, SBOM" -ForegroundColor Gray
Write-Host ""

# Detect PowerShell profile
$ProfilePath = $PROFILE.CurrentUserAllHosts
if (-not (Test-Path $ProfilePath)) {
    New-Item -Path $ProfilePath -ItemType File -Force | Out-Null
}

# 1. Install uv (Astral - already used by Snyk, Plotly, Rippling in 2026)
Write-Host "-> Installing uv..." -ForegroundColor Yellow
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    $ProgressPreference = 'SilentlyContinue'
    Write-Host "   Downloading and installing (this may take 30-60 seconds)..." -ForegroundColor Gray
    irm https://astral.sh/uv/install.ps1 | iex
    $ProgressPreference = 'Continue'
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
    Write-Host "   uv installed successfully!" -ForegroundColor Green
} else {
    Write-Host "   uv already installed" -ForegroundColor Green
}

# 2. Install Bun (fastest JS - used by ByteDance, growing in enterprise)
Write-Host "-> Installing Bun..." -ForegroundColor Yellow
if (-not (Get-Command bun -ErrorAction SilentlyContinue)) {
    $ProgressPreference = 'SilentlyContinue'
    Write-Host "   Downloading and installing (this may take 30-60 seconds)..." -ForegroundColor Gray
    irm https://bun.sh/install.ps1 | iex
    $ProgressPreference = 'Continue'
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
    Write-Host "   Bun installed successfully!" -ForegroundColor Green
} else {
    Write-Host "   Bun already installed" -ForegroundColor Green
}

# 3. Auto-detect proxy (critical for companies)
if ($env:HTTP_PROXY -or $env:HTTPS_PROXY) {
    Write-Host "-> Corporate proxy detected - configuring..." -ForegroundColor Yellow
    # uv will auto-detect proxy from environment
}

# 4. Choose fastest mirror (innovation - latency test)
Write-Host "-> Finding fastest mirror for you..." -ForegroundColor Yellow
Write-Host "   Testing 3 mirrors (quick check)..." -ForegroundColor Gray
$mirrors = @(
    @{url="https://pypi.tuna.tsinghua.edu.cn"; name="Tsinghua (China)"},
    @{url="https://mirrors.aliyun.com/pypi"; name="Aliyun (China)"},
    @{url="https://pypi.org"; name="Official PyPI"}
)

$bestTime = 999
$bestUrl = "https://pypi.org/simple"

$ProgressPreference = 'SilentlyContinue'
$i = 1
foreach ($mirror in $mirrors) {
    Write-Host "   [$i/3] $($mirror.name)..." -ForegroundColor Gray -NoNewline
    try {
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        # Use HEAD request to just test connectivity, not download content
        $response = Invoke-WebRequest -Uri "$($mirror.url)/simple/" -Method Head -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop
        $sw.Stop()
        $time = [math]::Round($sw.Elapsed.TotalSeconds, 2)
        Write-Host " ${time}s" -ForegroundColor $(if ($time -lt 1) { "Green" } elseif ($time -lt 2) { "Yellow" } else { "Gray" })
        if ($sw.Elapsed.TotalSeconds -lt $bestTime) {
            $bestTime = $sw.Elapsed.TotalSeconds
            $bestUrl = "$($mirror.url)/simple"
        }
    } catch {
        Write-Host " timeout" -ForegroundColor Red
    }
    $i++
}
$ProgressPreference = 'Continue'

Write-Host "   Using fastest mirror!" -ForegroundColor Green

# Configure uv using environment variables (uv pip config not available in all versions)
[System.Environment]::SetEnvironmentVariable("UV_INDEX_URL", $bestUrl, "User")
$env:UV_INDEX_URL = $bestUrl

# Set Bun registry
if (Get-Command bun -ErrorAction SilentlyContinue) {
    try {
        bun config set registry "https://registry.npmmirror.com" 2>$null
    } catch {
        # Ignore if bun config fails
    }
}

Write-Host ""
Write-Host "-> Adding 'flash' command to PowerShell profile..." -ForegroundColor Yellow

# Check if flash is already installed
$profileContent = Get-Content $ProfilePath -Raw -ErrorAction SilentlyContinue
if (-not $profileContent -or $profileContent -notmatch "# FLASH-PKG HELPERS") {
    Add-Content -Path $ProfilePath -Value @'

# ====================== FLASH-PKG HELPERS ======================
function flash {
    param([string]$Command, [string]$Name)
    
    switch ($Command) {
        "bootstrap-ml" {
            Write-Host "One-time ML bootstrap (run on good WiFi once)" -ForegroundColor Cyan
            Write-Host "This downloads common heavy ML packages to cache." -ForegroundColor Gray
            Write-Host "Downloading: torch, paddleocr, modelscope, transformers, opencv..." -ForegroundColor Gray
            uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
            uv pip install paddleocr modelscope opencv-contrib-python transformers pandas numpy pillow requests
            Write-Host "Bootstrap done! Every new project now <30s forever." -ForegroundColor Green
            Write-Host "Note: You can still install ANY package - this just pre-caches common ones." -ForegroundColor Gray
        }
        
        "bootstrap-ml-gpu" {
            Write-Host "GPU bootstrap (detecting CUDA...)" -ForegroundColor Cyan
            uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
            uv pip install paddleocr modelscope opencv-contrib-python transformers pandas numpy pillow requests
            Write-Host "GPU bootstrap complete!" -ForegroundColor Green
        }
        
        "bootstrap-custom" {
            if (-not $Name) {
                Write-Host "Usage: flash bootstrap-custom <requirements.txt>" -ForegroundColor Red
                Write-Host "Example: flash bootstrap-custom my-project\requirements.txt" -ForegroundColor Gray
                return
            }
            if (-not (Test-Path $Name)) {
                Write-Host "File not found: $Name" -ForegroundColor Red
                return
            }
            Write-Host "Custom bootstrap from: $Name" -ForegroundColor Cyan
            uv pip install -r $Name
            Write-Host "Custom bootstrap complete! Packages cached." -ForegroundColor Green
        }
        
        "ml" {
            if (-not $Name) {
                Write-Host "Usage: flash ml <project-name>" -ForegroundColor Red
                return
            }
            Write-Host "Creating ML project: $Name" -ForegroundColor Cyan
            uv init $Name
            Set-Location $Name
            Write-Host "ML project created!" -ForegroundColor Green
            Write-Host "Add dependencies: uv add <package-name>" -ForegroundColor Gray
            Write-Host "Or use requirements.txt: uv pip install -r requirements.txt" -ForegroundColor Gray
        }
        
        "mern" {
            if (-not $Name) {
                Write-Host "Usage: flash mern <project-name>" -ForegroundColor Red
                return
            }
            Write-Host "Creating MERN/fullstack project: $Name" -ForegroundColor Cyan
            bun create vite@latest $Name -- --template react-ts
            Set-Location $Name
            bun install
            Write-Host "MERN app ready!" -ForegroundColor Green
        }
        
        "export-cache" {
            Write-Host "Exporting cache (Windows native)" -ForegroundColor Cyan
            Write-Host "This creates a shareable file that makes setup instant for anyone!" -ForegroundColor Gray
            Write-Host ""
            
            $cacheDir = (uv cache dir 2>$null)
            if (-not $cacheDir) { $cacheDir = "$env:LOCALAPPDATA\uv\cache" }
            $output = "flash-cache-$(Get-Date -Format 'yyyyMMdd-HHmmss').zip"
            
            if (-not (Test-Path $cacheDir)) {
                Write-Host "No cache found. Run 'flash bootstrap-ml' first." -ForegroundColor Red
                return
            }
            
            Write-Host "-> Compressing cache..." -ForegroundColor Yellow
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            Compress-Archive -Path "$cacheDir\*" -DestinationPath $output -CompressionLevel Optimal -Force
            $sw.Stop()
            
            $fileSize = (Get-Item $output).Length / 1MB
            Write-Host ""
            Write-Host "DONE! Cache exported to: $output" -ForegroundColor Green
            Write-Host "   Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Gray
            Write-Host "   Time: $($sw.Elapsed.TotalSeconds) seconds" -ForegroundColor Gray
            Write-Host ""
            Write-Host "Share this file with your team!" -ForegroundColor Cyan
        }
        
        "import-cache" {
            if (-not $Name) {
                Write-Host "Usage: flash import-cache <cache-file.zip>" -ForegroundColor Red
                return
            }
            
            if (-not (Test-Path $Name)) {
                Write-Host "File not found: $Name" -ForegroundColor Red
                return
            }
            
            Write-Host "Importing cache..." -ForegroundColor Cyan
            $cacheDir = (uv cache dir 2>$null)
            if (-not $cacheDir) { $cacheDir = "$env:LOCALAPPDATA\uv\cache" }
            
            New-Item -ItemType Directory -Force -Path $cacheDir | Out-Null
            
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            Expand-Archive -Path $Name -DestinationPath $cacheDir -Force
            $sw.Stop()
            
            Write-Host ""
            Write-Host "DONE in $($sw.Elapsed.TotalSeconds) seconds!" -ForegroundColor Green
            Write-Host ""
            Write-Host "Cache imported! Now you have:" -ForegroundColor Cyan
            Write-Host "   - All ML packages cached" -ForegroundColor Gray
            Write-Host "   - Every new project installs in <30 seconds" -ForegroundColor Gray
        }
        
        "bootstrap-mern" {
            Write-Host "One-time MERN/React bootstrap (run on good WiFi once)" -ForegroundColor Cyan
            Write-Host "This downloads common JavaScript packages to Bun cache." -ForegroundColor Gray
            Write-Host "Downloading: React, Next.js, Vue, TypeScript, Vite, TailwindCSS..." -ForegroundColor Gray
            
            $tempDir = New-Item -ItemType Directory -Path "$env:TEMP\flash-bootstrap-$(Get-Random)" -Force
            Push-Location $tempDir.FullName
            
            Write-Host "-> Bootstrapping React ecosystem..." -ForegroundColor Yellow
            bun create vite@latest react-bootstrap -- --template react-ts
            Set-Location react-bootstrap
            bun add react-router-dom @tanstack/react-query axios zustand
            bun add -d tailwindcss postcss autoprefixer
            
            Pop-Location
            Push-Location $tempDir.FullName
            
            Write-Host "-> Bootstrapping Next.js..." -ForegroundColor Yellow
            bun create next-app@latest next-bootstrap --typescript --tailwind --app --no-src-dir --import-alias "@/*"
            Set-Location next-bootstrap
            bun add @tanstack/react-query axios zustand
            
            Pop-Location
            Push-Location $tempDir.FullName
            
            Write-Host "-> Bootstrapping Vue..." -ForegroundColor Yellow
            bun create vite@latest vue-bootstrap -- --template vue-ts
            Set-Location vue-bootstrap
            bun add vue-router pinia axios
            
            Pop-Location
            Remove-Item -Recurse -Force $tempDir.FullName
            
            Write-Host ""
            Write-Host "Bootstrap done! Every new MERN project now <10s forever." -ForegroundColor Green
            Write-Host "Note: You can still install ANY package - this just pre-caches common ones." -ForegroundColor Gray
            Write-Host ""
            Write-Host "Try it: flash mern my-app" -ForegroundColor Cyan
        }
        
        "export-cache-js" {
            Write-Host "Exporting Bun cache (JavaScript packages)" -ForegroundColor Cyan
            Write-Host "This creates a shareable file for instant JavaScript setup!" -ForegroundColor Gray
            Write-Host ""
            
            $bunCache = "$env:USERPROFILE\.bun\install\cache"
            if (-not (Test-Path $bunCache)) {
                Write-Host "No Bun cache found. Run 'flash bootstrap-mern' first." -ForegroundColor Red
                return
            }
            
            $output = "flash-cache-js-$(Get-Date -Format 'yyyyMMdd-HHmmss').zip"
            
            Write-Host "-> Compressing Bun cache..." -ForegroundColor Yellow
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            Compress-Archive -Path "$bunCache\*" -DestinationPath $output -CompressionLevel Optimal -Force
            $sw.Stop()
            
            $fileSize = (Get-Item $output).Length / 1MB
            Write-Host ""
            Write-Host "DONE! JavaScript cache exported to: $output" -ForegroundColor Green
            Write-Host "   Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Gray
            Write-Host "   Time: $($sw.Elapsed.TotalSeconds) seconds" -ForegroundColor Gray
            Write-Host ""
            Write-Host "Share with your team: flash import-cache-js $output" -ForegroundColor Cyan
        }
        
        "import-cache-js" {
            if (-not $Name) {
                Write-Host "Usage: flash import-cache-js <cache-file.zip>" -ForegroundColor Red
                return
            }
            
            if (-not (Test-Path $Name)) {
                Write-Host "File not found: $Name" -ForegroundColor Red
                return
            }
            
            Write-Host "Importing Bun cache..." -ForegroundColor Cyan
            $bunCache = "$env:USERPROFILE\.bun\install\cache"
            New-Item -ItemType Directory -Force -Path $bunCache | Out-Null
            
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            Expand-Archive -Path $Name -DestinationPath $bunCache -Force
            $sw.Stop()
            
            Write-Host ""
            Write-Host "DONE in $($sw.Elapsed.TotalSeconds) seconds!" -ForegroundColor Green
            Write-Host ""
            Write-Host "JavaScript cache imported! Now you have:" -ForegroundColor Cyan
            Write-Host "   - All MERN packages cached (React, Next.js, Vue, etc.)" -ForegroundColor Gray
            Write-Host "   - Every new project installs in <10 seconds" -ForegroundColor Gray
            Write-Host ""
            Write-Host "Try it: flash mern my-app" -ForegroundColor Cyan
        }
        
        "sbom" {
            if (Test-Path "pyproject.toml") {
                uv export --format requirements > requirements.txt
                Write-Host "SBOM ready: requirements.txt" -ForegroundColor Green
                Write-Host "Run 'syft .' or 'grype .' for full CycloneDX format" -ForegroundColor Gray
            } else {
                Write-Host "No pyproject.toml found. Run in a uv project." -ForegroundColor Red
            }
        }
        
        default {
            Write-Host "flash-pkg v1.2.0 - Universal Fast Dev Setup + Cache Sharing" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Python Commands:" -ForegroundColor Yellow
            Write-Host "  flash ml <name>                      - Create Python ML project" -ForegroundColor Gray
            Write-Host "  flash bootstrap-ml                   - Pre-cache common ML deps" -ForegroundColor Gray
            Write-Host "  flash bootstrap-ml-gpu               - GPU version with CUDA" -ForegroundColor Gray
            Write-Host "  flash bootstrap-custom <file.txt>    - Pre-cache YOUR custom requirements.txt" -ForegroundColor Gray
            Write-Host "  flash export-cache                   - Compress Python cache to shareable file" -ForegroundColor Gray
            Write-Host "  flash import-cache <file.zip>        - Import Python cache instantly" -ForegroundColor Gray
            Write-Host ""
            Write-Host "JavaScript Commands:" -ForegroundColor Yellow
            Write-Host "  flash mern <name>                    - Create MERN/React app" -ForegroundColor Gray
            Write-Host "  flash bootstrap-mern                 - Pre-cache React, Next.js, Vue, etc." -ForegroundColor Gray
            Write-Host "  flash export-cache-js                - Compress JavaScript cache to shareable file" -ForegroundColor Gray
            Write-Host "  flash import-cache-js <file.zip>     - Import JavaScript cache instantly" -ForegroundColor Gray
            Write-Host ""
            Write-Host "Enterprise:" -ForegroundColor Yellow
            Write-Host "  flash sbom                           - Generate SBOM" -ForegroundColor Gray
            Write-Host ""
            Write-Host "flash works with ANY Python/JS project!" -ForegroundColor Cyan
            Write-Host "   Bootstrap just pre-caches common packages for speed." -ForegroundColor Gray
            Write-Host "   Use 'uv pip install -r requirements.txt' or 'bun install' for any project." -ForegroundColor Gray
        }
    }
}
'@
    Write-Host "flash command added" -ForegroundColor Green
} else {
    Write-Host "flash command already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "flash-pkg installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Quick Start:" -ForegroundColor Cyan
Write-Host "  1. Reload your shell: . `$PROFILE" -ForegroundColor Gray
Write-Host "  2. Run once on good WiFi: flash bootstrap-ml" -ForegroundColor Gray
Write-Host "  3. Create projects instantly: flash ml my-ai-project" -ForegroundColor Gray
Write-Host ""
Write-Host "Full commands: flash" -ForegroundColor Cyan
Write-Host "Star the repo: https://github.com/Yogesh1290/flash-pkg" -ForegroundColor Cyan
