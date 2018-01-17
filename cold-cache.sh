echo "This script will now ask for your password in order to gain root/sudo"
echo "permissions. These are required to reset the harddisk caches."
echo ""

sudo echo "Okay, acquired superpowers :-)" || exit

base_path="/mnt/daten"
pattern='.*[0-9]\.jpg$'

for _ in $(seq 1 3); do
    echo
    echo -n "Resetting caches ... "
    sync; echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    echo "okay"
    echo
    echo "Timing 'fd':"
    time fd -HI --full-path "$pattern" "$base_path" > /dev/null

    echo
    echo -n "Resetting caches ... "
    sync; echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    echo "okay"
    echo
    echo "Timing 'find':"
    time find "$base_path" -iregex "$pattern" > /dev/null 2> /dev/null
done
