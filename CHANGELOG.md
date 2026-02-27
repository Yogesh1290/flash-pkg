# Changelog

All notable changes to flash-pkg will be documented in this file.

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
