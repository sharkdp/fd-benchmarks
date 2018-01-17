if ! which hyperfine > /dev/null 2>&1; then
    echo "'hyperfine' does not seem to be installed."
    echo "You can get it here: https://github.com/sharkdp/hyperfine"
    exit 1
fi

source "config.sh"

ask_for_sudo() {
    echo "This script will now ask for your password in order to gain root/sudo"
    echo "permissions. These are required to reset the harddisk caches in between"
    echo "benchmark runs."
    echo ""

    sudo echo "Okay, acquired superpowers :-)" || exit

    echo ""
}
