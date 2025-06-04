#!/bin/sh

if test -f "/root/.ollama/.has_been_run"; then
    exit 0
fi

IFS=',' read -r -a models_array <<< "$MODELS_TO_PULL"

for model in "${models_array[@]}"; do
    ollama pull "$model"
done

touch /root/.ollama/.has_been_run
