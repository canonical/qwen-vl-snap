#!/bin/bash -u

engine_type=$(snapctl get engine-type)
if [ -z "$engine_type" ]; then
  echo "Engine type is not set"
  exit 1
fi

exec "$SNAP/apps/run-server-$engine_type" "$@"
