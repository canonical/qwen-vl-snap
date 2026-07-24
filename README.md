# Qwen VL snap
[![qwen-vl](https://snapcraft.io/qwen-vl/badge.svg)](https://snapcraft.io/qwen-vl)

This snap installs a hardware-optimized engine for inference with the [Qwen VL](https://github.com/QwenLM/Qwen-VL) multimodal language model.

Install:
```
sudo snap install qwen-vl --beta
```

Get help:
```
qwen-vl --help
```

## Resources

📚 **[Documentation](https://documentation.ubuntu.com/inference-snaps/)**, learn how to use inference snaps

💬 **[Discussions](https://github.com/canonical/inference-snaps/discussions)**, ask questions and share ideas

🐛 **[Issues](https://github.com/canonical/inference-snaps/issues)**, report bugs and request features

## Build and install from source

Clone the repo:
```shell
git clone https://github.com/canonical/qwen-vl-snap.git
```

Initialize the development environment:
```shell
make init
```

Build and install snap:
```shell
make build
make install
```
