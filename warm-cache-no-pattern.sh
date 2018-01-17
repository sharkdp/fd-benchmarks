#!/bin/bash

# the root directory for the search
# base_path="/mnt/daten/Daten/"
base_path="$HOME/Informatik/"
# base_path="$HOME/Dropbox/"
# base_path="$HOME"

if ! which bench > /dev/null 2>&1; then
    echo "'bench' does not seem to be installed."
    echo "You can get it here: https://github.com/Gabriel439/bench"
    exit 1
fi

# Warmup run
echo -n "Running warmup "
for i in {1..5}; do
    echo -n "."
    fd --hidden --no-ignore "" "$base_path" > /dev/null
done
echo " done"
echo

# Benchmark
cmd_find="find '$base_path'"
cmd_fd="fd --hidden --no-ignore '' '$base_path'"

bench "$cmd_find || true" "$cmd_fd"

# Analysis
eval "$cmd_fd" | sort > /tmp/results.fd
eval "$cmd_find || true" | tail +2 | sort > /tmp/results.find

if diff -q /tmp/results.fd /tmp/results.find > /dev/null; then
    echo "Both fd and find found the same $(wc -l /tmp/results.fd | cut -d' ' -f 1) files"
else
    echo "WARNING: There were differences between the search results of fd and find!"
    echo "Run 'diff /tmp/results.fd /tmp/results.find'."
fi
