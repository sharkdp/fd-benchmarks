#!/bin/bash

source "prelude.sh"

COMMAND_FIND="find '$SEARCH_ROOT'"
COMMAND_FD="fd --hidden --no-ignore '' '$SEARCH_ROOT'"

hyperfine --warmup "$WARMUP_COUNT" \
    "$COMMAND_FIND" \
    "$COMMAND_FD"

check_for_differences "true" "$COMMAND_FIND" "$COMMAND_FD"
