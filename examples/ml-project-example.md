# Example: Using flash-pkg with Existing ML Project

## Scenario

You have a Nepali OCR project with heavy dependencies:

```
my-nepali-ocr/
├── requirements.txt
├── main.py
├── models/
└── data/
```

## Step-by-Step Real Usage

### 1. One-time setup (first time only)

```bash
# Install flash-pkg (10-30 seconds)
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
source ~/.bashrc

# Bootstrap heavy deps once on good WiFi (2-4 minutes)
flash bootstrap-ml
```

### 2. Use on your existing project (every time — <30 seconds)

```bash
cd my-nepali-ocr

# Create virtual environment with uv
uv venv

# Install all dependencies (uses cached wheels)
uv pip install -r requirements.txt

# Run your project
uv run python main.py
```

### Time comparison

| Step | Old way (pip) | With flash-pkg |
|------|---------------|----------------|
| Install deps | 45-90 min | 8-25 sec |
| Total setup | 45-90 min | <30 sec |

### 3. Share with teammate

Your teammate just needs:

```bash
# They install flash-pkg
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash

# They bootstrap once
flash bootstrap-ml

# Then clone your project
git clone your-repo
cd your-repo
uv venv
uv pip install -r requirements.txt  # <30 seconds!
```

## Example requirements.txt

```txt
torch==2.5.0
torchvision==0.20.0
torchaudio==2.5.0
paddleocr==2.8.1
modelscope==1.20.0
transformers==4.46.0
opencv-contrib-python==4.10.0.84
pandas==2.2.3
numpy==2.1.3
pillow==11.0.0
```

## Converting to pyproject.toml (recommended)

For even better dependency management:

```bash
cd my-nepali-ocr
uv init --app
uv add torch torchvision torchaudio paddleocr modelscope transformers opencv-contrib-python pandas numpy pillow

# Now use
uv sync  # installs everything in <30 seconds
```

## Result

After one-time bootstrap, every new project or fresh clone is instant. No more tea breaks waiting for pip.
