#!/bin/bash

set -euo pipefail

# Export the configuration for content sharing.
$SNAP/bin/export-shared-configs.sh

engine="$(modelctl show-engine --format=json | jq -r .name)"
exec modelctl run -- "$SNAP/engines/$engine/server" "$@"
