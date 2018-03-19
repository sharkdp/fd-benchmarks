#!/bin/bash

source "prelude.sh"

COMMAND_FIND="find '$SEARCH_ROOT' -type l"
COMMAND_FD="fd -HI '' '$SEARCH_ROOT' --type l"

hyperfine --warmup "$WARMUP_COUNT" \
    "$COMMAND_FIND" \
    "$COMMAND_FD"

check_for_differences "false" "$COMMAND_FIND" "$COMMAND_FD"
