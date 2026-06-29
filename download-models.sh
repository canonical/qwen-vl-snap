#!/bin/bash


set -euo pipefail

# Setup Hugging Face CLI
sudo apt-get update
sudo apt-get install -y python3-venv
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install --upgrade huggingface_hub

# 3B model
hf download ggml-org/Qwen2.5-VL-3B-Instruct-GGUF \
    Qwen2.5-VL-3B-Instruct-Q4_K_M.gguf \
    --local-dir components/model-qwen2-5-vl-3b-instruct-q4-k-m/
hf download ggml-org/Qwen2.5-VL-3B-Instruct-GGUF \
    mmproj-Qwen2.5-VL-3B-Instruct-Q8_0.gguf \
    --local-dir components/mmproj-qwen2-5-vl-3b-instruct-q8-0/

# 7B model
hf download ggml-org/Qwen2.5-VL-7B-Instruct-GGUF \
    Qwen2.5-VL-7B-Instruct-Q4_K_M.gguf \
    --local-dir components/model-qwen2-5-vl-7b-instruct-q4-k-m/
hf download ggml-org/Qwen2.5-VL-7B-Instruct-GGUF \
    mmproj-Qwen2.5-VL-7B-Instruct-Q8_0.gguf \
    --local-dir components/mmproj-qwen2-5-vl-7b-instruct-q8-0/

# 3B Ampere AI Optimized model and mmproj
hf download AmpereComputing/qwen-2.5-vl-3b-instruct-gguf \
    qwen-2.5-vl-3b-instruct-Q8R16.gguf \
    --local-dir components/model-qwen2-5-vl-3b-instruct-aio-q8r16/
hf download AmpereComputing/qwen-2.5-vl-3b-instruct-gguf \
    mmproj-qwen-2.5-vl-3b-instruct-Q8_0.gguf \
    --local-dir components/mmproj-qwen2-5-vl-3b-instruct-aio-q8-0/

# 3B OpenVINO int4 model (Intel CPU/GPU)
hf download llmware/Qwen2.5-VL-3B-Instruct-ov-int4 \
    --local-dir components/model-qwen2-5-vl-3b-instruct-ov-int4
# Make symlink for mediapipe graph to make it writable by OVMS when moved to a snap component
ln -sf /tmp/graph.pbtxt "components/model-qwen2-5-vl-3b-instruct-ov-int4/graph.pbtxt"

# 3B OpenVINO int4 NPU model (Intel NPU)
hf download llmware/Qwen2.5-VL-3B-Instruct-ov-int4-npu \
    --local-dir components/model-qwen2-5-vl-3b-instruct-ov-int4-npu
# Make symlink for mediapipe graph to make it writable by OVMS when moved to a snap component
ln -sf /tmp/graph.pbtxt "components/model-qwen2-5-vl-3b-instruct-ov-int4-npu/graph.pbtxt"
