#!/usr/bin/env bash

echo "Using Python version:"
python3 --version

# Cài thư viện yêu cầu
pip install --upgrade pip
pip install gradio==4.25 deepfilternet==0.5.6 vinorm==2.0.7 underthesea==6.8.0 \
    deepspeed cutlet unidic --quiet

# Lấy submodule TTS
git submodule update --init --recursive
cd TTS
git fetch --tags
git checkout 0.1.1
echo "Installing TTS..."
pip install --use-deprecated=legacy-resolver -e . -q
cd ..

# Download Japanese/Chinese tokenizer
echo "Downloading Japanese/Chinese tokenizer..."
python -m unidic download

# Cài các requirements khác
echo "Installing other requirements..."
pip install -r requirements.txt -q

# Chạy demo
python vixtts_demo.py
