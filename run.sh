#!/bin/bash

set -e

source ./config.sh

echo "[@] Encoding dataset"
python3 encode.py \
  --model_name "$MODEL_NAME" \
  "./data/$RUN_NAME" \
  "./data-encoded.npz"

echo "[@] Fine-tuning on dataset"
python3 train.py \
  --run_name "$RUN_NAME" \
  --dataset ./data-encoded.npz \
  --sample_every 50 \
  --save_every 500 \
  --sample_num 2 \
  --learning_rate 0.0001 \
  --batch_size 2

echo "[@] Training complete!"
