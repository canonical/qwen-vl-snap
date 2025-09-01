#!/bin/bash -eu

component_directory=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

model_file_path="$(snapctl get model-file-path)"
port="$(snapctl get http.port)"
host="$(snapctl get http.host)"

extra_args=()
# If a multi-modal project is set, pass it to the server
mmproj_file_path="$(snapctl get mmproj-file-path)"
if [ -n "$mmproj_file_path" ]; then
  extra_args+=("--mmproj" "$mmproj_file_path")
fi

verbose_logging="$(snapctl get verbose)"
if [[ "$verbose_logging" == "true" ]]; then
  extra_args+=("--verbose")
fi

gpu_layers="$(snapctl get gpu-layers)"
if [ -n "$gpu_layers" ]; then
  extra_args+=("--n-gpu-layers" "$gpu_layers")
fi

server_shared_objects="$component_directory/usr/lib/$ARCH_TRIPLET:$component_directory/usr/local/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$server_shared_objects"

exec "$component_directory/usr/local/bin/llama-server" \
--model "$model_file_path" \
--port "$port" \
--host "$host" \
"${extra_args[@]}" \
"$@"
