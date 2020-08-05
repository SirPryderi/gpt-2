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
latest=$(<./checkpoint/$RUN_NAME/counter) 
cp "./checkpoint/$RUN_NAME/model-$latest.data-00000-of-00001" "./models/$RUN_NAME"/
cp "./checkpoint/$RUN_NAME/model-$latest.index" "./models/$RUN_NAME"/
cp "./checkpoint/$RUN_NAME/model-$latest.meta" "./models/$RUN_NAME"/
cp "./checkpoint/$RUN_NAME/checkpoint" "./models/$RUN_NAME"/

echo "[@] Start interactive session"
python3 ./src/interactive_conditional_samples.py \
  --temperature 0.9 \
  --model_name "$RUN_NAME" \
  --top_k 40

echo "[@] Finish interactive session. Goodbye!"
