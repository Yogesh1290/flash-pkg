# Changelog

All notable changes to flash-pkg will be documented in this file.

## [1.2.0] - 2026-02-28

### Added
- 🎉 **JavaScript/Bun Cache Support** - Full parity with Python cache features!
  - `flash bootstrap-mern` - Pre-cache React, Next.js, Vue, TypeScript, Vite, TailwindCSS
  - `flash export-cache-js` - Export Bun cache (146 MB → 24 MB compressed!)
  - `flash import-cache-js` - Import Bun cache in 1 second
  - Works on Linux, macOS, WSL, and Windows PowerShell
  - Tested: 178 packages install in 30 seconds from cache

### Performance (Tested on WSL)
- **JavaScript Cache:**
  - Export: 1.4 seconds (146 MB → 24 MB = 6x compression!)
  - Import: 1.1 seconds
  - Install: 30 seconds for 178 packages
  - Cache file: Only 24 MB (super easy to share!)

- **Python Cache (unchanged):**
  - Export: 33 seconds (2.4 GB → 477 MB)
  - Import: 19 seconds
  - Install: 60 seconds (WSL filesystem limitation)

### Documentation
- Updated README.md with JavaScript cache workflow
- Updated FAQ.md with JavaScript cache questions
- Updated all docs to reflect full Python + JavaScript support
- Added test example: test-examples/simple-react-app

## [1.1.1] - 2026-02-27

### Added
- 🎉 **Windows PowerShell Support** - Native Windows installer (most requested feature!)
  - Full PowerShell implementation with `install.ps1`
  - Uses .zip format for cache (Windows-native compression)
  - All flash commands work: bootstrap-ml, export-cache, import-cache, ml, mern, sbom
  - Auto-installs uv and Bun on Windows
  - Fast mirror selection using HEAD requests (1-2 seconds vs 60+ seconds)
  - Proxy detection included
  - Install: `irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex`
  - Works from PowerShell, CMD, and Git Bash

### Improved
- ⚡ **PowerShell Installer Performance**
  - Mirror testing now uses HEAD requests (latency check only)
  - Total install time: ~2 seconds (vs 60+ seconds before)
  - Clean UI with progress indicators
  - No annoying byte-counting progress bars

### Fixed
- 🚀 **WSL Performance Optimization** - Optimized `flash export-cache` for Windows/WSL
  - Auto-detects WSL environment
  - Uses faster compression (level 10 vs 19) for WSL
  - Result: Export in 30-35 seconds on WSL (vs 60+ seconds with level 19)
  - File size: 450-500 MB (excellent compression maintained)
  - Linux/Mac unchanged (still uses level 19 for maximum compression)
  - **Note**: Removed `--dereference` flag as it was breaking cache structure

### Performance (Tested on WSL)
- Export cache: 33 seconds
- Import cache: 19 seconds
- Install from cache: 60 seconds (WSL filesystem limitation - can't hardlink)
- Total workflow: 112 seconds vs 45 minutes = 34x faster!

### Documentation
- Updated FAQ.md with accurate WSL performance expectations
- Updated README.md with tested benchmarks
- Added FINAL_TEST_RESULTS.md with complete test data
- Added WSL_PERFORMANCE_REALITY.md explaining WSL limitations

## [1.1.0] - 2026-02-27

### Added
- 🔥 **Cache Sharing Feature** - Export and import compressed cache files
  - `flash export-cache` - Compress cache to shareable file (5x smaller)
  - `flash import-cache <file>` - Import cache in 5-15 seconds
  - Compression ratio: 5:1 (e.g., 947 MB → 183 MB)
  - Perfect for team sharing and bandwidth savings

### Documentation
- Added comprehensive FAQ.md with 20+ questions
- Added docs/COMPLETE_GUIDE.md with Docker comparison
- Added docs/BENCHMARKS.md with performance data
- Added docs/ENTERPRISE.md for company rollout

### Improved
- Updated README with cache sharing workflow
- Enhanced help text with new commands
- Better error messages and user guidance

## [1.0.0] - 2026-02-26

### Added
- Initial release of flash-pkg
- Universal Python (uv) + JavaScript (Bun) setup
- Asia-optimized mirror selection with latency testing
- Bootstrap commands for ML packages
- Docker templates for ML and MERN projects
- SBOM generation for security audits
- Enterprise features (proxy, air-gapped mode)

### Features
- `flash ml <name>` - Create Python ML project
- `flash mern <name>` - Create MERN app
- `flash bootstrap-ml` - Pre-cache common ML dependencies
- `flash bootstrap-ml-gpu` - GPU version with CUDA
- `flash bootstrap-custom <file>` - Pre-cache custom requirements
- `flash docker-ml <name>` - Generate ML Docker template
- `flash docker-mern <name>` - Generate MERN Docker template
- `flash enterprise-install` - Company rollout guide
- `flash sbom` - Generate SBOM

### Performance
- 10-100x faster than pip for package installation
- Automatic fastest mirror selection
- Global cache for instant reuse across projects

---

## Versioning

This project follows [Semantic Versioning](https://semver.org/):
- MAJOR version for incompatible API changes
- MINOR version for new functionality in a backwards compatible manner
- PATCH version for backwards compatible bug fixes
