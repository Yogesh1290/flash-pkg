#!/usr/bin/env python3
"""
Nepali OCR Test Project
Tests if all heavy ML dependencies are installed correctly
"""

import sys
import time

def test_imports():
    """Test all critical imports"""
    print("🧪 Testing Nepali OCR Project Dependencies...\n")
    
    tests = [
        ("torch", "PyTorch"),
        ("torchvision", "TorchVision"),
        ("torchaudio", "TorchAudio"),
        ("paddleocr", "PaddleOCR"),
        ("modelscope", "ModelScope"),
        ("transformers", "Transformers"),
        ("cv2", "OpenCV"),
        ("pandas", "Pandas"),
        ("numpy", "NumPy"),
        ("PIL", "Pillow"),
        ("requests", "Requests"),
    ]
    
    passed = 0
    failed = 0
    
    for module, name in tests:
        try:
            start = time.time()
            __import__(module)
            elapsed = time.time() - start
            print(f"✅ {name:20s} imported in {elapsed:.3f}s")
            passed += 1
        except ImportError as e:
            print(f"❌ {name:20s} FAILED: {e}")
            failed += 1
    
    print(f"\n{'='*50}")
    print(f"Results: {passed} passed, {failed} failed")
    
    if failed == 0:
        print("🎉 All dependencies working! Ready for Nepali OCR.")
        return 0
    else:
        print("⚠️  Some dependencies missing. Run: uv pip install -r requirements.txt")
        return 1

if __name__ == "__main__":
    sys.exit(test_imports())
