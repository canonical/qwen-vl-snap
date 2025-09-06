#!/bin/bash -eu

runtime="$SNAP_COMPONENTS/$(snapctl get runtime)"
model="$SNAP_COMPONENTS/$(snapctl get model)"
mmproj="$SNAP_COMPONENTS/$(snapctl get multimodel-projector)"

if [ ! -d "$model" ]; then
    echo "Missing component: $model"
    exit 1
fi

if [ ! -d "$mmproj" ]; then
    echo "Missing component: $mmproj"
    exit 1
fi

source "$model/init" # exports MODEL_FILE
source "$mmproj/init" # export MMPROJ_FILE

if [ ! -d "$runtime" ]; then
    echo "Missing component: $runtime"
    exit 1
fi

# For staged shared objects
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$runtime/usr/lib/$ARCH_TRIPLET:$runtime/usr/local/lib"
