#!/bin/bash

source "prelude.sh"

COMMAND_FIND="find '$SEARCH_ROOT' -iregex '.*[0-9]\\.jpg$'"
COMMAND_FIND2="find '$SEARCH_ROOT' -iname '*[0-9].jpg'"
COMMAND_FD="fd -HI '.*[0-9]\\.jpg$' '$SEARCH_ROOT'"
COMMAND_FD2="fd '.*[0-9]\\.jpg$' '$SEARCH_ROOT'"

hyperfine --warmup "$WARMUP_COUNT" \
    "$COMMAND_FIND" \
    "$COMMAND_FIND2" \
    "$COMMAND_FD" \
    "$COMMAND_FD2" \
    --export-markdown results-warm-cache-simple-pattern.md

check_for_differences "false" "$COMMAND_FIND" "$COMMAND_FD"
