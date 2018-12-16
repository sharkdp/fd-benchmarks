#!/bin/bash

source "prelude.sh"

ask_for_sudo

PATTERN='.*[0-9]\.jpg$'

COMMAND_FD="fd -HI '$PATTERN' '$SEARCH_ROOT'"
COMMAND_FIND="find '$SEARCH_ROOT' -iregex '$PATTERN'"

hyperfine \
    --min-runs 3 \
    --prepare "$RESET_CACHES" \
    "$COMMAND_FIND" \
    "$COMMAND_FD" \
    --export-markdown results-cold-cache-simple-pattern.md

check_for_differences "false" "$COMMAND_FIND" "$COMMAND_FD"
