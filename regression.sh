#!/bin/bash

source "prelude.sh"

heading() {
    bold=$(tput bold)$(tput setaf 220)
    normal=$(tput sgr0)
    printf "\n%s%s%s\n\n" "$bold" "$1" "$normal"
}

FD1="./fd-master"
FD2="./fd-feature"

rm -f regression-results/*.md

heading "No pattern"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 --hidden --no-ignore '' '$SEARCH_ROOT'" \
    "$FD2 --hidden --no-ignore '' '$SEARCH_ROOT'" \
    --export-markdown regression-results/no-pattern.md

heading "Simple pattern"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    "$FD2 '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    --export-markdown regression-results/simple-pattern.md

heading "Simple pattern (-HI)"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 -HI '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    "$FD2 -HI '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    --export-markdown regression-results/simple-pattern-all.md

heading "File extension"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 -HI --extension jpg '' '$SEARCH_ROOT'" \
    "$FD2 -HI --extension jpg '' '$SEARCH_ROOT'" \
    --export-markdown regression-results/file-extension.md

heading "File type"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 -HI --type l '' '$SEARCH_ROOT'" \
    "$FD2 -HI --type l '' '$SEARCH_ROOT'" \
    --export-markdown regression-results/file-type.md

ask_for_sudo

heading "Cold cache"
hyperfine \
    --min-runs 3 \
    --prepare "$RESET_CACHES" \
    "$FD1 -HI '.*[0-9]\.jpg$' '$SEARCH_ROOT'" \
    "$FD2 -HI '.*[0-9]\.jpg$' '$SEARCH_ROOT'" \
    --export-markdown regression-results/simple-pattern-cold-cache.md
