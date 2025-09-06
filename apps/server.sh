#!/bin/bash -u

engine="$(snapctl get engine)"

exec "$SNAP/engines/$engine/server" "$@"
