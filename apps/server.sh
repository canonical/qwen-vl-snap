#!/bin/bash -eu

engine_manifest=$(qwen-vl show-engine)
engine="$(echo "$engine_manifest" | yq .name)"
required_components="$(echo "$engine_manifest" | yq .components[])"
unset engine_manifest

# Check for missing components
missing_components=()
for component in $required_components; do
    if [ ! -d "$SNAP_COMPONENTS/$component" ]; then
        missing_components+=("$component")
    fi
done

retry_count=0
max_retries=5
delay=5
while [ ${#missing_components[@]} -ne 0 ] && [ "$retry_count" -lt $max_retries ]; do
    echo "Error: missing required snap components: [${missing_components[*]}]"
    sleep "$delay"
    delay=$((delay + 5))
    ((retry_count++))
done

if [ ${#missing_components[@]} -ne 0 ]; then
    echo "Exiting due to missing components ([${missing_components[*]}]), after $max_retries retries."
    exit 1
fi


exec "$SNAP/engines/$engine/server" "$@"
