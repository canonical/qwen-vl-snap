#!/bin/bash -eu

mkdir -p "$SNAP_DATA/share/endpoints"
qwen-vl status --format=json | yq -p=json '.endpoints' >"$SNAP_DATA/share/endpoints/endpoints.json"
