#!/bin/bash

# Base directory for all benchmark searches
export SEARCH_ROOT="$HOME"

# Whether or not to check for differences in the output of 'find' and 'fd'
export CHECK_DIFF="true"

# Number of warmup runs for "warm cache" benchmarks
export WARMUP_COUNT=3

# Cache-drop command for "cold cache" benchmarks
export RESET_CACHES="sync; echo 3 | sudo tee /proc/sys/vm/drop_caches"
