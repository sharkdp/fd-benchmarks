if ! which hyperfine > /dev/null 2>&1; then
    echo "'hyperfine' does not seem to be installed."
    echo "You can get it here: https://github.com/sharkdp/hyperfine"
    exit 1
fi

source "config.sh"

# Analysis
check_for_differences() {
    if [[ $CHECK_DIFF != "true" ]]; then
        return
    fi

    local skip_first
    local command_find
    local command_fd
    skip_first="$1"
    command_find="$2"
    command_fd="$3"

    if [[ $skip_first == "true" ]]; then
        command_find="$command_find | tail +2"
    fi

    eval "$command_find" | sort > /tmp/results.find
    eval "$command_fd"   | sort > /tmp/results.fd

    if diff -q /tmp/results.fd /tmp/results.find > /dev/null; then
        NUM_RESULTS=$(wc -l /tmp/results.fd | cut -d' ' -f 1)
        echo "Both fd and find found the same $NUM_RESULTS results"
    else
        echo "WARNING: There were differences between the search results of fd and find!"
        echo "Run 'diff /tmp/results.fd /tmp/results.find'."
    fi
}

ask_for_sudo() {
    echo "This script will now ask for your password in order to gain root/sudo"
    echo "permissions. These are required to reset the harddisk caches in between"
    echo "benchmark runs."
    echo ""

    sudo echo "Okay, acquired superpowers :-)" || exit

    echo ""
}
