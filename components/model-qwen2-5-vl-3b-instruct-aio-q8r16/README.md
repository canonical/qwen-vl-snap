# Qwen 2.5 VL 3B - Ampere AI Optimized

The model is optimized by Ampere and distributed in GGUF format on Huggingface.

Install Git and Git LFS:
```
sudo apt install git git-lfs
```

Clone:
```shell
git clone --depth 1 https://huggingface.co/AmpereComputing/qwen-2.5-vl-3b-instruct-gguf
cp qwen-2.5-vl-3b-instruct-gguf/qwen-2.5-vl-3b-instruct-Q8R16.gguf .
rm -rf qwen-2.5-vl-3b-instruct-gguf
```