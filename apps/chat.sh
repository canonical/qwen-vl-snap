#!/bin/bash -eu

# Query status and extract the relevant info
status_obj="$(qwen-vl status --format=json)"

status="$(echo "$status_obj" | jq -r '.status')"
if [ "$status" != "online" ]; then
  echo "Server is not online. Current status: $status"
  exit 1
fi

openai_endpoint="$(echo "$status_obj" | jq -r '.endpoints.openai // empty')"
if [ -z "$openai_endpoint" ]; then
  echo "Server does not have an OpenAI endpoint."
  exit 1
fi

model_name="$(qwen-vl get model-name 2>/dev/null || true)" # model name isn't always set

export OPENAI_BASE_URL="$openai_endpoint"
export MODEL_NAME="$model_name"

$SNAP/bin/go-chat-client
