# Qwen 2.5 VL 3B Optimized for Intel CPU and Intel GPU

The model is optimized by Intel and distributed in Intermediate Representation (IR) on Huggingface.

Install Git and Git LFS:
```
sudo apt install git git-lfs
```

Clone:
```
git clone --depth 1 https://huggingface.co/helenai/Qwen2.5-VL-3B-Instruct-ov-int4
git -C Qwen2.5-VL-3B-Instruct-ov-int4 lfs prune --force
```