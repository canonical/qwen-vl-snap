# Qwen 2.5 VL inference snap
[![qwen-vl](https://snapcraft.io/qwen-vl/badge.svg)](https://snapcraft.io/qwen-vl)

Qwen 2.5 VL is a vision language model from Alibaba Cloud.

Use this snap to quickly install an optimized environment for local inference with Qwen 2.5 VL.

The snap includes the following hardware-optimized inference engines:

* cpu: Optimized for x64 and ARM (armv8, armv9) CPUs
* nvidia-gpu: CUDA-enabled GPU acceleration
* intel-cpu: Optimized via OpenVINO for Intel CPUs
* intel-gpu: OpenVINO-accelerated inference on Intel integrated/discrete GPUs
* intel-npu: OpenVINO-accelerated inference on Intel NPUs
* ampere-altra: Optimized for Ampere Altra CPUs
* ampere-one: Optimized for Ampere One CPUs

The most suitable engine is automatically selected based on the available hardware.

#### Install
```shell
sudo snap install qwen-vl
```

#### Run
```shell
qwen-vl
```

> [!TIP]
> Some accelerators require extra [drivers](https://documentation.ubuntu.com/inference-snaps/how-to/setup/drivers/) to be usable with this snap.

## Resources

📚 **[Documentation](https://documentation.ubuntu.com/inference-snaps/)**, learn how to use inference snaps

💬 **[Discussions](https://github.com/canonical/inference-snaps/discussions)**, ask questions and share ideas

🐛 **[Issues](https://github.com/canonical/inference-snaps/issues)**, report bugs and request features

## Build and install from source

Clone the repo:
```shell
git clone https://github.com/canonical/qwen-vl-snap
cd qwen-vl-snap
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
