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
delay=10
max_retries=360 # 10 seconds * 360 = 1 hour
while [ ${#missing_components[@]} -ne 0 ] && [ "$retry_count" -lt $max_retries ]; do
    echo "Missing required snap components: [${missing_components[*]}], retrying in $delay seconds..."
    sleep "$delay"
    ((retry_count++))
done

if [ ${#missing_components[@]} -ne 0 ]; then
    echo "Error: timed out after $max_retries retries, missing components [${missing_components[*]}]."
    exit 1
fi


exec "$SNAP/engines/$engine/server" "$@"
