---
name: whisper-gpu
description: Set up GPU-accelerated Whisper on NVIDIA Jetson devices (Orin Nano, etc.) for fast local speech-to-text transcription.
metadata: {"openclaw":{"emoji":"🎙️"}}
---

# GPU-Accelerated Whisper for Jetson

Set up OpenAI Whisper with CUDA/GPU acceleration on NVIDIA Jetson devices.

## Supported Hardware

- NVIDIA Jetson Orin Nano (Super)
- NVIDIA Jetson Orin NX
- Other Jetson devices with JetPack 6.x

## Prerequisites

- JetPack 6.x (L4T R36.x) installed
- Python 3.10 (system Python on JetPack 6)
- Internet connection for downloads

---

## Step-by-Step Setup

### Step 1: Install Full JetPack SDK

```bash
sudo apt update
sudo apt install nvidia-jetpack
```

This installs CUDA toolkit, cuDNN, TensorRT, and other NVIDIA libraries.

### Step 2: Verify CUDA Installation

```bash
/usr/local/cuda/bin/nvcc --version
```

Should show CUDA 12.6 or similar.

### Step 3: Download and Install cuSPARSELt

The NVIDIA PyTorch wheel requires cuSPARSELt, which isn't included in JetPack by default.

```bash
cd /tmp
wget https://developer.download.nvidia.com/compute/cusparselt/redist/libcusparse_lt/linux-aarch64/libcusparse_lt-linux-aarch64-0.6.2.3-archive.tar.xz -O cusparselt.tar.xz
tar -xf cusparselt.tar.xz
sudo cp libcusparse_lt-linux-aarch64-0.6.2.3-archive/lib/libcusparseLt* /usr/local/cuda/lib64/
sudo cp libcusparse_lt-linux-aarch64-0.6.2.3-archive/include/* /usr/local/cuda/include/
sudo ldconfig
```

Note: You may see a warning about symbolic links — this is harmless.

### Step 4: Create Python Virtual Environment

Use Python 3.10 (the system Python on JetPack 6):

```bash
/usr/bin/python3.10 -m venv ~/.local/share/whisper-gpu
source ~/.local/share/whisper-gpu/bin/activate
pip install --upgrade pip
```

### Step 5: Install NVIDIA PyTorch for JetPack 6.1

Download the official NVIDIA PyTorch wheel:

```bash
source ~/.local/share/whisper-gpu/bin/activate

# For JetPack 6.1 (L4T R36.4+)
pip install --no-cache-dir https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl
```

Alternative wheels:
- JetPack 6.0: `https://developer.download.nvidia.com/compute/redist/jp/v60/pytorch/`
- Check available versions: `curl -s https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/`

### Step 6: Install NumPy (Compatible Version)

```bash
pip install 'numpy<2'
```

NumPy 2.x is incompatible with the NVIDIA PyTorch build.

### Step 7: Install OpenAI Whisper

```bash
pip install openai-whisper
```

### Step 8: Verify GPU Support

```bash
source ~/.local/share/whisper-gpu/bin/activate
python3 -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}'); print(f'GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')"
```

Expected output:
```
CUDA available: True
GPU: Orin
```

### Step 9: Create Wrapper Script

```bash
mkdir -p ~/.local/bin
cat > ~/.local/bin/whisper-gpu << 'EOF'
#!/bin/bash
# GPU-accelerated Whisper wrapper for Jetson Orin
source ~/.local/share/whisper-gpu/bin/activate
exec whisper "$@"
EOF
chmod +x ~/.local/bin/whisper-gpu
```

### Step 10: Test Transcription

```bash
~/.local/bin/whisper-gpu /path/to/audio.mp3 --model base --language en
```

---

## Usage

Basic transcription:
```bash
~/.local/bin/whisper-gpu audio.mp3 --model base
```

With options:
```bash
~/.local/bin/whisper-gpu audio.ogg --model small --language en --output_format txt --output_dir /tmp
```

Available models (larger = more accurate, slower):
- `tiny` (~1GB VRAM)
- `base` (~1GB VRAM)
- `small` (~2GB VRAM)
- `medium` (~5GB VRAM)
- `large` (~10GB VRAM) — may not fit on Jetson Orin Nano

---

## Troubleshooting

### "libcusparseLt.so.0: cannot open shared object file"

**Cause:** cuSPARSELt not installed.

**Fix:** Follow Step 3 to download and install cuSPARSELt.

### "libcudnn.so.8: cannot open shared object file"

**Cause:** PyTorch version mismatch with installed cuDNN.

**Fix:** Use PyTorch wheel matching your JetPack version:
- JetPack 6.0 (cuDNN 8): Use `jp/v60/pytorch/` wheels
- JetPack 6.1+ (cuDNN 9): Use `jp/v61/pytorch/` wheels

### "CUDA available: False"

**Cause:** PyTorch was built without CUDA support (e.g., from PyPI).

**Fix:** Install the NVIDIA PyTorch wheel, not the standard PyPI version.

### NumPy compatibility errors

**Cause:** NumPy 2.x incompatible with NVIDIA PyTorch.

**Fix:** Downgrade NumPy:
```bash
pip install 'numpy<2'
```

### "FP16 is not supported on CPU"

**Cause:** Whisper is running on CPU, not GPU.

**Fix:** Ensure you're using the GPU venv:
```bash
source ~/.local/share/whisper-gpu/bin/activate
whisper --help
```

---

## Update TOOLS.md

After setup, update `~/.openclaw/workspace/TOOLS.md` to use the GPU-accelerated Whisper:

```markdown
### Audio Transcription

- Preferred: `~/.local/bin/whisper-gpu` (GPU-accelerated, Jetson Orin)
- Fallback: `openai-whisper-api` (cloud, if local fails or for complex audio)

Note: GPU Whisper uses PyTorch 2.5 with CUDA on Jetson Orin. Much faster than CPU.
```

---

## File Locations

| Component | Path |
|-----------|------|
| Virtual environment | `~/.local/share/whisper-gpu/` |
| Wrapper script | `~/.local/bin/whisper-gpu` |
| CUDA libraries | `/usr/local/cuda/lib64/` |
| cuSPARSELt | `/usr/local/cuda/lib64/libcusparseLt.so*` |

---

## Notes

- The Jetson Orin Nano Super has ~8GB shared memory — use `base` or `small` models for best results
- First run downloads the model (~140MB for base, ~460MB for small)
- GPU transcription is significantly faster than CPU (5-10x improvement)
- The standard Homebrew `whisper` command uses CPU; always use `whisper-gpu` for GPU acceleration
