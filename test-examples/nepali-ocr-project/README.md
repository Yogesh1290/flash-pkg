# Nepali OCR Test Project

This is a test project to verify flash-pkg works with real ML dependencies.

## Dependencies

Heavy ML stack (total ~2-3 GB):
- PyTorch (CPU) — 800 MB
- PaddleOCR — 400 MB
- ModelScope — 300 MB
- Transformers — 200 MB
- OpenCV — 150 MB
- Others — 150 MB

## Old Way (Without flash-pkg)

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
# ☕☕☕ Wait 45-90 minutes on slow connection
python main.py
```

## New Way (With flash-pkg)

```bash
# One-time bootstrap (once in your life)
flash bootstrap-ml  # 2-4 minutes

# Every time (this project or any other)
uv venv
uv pip install -r requirements.txt  # ⚡ 8-25 seconds!
uv run python main.py
```

## Test It

```bash
cd test-examples/nepali-ocr-project

# Create venv and install
uv venv
uv pip install -r requirements.txt

# Run test
uv run python main.py
```

Expected output:
```
🧪 Testing Nepali OCR Project Dependencies...

✅ PyTorch              imported in 0.234s
✅ TorchVision          imported in 0.123s
✅ TorchAudio           imported in 0.089s
✅ PaddleOCR            imported in 0.456s
✅ ModelScope           imported in 0.234s
✅ Transformers         imported in 0.345s
✅ OpenCV               imported in 0.178s
✅ Pandas               imported in 0.098s
✅ NumPy                imported in 0.045s
✅ Pillow               imported in 0.034s
✅ Requests             imported in 0.023s

==================================================
Results: 11 passed, 0 failed
🎉 All dependencies working! Ready for Nepali OCR.
```

## Benchmark

| Step | Time (first run) | Time (after bootstrap) |
|------|------------------|------------------------|
| Install deps | 45-90 min | 8-25 sec |
| Run test | 2 sec | 2 sec |
| **Total** | **45-90 min** | **10-27 sec** |

**Result: 100-300x faster!**
