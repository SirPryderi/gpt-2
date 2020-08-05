#!/bin/bash

./build-image.sh

docker container rm gpt-2 

docker run \
  --name gpt-2 \
  -v "$(pwd)/data":"/gpt-2/data" \
  -v "$(pwd)/checkpoint":"/gpt-2/checkpoint" \
  -v "$(pwd)/samples":"/gpt-2/samples" \
  -it \
  gpt2 \
  /gpt-2/run.sh