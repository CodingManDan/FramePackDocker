# Use NVIDIA CUDA 12.6 with Python 3.10 as base image
FROM nvidia/cuda:12.6.0-runtime-ubuntu22.04
ARG PORT=7860
# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    HF_HOME=/app/hf_download \
    PORT=${PORT}

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 \
    python3-pip \
    python3.10-venv \
    git \
    wget \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/lllyasviel/FramePack.git /app

# Create and activate virtual environment
RUN python3.10 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install PyTorch with CUDA 12.6 support
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

# Install other Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make output directory
RUN mkdir -p /app/outputs

# Expose the port that Gradio runs on
EXPOSE 7860

# Command to run the application
CMD ["python", "demo_gradio.py", "--server", "0.0.0.0", "--port", "${PORT}"]
