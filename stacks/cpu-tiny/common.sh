#!/bin/bash -eu

engine="$SNAP_COMPONENTS/$(snapctl get engine)"
model="$SNAP_COMPONENTS/$(snapctl get model)"
mmproject="$SNAP_COMPONENTS/$(snapctl get mmproject)"

if [ ! -d "$model" ]; then
    echo "Missing component: $model"
    exit 1
fi

if [ ! -d "$mmproject" ]; then
    echo "Missing component: $mmproject"
    exit 1
fi

source "$model/init" # exports MODEL_FILE
source "$mmproject/init" # export MMPROJ_FILE

if [ ! -d "$engine" ]; then
    echo "Missing component: $engine"
    exit 1
fi

# For staged shared objects
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$engine/usr/lib/$ARCH_TRIPLET:$engine/usr/local/lib"
