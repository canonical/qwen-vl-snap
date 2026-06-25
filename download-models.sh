#!/bin/bash

# 3B model (ggml-org)
wget -nv https://huggingface.co/ggml-org/Qwen2.5-VL-3B-Instruct-GGUF/resolve/main/Qwen2.5-VL-3B-Instruct-Q4_K_M.gguf \
    --directory-prefix=components/model-qwen2-5-vl-3b-instruct-q4-k-m/
wget -nv https://huggingface.co/ggml-org/Qwen2.5-VL-3B-Instruct-GGUF/resolve/main/mmproj-Qwen2.5-VL-3B-Instruct-Q8_0.gguf \
    --directory-prefix=components/mmproj-qwen2-5-vl-3b-instruct-q8-0/

# 7B model (ggml-org)
wget -nv https://huggingface.co/ggml-org/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-Q4_K_M.gguf \
    --directory-prefix=components/model-qwen2-5-vl-7b-instruct-q4-k-m/
wget -nv https://huggingface.co/ggml-org/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/mmproj-Qwen2.5-VL-7B-Instruct-Q8_0.gguf \
    --directory-prefix=components/mmproj-qwen2-5-vl-7b-instruct-q8-0/

# 3B Ampere AI Optimized model and mmproj
wget -nv https://huggingface.co/AmpereComputing/qwen-2.5-vl-3b-instruct-gguf/resolve/main/qwen-2.5-vl-3b-instruct-Q8R16.gguf \
    --directory-prefix=components/model-qwen2-5-vl-3b-instruct-aio-q8r16/
wget -nv https://huggingface.co/AmpereComputing/qwen-2.5-vl-3b-instruct-gguf/resolve/main/mmproj-qwen-2.5-vl-3b-instruct-Q8_0.gguf \
    --directory-prefix=components/mmproj-qwen2-5-vl-3b-instruct-aio-q8-0/

# 3B OpenVINO int4 model (Intel CPU/GPU)
OV_INT4_DIR=components/model-qwen2-5-vl-3b-instruct-ov-int4
OV_INT4_BASE=https://huggingface.co/llmware/Qwen2.5-VL-3B-Instruct-ov-int4/resolve/main
for f in \
    added_tokens.json chat_template.json config.json generation_config.json \
    merges.txt openvino_config.json preprocessor_config.json special_tokens_map.json \
    tokenizer.json tokenizer_config.json vocab.json \
    openvino_detokenizer.bin openvino_detokenizer.xml \
    openvino_language_model.bin openvino_language_model.xml \
    openvino_text_embeddings_model.bin openvino_text_embeddings_model.xml \
    openvino_tokenizer.bin openvino_tokenizer.xml \
    openvino_vision_embeddings_merger_model.bin openvino_vision_embeddings_merger_model.xml \
    openvino_vision_embeddings_model.bin openvino_vision_embeddings_model.xml; do
    wget -nv "${OV_INT4_BASE}/${f}" --directory-prefix="${OV_INT4_DIR}/"
done
ln -sf /tmp/graph.pbtxt "${OV_INT4_DIR}/graph.pbtxt"

# 3B OpenVINO int4 NPU model (Intel NPU)
OV_NPU_DIR=components/model-qwen2-5-vl-3b-instruct-ov-int4-npu
OV_NPU_BASE=https://huggingface.co/llmware/Qwen2.5-VL-3B-Instruct-ov-int4-npu/resolve/main
for f in \
    added_tokens.json chat_template.json config.json generation_config.json \
    merges.txt openvino_config.json preprocessor_config.json special_tokens_map.json \
    tokenizer.json tokenizer_config.json vocab.json \
    openvino_detokenizer.bin openvino_detokenizer.xml \
    openvino_language_model.bin openvino_language_model.xml \
    openvino_text_embeddings_model.bin openvino_text_embeddings_model.xml \
    openvino_tokenizer.bin openvino_tokenizer.xml \
    openvino_vision_embeddings_merger_model.bin openvino_vision_embeddings_merger_model.xml \
    openvino_vision_embeddings_model.bin openvino_vision_embeddings_model.xml; do
    wget -nv "${OV_NPU_BASE}/${f}" --directory-prefix="${OV_NPU_DIR}/"
done
ln -sf /tmp/graph.pbtxt "${OV_NPU_DIR}/graph.pbtxt"
