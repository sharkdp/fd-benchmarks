#!/bin/bash

source "prelude.sh"

COMMAND_FIND="find '$SEARCH_ROOT' -type l"
COMMAND_FD="fd -HI --type l '' '$SEARCH_ROOT'"

hyperfine --warmup "$WARMUP_COUNT" \
    "$COMMAND_FIND" \
    "$COMMAND_FD"

check_for_differences "false" "$COMMAND_FIND" "$COMMAND_FD"
