#!/bin/bash

set -e

source ./config.sh

echo "[@] Jettison old fine-tuned model"
if [ -d "./models/$RUN_NAME" ]; then rm -Rf "./models/$RUN_NAME"; fi

echo "[@] Create new fine-tuned model"
mkdir "./models/$RUN_NAME"
ln "./models/$MODEL_NAME/encoder.json" "./models/$RUN_NAME"/
ln "./models/$MODEL_NAME/hparams.json" "./models/$RUN_NAME"/
ln "./models/$MODEL_NAME/vocab.bpe" "./models/$RUN_NAME"/
shopt -s globstar
cp "./checkpoint/$RUN_NAME/model-*" "./models/$RUN_NAME"/
cp "./checkpoint/$RUN_NAME/checkpoint" "./models/$RUN_NAME"/
ls "./models/$RUN_NAME" -l

echo "[@] Start interactive session"
python3 ./src/interactive_conditional_samples.py \
  --temperature 0.9 \
  --model_name "$RUN_NAME" \
  --top_k 40

echo "[@] Finish interactive session. Goodbye!"
