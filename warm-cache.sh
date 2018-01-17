#!/bin/bash

if ! which bench > /dev/null 2>&1; then
    echo "'bench' does not seem to be installed."
    echo "You can get it here: https://github.com/Gabriel439/bench"
    exit 1
fi

base_path="$HOME"
# base_path="/mnt/daten/"

# Warmup run
echo -n "Running warmup ... "
fd --hidden --no-ignore "" "$base_path" > /dev/null
echo "done"
echo

cmd_find="find '$base_path' -iregex '.*[0-9]\.jpg$'"
cmd_find2="find '$base_path' -iname '*[0-9].jpg'"
cmd_fd="fd --hidden --no-ignore '.*[0-9]\.jpg$' '$base_path'"
cmd_fd2="fd '[0-9]\.jpg$' '$base_path'"

# cmd_fd="fd '^warm-cache.sh$' '$base_path'"
# cmd_find="find '$base_path' -iname warm-cache.sh"

rm results.csv
bench --csv results.csv --output index.html "$cmd_find || true" "$cmd_find2 || true" "$cmd_fd" "$cmd_fd2"

eval "$cmd_fd" | sort > /tmp/results.fd
eval "$cmd_find" 2> /dev/null | sort > /tmp/results.find
if diff -q /tmp/results.fd /tmp/results.find > /dev/null; then
    echo "Both fd and find found the same $(wc -l /tmp/results.fd) files"
else
    echo "WARNING: There were differences between the search results of fd and find!"
fi
