#!/usr/bin/env bash
# Run all flash-pkg tests
# This script tests all example projects

set -e

echo "🧪 Running all flash-pkg tests..."
echo "=================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if flash is installed
if ! command -v flash &> /dev/null; then
    echo -e "${RED}❌ flash command not found${NC}"
    echo "Run: bash ../install.sh && source ~/.bashrc"
    exit 1
fi

echo -e "${GREEN}✅ flash command found${NC}"
echo ""

# Test 1: Simple ML Project
echo "Test 1: Simple ML Project (light dependencies)"
echo "-----------------------------------------------"
cd simple-ml-project
if [ ! -d ".venv" ]; then
    echo "Creating venv..."
    uv venv
fi

echo "Installing dependencies..."
start_time=$(date +%s)
uv pip install -r requirements.txt
end_time=$(date +%s)
elapsed=$((end_time - start_time))

echo "Running test..."
if uv run python main.py; then
    echo -e "${GREEN}✅ Simple ML test passed in ${elapsed}s${NC}"
else
    echo -e "${RED}❌ Simple ML test failed${NC}"
    exit 1
fi
echo ""

# Test 2: FastAPI Project
echo "Test 2: FastAPI Project (web framework)"
echo "----------------------------------------"
cd ../fastapi-project
if [ ! -d ".venv" ]; then
    echo "Creating venv..."
    uv venv
fi

echo "Installing dependencies..."
start_time=$(date +%s)
uv pip install -r requirements.txt
end_time=$(date +%s)
elapsed=$((end_time - start_time))

echo "Running test..."
if uv run python main.py; then
    echo -e "${GREEN}✅ FastAPI test passed in ${elapsed}s${NC}"
else
    echo -e "${RED}❌ FastAPI test failed${NC}"
    exit 1
fi
echo ""

# Test 3: Heavy ML Project (optional — requires bootstrap)
echo "Test 3: Nepali OCR Project (heavy ML dependencies)"
echo "---------------------------------------------------"
echo -e "${YELLOW}⚠️  This test requires 'flash bootstrap-ml' first${NC}"
read -p "Have you run 'flash bootstrap-ml'? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd ../nepali-ocr-project
    if [ ! -d ".venv" ]; then
        echo "Creating venv..."
        uv venv
    fi
    
    echo "Installing dependencies..."
    start_time=$(date +%s)
    uv pip install -r requirements.txt
    end_time=$(date +%s)
    elapsed=$((end_time - start_time))
    
    echo "Running test..."
    if uv run python main.py; then
        echo -e "${GREEN}✅ Heavy ML test passed in ${elapsed}s${NC}"
    else
        echo -e "${RED}❌ Heavy ML test failed${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⏭️  Skipping heavy ML test${NC}"
    echo "Run later: flash bootstrap-ml && cd nepali-ocr-project && uv pip install -r requirements.txt"
fi

echo ""
echo "=================================="
echo -e "${GREEN}🎉 All tests completed!${NC}"
echo ""
echo "Summary:"
echo "- Simple ML: ✅"
echo "- FastAPI: ✅"
echo "- Heavy ML: ${REPLY}"
echo ""
echo "Next steps:"
echo "1. Run 'flash bootstrap-ml' (if not done)"
echo "2. Test your own project"
echo "3. Push to GitHub"
echo "4. Share your results!"
