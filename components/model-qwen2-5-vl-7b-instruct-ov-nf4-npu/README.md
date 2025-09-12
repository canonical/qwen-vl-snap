# Qwen 2.5 VL 7B Optimized for Intel NPUs

The model is optimized by Intel and distributed in Intermediate Representation (IR) on Huggingface.

Install Git and Git LFS:
```
sudo apt install git git-lfs
```

Clone:
```
git clone --depth 1 https://huggingface.co/helenai/Qwen2.5-VL-7B-Instruct-ov-nf4-npu
git -C Qwen2.5-VL-7B-Instruct-ov-nf4-npu lfs prune --force
```