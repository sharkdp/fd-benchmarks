#!/bin/bash

export SEARCH_ROOT="$HOME"

# Number of warmup runs for "warm cache" benchmarks
export WARMUP_COUNT=3

# Cache-drop command for "cold cache" benchmarks
export RESET_CACHES="sync; echo 3 | sudo tee /proc/sys/vm/drop_caches"
