# FramePack Docker

[![Build Status](https://img.shields.io/github/actions/workflow/status/codingmandan/framepack/docker-image.yml?branch=main&style=flat-square)](https://github.com/codingmandan/framepack)
[![Docker Pulls](https://img.shields.io/docker/pulls/codingmandan/framepack?style=flat-square)](https://hub.docker.com/r/codingmandan/framepack)
[![Docker Image Size](https://img.shields.io/docker/image-size/codingmandan/framepack?style=flat-square)](https://hub.docker.com/r/codingmandan/framepack)
[![License](https://img.shields.io/github/license/lllyasviel/FramePack?style=flat-square)](https://github.com/lllyasviel/FramePack)

This Docker container provides a ready-to-use environment for [FramePack](https://github.com/lllyasviel/FramePack), an AI video generation model that progressively creates videos from single images using next-frame prediction.

## Features

- Pre-configured environment with all dependencies installed
- CUDA 12.6 support for GPU acceleration
- Performance-enhancing libraries (xformers, flash-attention)
- Persistent storage for model files and outputs
- Web-based UI accessible via port 7860

## System Requirements

- Docker-compatible system (Linux/Windows/Mac with Docker installed)
- NVIDIA GPU with at least 6GB VRAM (for generation)
  - GTX 10XX/20XX series are untested, RTX 30XX/40XX/50XX series recommended
- At least 40GB free disk space (30GB for models + space for outputs)
- Docker with NVIDIA Container Toolkit for GPU passthrough

## Installation

### Docker Hub

```bash
docker pull codingmandan/framepack
```

### Running the Container

```bash
docker run -d \
  --name framepack \
  --gpus all \
  -p 7860:7860 \
  -v /path/to/models:/app/hf_download \
  -v /path/to/outputs:/app/outputs \
  codingmandan/framepack
```

Replace `/path/to/models` and `/path/to/outputs` with your desired storage locations.

### Unraid Installation

1. Navigate to the "Docker" tab in your Unraid dashboard
2. Click "Add Container"
3. Fill in the following details:
   - Name: framepack
   - Repository: codingmandan/framepack
4. Add the following paths:
   - Container path: `/app/hf_download` → Host path: `/mnt/user/appdata/framepack/models`
   - Container path: `/app/outputs` → Host path: `/mnt/user/appdata/framepack/outputs`
5. Add the following port mapping:
   - Container port: `7860` → Host port: `7860`
6. Under Advanced View, check the "GPU" option to enable GPU passthrough
7. Click "Apply" to start the container

## Usage

1. Access the web interface at `http://your-host-ip:7860`
2. Upload an image
3. Enter a prompt describing the desired motion
4. Adjust settings if needed
5. Click "Start Generation"

On first run, the container will download model files (approximately 30GB) from HuggingFace.

## Volumes

- `/app/hf_download`: Stores downloaded model files (preserve to avoid re-downloading)
- `/app/outputs`: Stores generated videos

## License

This Docker image contains FramePack, which is distributed under the Apache 2.0 License. See the [official repository](https://github.com/lllyasviel/FramePack) for more details.
