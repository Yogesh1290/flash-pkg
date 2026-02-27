# Test Examples for flash-pkg

Real-world test projects to verify flash-pkg works correctly.

## Projects

### 1. simple-ml-project
Light ML dependencies (~200 MB):
- numpy, pandas, scikit-learn, matplotlib
- Good for quick testing
- Install time: 30-60 seconds first time, 10-20 seconds cached

### 2. fastapi-project
Web API dependencies (~50 MB):
- fastapi, uvicorn, pydantic
- Very fast to test
- Install time: 15-30 seconds first time, 5-10 seconds cached

### 3. nepali-ocr-project
Heavy ML dependencies (~2-3 GB):
- torch, paddleocr, modelscope, transformers, opencv
- Real-world ML project simulation
- Install time: 45-90 min without flash-pkg, 8-25 seconds with flash-pkg (after bootstrap)

## Quick Test

```bash
# 1. Install flash-pkg
cd ..
bash install.sh
source ~/.bashrc

# 2. Run all tests
cd test-examples
bash run-all-tests.sh
```

## Manual Testing

See [TEST_GUIDE.md](TEST_GUIDE.md) for detailed instructions.

## Test Your Own Project

```bash
# Pre-cache your dependencies
flash bootstrap-custom your-project/requirements.txt

# Then use your project
cd your-project
uv venv
uv pip install -r requirements.txt  # Instant!
```

## Expected Results

| Project | First Install | After Cache | Speedup |
|---------|--------------|-------------|---------|
| Simple ML | 30-60 sec | 10-20 sec | 3-6x |
| FastAPI | 15-30 sec | 5-10 sec | 3-6x |
| Heavy ML | 45-90 min | 8-25 sec | 100-300x |

## Report Issues

If any test fails, please report:
1. Which test failed
2. Error message
3. Your OS and connection speed
4. Output of `uv pip config list`

Open an issue on GitHub with this info.
