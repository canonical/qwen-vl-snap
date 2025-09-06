#!/bin/bash -eu

exit_error() {
  echo "Error: ${1}" >&2
  exit 1
}

help() {
  echo "Usage:" >&2
  echo "  $0 <engine-name> [--dryrun]" >&2
  echo "" >&2
  echo "Options:" >&2
  echo "  --dryrun    Generate snapcraft.yaml without building the snap." >&2
}

if [[ "$(yq --version)" != *v4* ]]; then
  exit_error "Please install yq v4."
fi

if [ -z "${1-}" ]; then
  help
  exit_error "No engine provided"
fi

engine_name="${1-}"
echo "Engine selected: '$engine_name'"

engine_dir="engines/$engine_name"
manifest_file="$engine_dir/engine.yaml"
if [ ! -d "$engine_dir" ]; then
  exit_error "Engine '$engine_name' does not exist."
fi

# Load selected engine.yaml into variable, explode to evaluate aliases
manifest_yaml=$(yq '. | explode(.)' "$manifest_file")
if [[ -z "$manifest_yaml" ]]; then
  exit_error "Engine manifest '$manifest_file' is empty"
fi

# Creates the components array with the contents of the .components[] list
readarray -t components < <(yq '.components[]' "$manifest_file")

# Check if array length is 0
if [[ ${#components[@]} -eq 0 ]]; then
  exit_error "Engine '$manifest_file' has no components"
fi
echo "Engine components: ${components[*]}"

# Converts the array into a regex
printf -v llm_pieces "%s|" "${components[@]}"

echo "Generating new snapcraft.yaml"
essentials="app-scripts|engines|stack-utils|go-chat-client|common-runtime-dependencies|opencl-driver"

# Copy snap/snapcraft.yaml to snapcraft.yaml, retaining only the parts and components that match the regex
yq "explode(.) |
  .parts |= with_entries(select(.key | test(\"^(${llm_pieces}${essentials})$\"))) |
  .components |= with_entries(select(.key | test(\"^(${llm_pieces})$\")))
" snap/snapcraft.yaml | tee snapcraft.yaml > /dev/null

if [[ ${2-} == "--dryrun" ]]; then
  exit 0
fi

echo "Building snap with engine '$engine_name'"
snapcraft -v pack || true
rm -f snapcraft.yaml
