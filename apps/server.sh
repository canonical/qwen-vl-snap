#!/bin/bash -u

server=$(snapctl get server)
if [ -z "$server" ]; then
  echo "Server is not set"
  exit 1
fi

exec "$server" "$@"
