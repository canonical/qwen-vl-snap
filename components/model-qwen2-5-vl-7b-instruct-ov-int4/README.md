# Qwen 2.5 VL 7B Optimized for OpenVINO

The Qwen2.5-VL-7B-Instruct-int4-npu-ov subdirectory contains the model in Intermediate Representation for use with OpenVINO.

To export the model, one can use optimum-intel.
This can be done from Huggingface as follows.
You will require a device with >32GB of RAM.
Adding swap does not help.

Create a virtual environment, and make sure you are using the latest pip:
```
python3 -m venv venv
source venv/bin/activate
python -m pip install --upgrade pip
```

Install optimum-intel with OpenVINO support:
```
pip install --upgrade --upgrade-strategy eager "optimum[openvino]"
```

Check the version of optimum.
The model in this directory was exported using optimum v1.27.0 and optimum-intel v1.25.2.
```
pip show optimum
pip show optimum-intel
```

Export the model to be NPU-friendly by using symmetric INT4 quantization (--sym).
For models with more than ~1-2B parameters, channel-wise quantization should be used (--group-size -1) for NPUs.
We add `npu` in the output directory name to remind us it is exported using these NPU-friendly parameters.
```
optimum-cli export openvino --weight-format int4 --sym --group-size -1 --model Qwen/Qwen2.5-VL-7B-Instruct Qwen2.5-VL-7B-Instruct-int4-npu-ov
```
