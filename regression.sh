#!/bin/bash
#
# This script runs benchmarks comparing two different `fd` binaries.
#
# You should compile the two binaries you want to test, then move them
# into this directory as `fd-master` and `fd-feature` (or change the `FD1` and
# `FD2` paths below).

source "prelude.sh"

FD1="./fd-master"
FD2="./fd-feature"
RESULT_DIR="regression-results"
REPORT="$RESULT_DIR/report.md"

heading() {
    bold=$(tput bold)$(tput setaf 220)
    normal=$(tput sgr0)
    echo
    echo
    printf "\n%s%s%s\n\n" "$bold" "$1" "$normal"

    echo -e "\n### $1\n" >> "$REPORT"
}

mkdir -p "$RESULT_DIR"
rm -f "$RESULT_DIR"/*.md

echo "## \`fd\` regression benchmark" >> "$REPORT"

heading "No pattern"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 --hidden --no-ignore '' '$SEARCH_ROOT'" \
    "$FD2 --hidden --no-ignore '' '$SEARCH_ROOT'" \
    --export-markdown "$RESULT_DIR/01-no-pattern.md" \
    --export-json "$RESULT_DIR/01-no-pattern.json"
cat "$RESULT_DIR/01-no-pattern.md" >> "$REPORT"

heading "Simple pattern"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    "$FD2 '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    --export-markdown "$RESULT_DIR/02-simple-pattern.md" \
    --export-json "$RESULT_DIR/02-simple-pattern.json"
cat "$RESULT_DIR/02-simple-pattern.md" >> "$REPORT"

heading "Simple pattern (-HI)"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 -HI '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    "$FD2 -HI '.*[0-9]\\.jpg$' '$SEARCH_ROOT'" \
    --export-markdown "$RESULT_DIR/03-simple-pattern-all.md" \
    --export-json "$RESULT_DIR/03-simple-pattern-all.json"
cat "$RESULT_DIR/03-simple-pattern-all.md" >> "$REPORT"

heading "File extension"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 -HI --extension jpg '' '$SEARCH_ROOT'" \
    "$FD2 -HI --extension jpg '' '$SEARCH_ROOT'" \
    --export-markdown "$RESULT_DIR/04-file-extension.md" \
    --export-json "$RESULT_DIR/04-file-extension.json"
cat "$RESULT_DIR/04-file-extension.md" >> "$REPORT"

heading "File type"
hyperfine --warmup "$WARMUP_COUNT" \
    "$FD1 -HI --type l '' '$SEARCH_ROOT'" \
    "$FD2 -HI --type l '' '$SEARCH_ROOT'" \
    --export-markdown "$RESULT_DIR/05-file-type.md" \
    --export-json "$RESULT_DIR/05-file-type.json"
cat "$RESULT_DIR/05-file-type.md" >> "$REPORT"

ask_for_sudo

heading "Cold cache"
hyperfine \
    --min-runs 3 \
    --prepare "$RESET_CACHES" \
    "$FD1 -HI '.*[0-9]\.jpg$' '$SEARCH_ROOT'" \
    "$FD2 -HI '.*[0-9]\.jpg$' '$SEARCH_ROOT'" \
    --export-markdown "$RESULT_DIR/06-simple-pattern-cold-cache.md" \
    --export-json "$RESULT_DIR/06-simple-pattern-cold-cache.json"
cat "$RESULT_DIR/06-simple-pattern-cold-cache.md" >> "$REPORT"

echo
echo "Wrote markdown report to '$RESULT_DIR/report.md'"
