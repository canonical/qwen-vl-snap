SHELL := /bin/bash

# Always run `hf` via pipx to avoid relying on local `hf` installations.
hf := pipx run --spec "huggingface_hub[cli]" hf

SNAP_NAME ?= qwen-vl
ENGINE ?= cpu

.PHONY: all help init build install upload smoke-test install-deps init-submodules download-models \
	download-model-3b download-model-7b download-model-3b-aio download-model-3b-ov-int4 download-model-3b-ov-int4-npu

all: help

#
# Main targets
#

help: ## Show this help message
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@# List all targets with descriptions (lines starting with '##'):
	@grep -E '^[a-zA-Z0-9_-]+:.*## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  %-11s %s\n", $$1, $$2}'

init: init-submodules install-deps download-models ## Initialize the build environment (dependencies, model weights, submodules, etc.)

build: ## Build the snap
	./dev/build.sh

install: ## Install the snap
	./dev/install.sh

upload: ## Upload the snap
	./dev/upload.sh

smoke-test: ## Run smoke tests (override with SNAP_NAME=... ENGINE=...)
	sudo ./dev/smoke-test.sh $(SNAP_NAME) $(ENGINE)

#
# Supporting targets
#

install-deps:
	@echo "Installing dependencies..."
	@# Ensure pipx is available for running the hf CLI.
	@command -v pipx >/dev/null 2>&1 || { \
		sudo apt-get update; \
		sudo apt-get install -y pipx; \
	}

init-submodules:
	@echo "Initializing submodules..."
	@if git submodule status | grep -q '^-'; then \
		git submodule update --init; \
	fi

download-models: download-model-3b download-model-7b download-model-3b-aio download-model-3b-ov-int4 download-model-3b-ov-int4-npu

download-model-3b:
	@echo "Downloading Qwen2.5-VL-3B-Instruct-Q4_K_M model and mmproj..."
	$(hf) download ggml-org/Qwen2.5-VL-3B-Instruct-GGUF \
		Qwen2.5-VL-3B-Instruct-Q4_K_M.gguf \
		--local-dir components/model-qwen2-5-vl-3b-instruct-q4-k-m/
	$(hf) download ggml-org/Qwen2.5-VL-3B-Instruct-GGUF \
		mmproj-Qwen2.5-VL-3B-Instruct-Q8_0.gguf \
		--local-dir components/mmproj-qwen2-5-vl-3b-instruct-q8-0/

download-model-7b:
	@echo "Downloading Qwen2.5-VL-7B-Instruct-Q4_K_M model and mmproj..."
	$(hf) download ggml-org/Qwen2.5-VL-7B-Instruct-GGUF \
		Qwen2.5-VL-7B-Instruct-Q4_K_M.gguf \
		--local-dir components/model-qwen2-5-vl-7b-instruct-q4-k-m/
	$(hf) download ggml-org/Qwen2.5-VL-7B-Instruct-GGUF \
		mmproj-Qwen2.5-VL-7B-Instruct-Q8_0.gguf \
		--local-dir components/mmproj-qwen2-5-vl-7b-instruct-q8-0/

download-model-3b-aio:
	@echo "Downloading Ampere-optimized Qwen2.5-VL-3B-Instruct model and mmproj..."
	$(hf) download AmpereComputing/qwen-2.5-vl-3b-instruct-gguf \
		qwen-2.5-vl-3b-instruct-Q8R16.gguf \
		--local-dir components/model-qwen2-5-vl-3b-instruct-aio-q8r16/
	$(hf) download AmpereComputing/qwen-2.5-vl-3b-instruct-gguf \
		mmproj-qwen-2.5-vl-3b-instruct-Q8_0.gguf \
		--local-dir components/mmproj-qwen2-5-vl-3b-instruct-aio-q8-0/

download-model-3b-ov-int4:
	@echo "Downloading Qwen2.5-VL-3B-Instruct OpenVINO int4 (CPU/GPU) model..."
	$(hf) download llmware/Qwen2.5-VL-3B-Instruct-ov-int4 \
		--local-dir components/model-qwen2-5-vl-3b-instruct-ov-int4
	@# Make symlink for mediapipe graph to make it writable by OVMS when moved to a snap component
	ln -sf /tmp/graph.pbtxt "components/model-qwen2-5-vl-3b-instruct-ov-int4/graph.pbtxt"

download-model-3b-ov-int4-npu:
	@echo "Downloading Qwen2.5-VL-3B-Instruct OpenVINO int4 (NPU) model..."
	$(hf) download llmware/Qwen2.5-VL-3B-Instruct-ov-int4-npu \
		--local-dir components/model-qwen2-5-vl-3b-instruct-ov-int4-npu
	@# Make symlink for mediapipe graph to make it writable by OVMS when moved to a snap component
	ln -sf /tmp/graph.pbtxt "components/model-qwen2-5-vl-3b-instruct-ov-int4-npu/graph.pbtxt"
