# fd-benchmarks

This repository contains a few scripts to run benchmarks, comparing
[`fd`](https://github.com/sharkdp/fd) with `find`.

To run these benchmarks:

1. Install [hyperfine](https://github.com/sharkdp/hyperfine).
2. Adapt the `SEARCH_ROOT` in `config.sh`.
3. Run any of the `warm-cache-*.sh` or `cold-cache-*.sh` scripts.
