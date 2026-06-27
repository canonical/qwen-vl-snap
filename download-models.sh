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
OV_INT4_DIR=components/model-qwen2-5-vl-3b-instruct-ov-int4
hf download llmware/Qwen2.5-VL-3B-Instruct-ov-int4 \
    added_tokens.json chat_template.json config.json generation_config.json \
    merges.txt openvino_config.json preprocessor_config.json special_tokens_map.json \
    tokenizer.json tokenizer_config.json vocab.json \
    openvino_detokenizer.bin openvino_detokenizer.xml \
    openvino_language_model.bin openvino_language_model.xml \
    openvino_text_embeddings_model.bin openvino_text_embeddings_model.xml \
    openvino_tokenizer.bin openvino_tokenizer.xml \
    openvino_vision_embeddings_merger_model.bin openvino_vision_embeddings_merger_model.xml \
    openvino_vision_embeddings_model.bin openvino_vision_embeddings_model.xml \
    --local-dir "${OV_INT4_DIR}/"
# Make symlink for mediapipe graph to make it writable by OVMS when moved to a snap component
ln -sf /tmp/graph.pbtxt "${OV_INT4_DIR}/graph.pbtxt"

# 3B OpenVINO int4 NPU model (Intel NPU)
OV_NPU_DIR=components/model-qwen2-5-vl-3b-instruct-ov-int4-npu
hf download llmware/Qwen2.5-VL-3B-Instruct-ov-int4-npu \
    added_tokens.json chat_template.json config.json generation_config.json \
    merges.txt openvino_config.json preprocessor_config.json special_tokens_map.json \
    tokenizer.json tokenizer_config.json vocab.json \
    openvino_detokenizer.bin openvino_detokenizer.xml \
    openvino_language_model.bin openvino_language_model.xml \
    openvino_text_embeddings_model.bin openvino_text_embeddings_model.xml \
    openvino_tokenizer.bin openvino_tokenizer.xml \
    openvino_vision_embeddings_merger_model.bin openvino_vision_embeddings_merger_model.xml \
    openvino_vision_embeddings_model.bin openvino_vision_embeddings_model.xml \
    --local-dir "${OV_NPU_DIR}/"
# Make symlink for mediapipe graph to make it writable by OVMS when moved to a snap component
ln -sf /tmp/graph.pbtxt "${OV_NPU_DIR}/graph.pbtxt"
