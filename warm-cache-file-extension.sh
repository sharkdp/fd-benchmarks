#!/bin/bash

source "prelude.sh"

EXT="jpg"

COMMAND_FIND="find '$SEARCH_ROOT' -iname '*.$EXT'"
COMMAND_FD="fd -HI --extension '$EXT' '' '$SEARCH_ROOT'"

hyperfine --warmup "$WARMUP_COUNT" \
    "$COMMAND_FIND" \
    "$COMMAND_FD"

check_for_differences "false" "$COMMAND_FIND" "$COMMAND_FD"
