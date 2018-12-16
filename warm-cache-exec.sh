#!/bin/bash

source "prelude.sh"

COMMAND_FIND_EXEC="find '$SEARCH_ROOT' -iname '*.txt' -exec wc -l {} \\;"
COMMAND_FIND_XARGS="find '$SEARCH_ROOT' -iname '*.txt' -print0 | xargs -0 -L1 wc -l"
COMMAND_FIND_PARALLEL="find '$SEARCH_ROOT' -iname '*.txt' | parallel wc -l"
COMMAND_FD_EXEC="fd --hidden --no-ignore -e txt '' '$SEARCH_ROOT' --exec wc -l"
COMMAND_FD_XARGS="fd --hidden --no-ignore -e txt '' '$SEARCH_ROOT' -0 | xargs -0 -L1 wc -l"
COMMAND_FD_PARALLEL="fd --hidden --no-ignore -e txt '' '$SEARCH_ROOT' | parallel wc -l"

hyperfine --warmup "$WARMUP_COUNT" \
    "$COMMAND_FIND_EXEC" \
    "$COMMAND_FIND_XARGS" \
    "$COMMAND_FIND_PARALLEL" \
    "$COMMAND_FD_EXEC" \
    "$COMMAND_FD_XARGS" \
    "$COMMAND_FD_PARALLEL" \
    --export-markdown results-warm-cache-exec.md

check_for_differences "false" "$COMMAND_FIND_EXEC" "$COMMAND_FD_EXEC"
