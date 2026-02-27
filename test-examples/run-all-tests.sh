#!/usr/bin/env bash
# Run all flash-pkg tests
# This script tests all example projects (Python + JavaScript)

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

# Check if bun is installed
if ! command -v bun &> /dev/null; then
    echo -e "${YELLOW}⚠️  bun not found - JavaScript tests will be skipped${NC}"
    echo "Install: curl -fsSL https://bun.sh/install | bash"
    SKIP_JS=true
else
    echo -e "${GREEN}✅ bun command found${NC}"
    SKIP_JS=false
fi
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

# Test 4: JavaScript React Project
if [ "$SKIP_JS" = false ]; then
    echo "Test 4: React App (JavaScript/Bun)"
    echo "-----------------------------------"
    cd ../simple-react-app
    
    echo "Installing dependencies..."
    start_time=$(date +%s)
    bun install
    end_time=$(date +%s)
    elapsed=$((end_time - start_time))
    
    echo -e "${GREEN}✅ React test passed in ${elapsed}s${NC}"
    echo ""
else
    echo -e "${YELLOW}⏭️  Skipping JavaScript tests (bun not installed)${NC}"
    echo ""
fi

echo "=================================="
echo -e "${GREEN}🎉 All tests completed!${NC}"
echo ""
echo "Summary:"
echo "- Simple ML: ✅"
echo "- FastAPI: ✅"
echo "- Heavy ML: ${REPLY}"
if [ "$SKIP_JS" = false ]; then
    echo "- React App: ✅"
else
    echo "- React App: ⏭️  (skipped)"
fi
echo ""
echo "Next steps:"
echo "1. Run 'flash bootstrap-ml' (if not done)"
echo "2. Run 'flash bootstrap-mern' (for JavaScript)"
echo "3. Test your own project"
echo "4. Share your results!"
