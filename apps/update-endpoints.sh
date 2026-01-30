#!/bin/bash -eu
set -o pipefail

mkdir -p "$SNAP_DATA/share/endpoints"
if ! qwen-vl status --format=json | yq -p=json '.endpoints' >"$SNAP_DATA/share/endpoints/endpoints.json"; then
    echo "Error: Failed to update endpoints. 'qwen-vl status' or 'yq' command failed." >&2
    exit 1
fi
