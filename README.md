# Qwen VL snap

This snap installs a hardware-optimized engine for inference with the [Qwen VL](https://github.com/QwenLM/Qwen-VL) multimodal language model.

## Build and install from source

Clone this repo with its submodules:
```shell
git clone --recurse-submodules https://github.com/canonical/qwen-vl-snap.git
```

Prepare the required models by following the instructions for each model, under the [components](./components) directory. 

Build the snap and its component:
```shell
snapcraft pack -v
```

Refer to the `./dev` directory for additional development tools.
