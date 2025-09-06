#!/bin/bash -u

stack="$(snapctl get stack)"

exec "$SNAP/engines/$stack/server" "$@"
