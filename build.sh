python ./generate_includes.py

cd /home/huy/repositories/zmk/app
config_folder="/home/huy/repositories/zmk-config"

side() {
	board_info="nice_nano_v2 -- -DSHIELD=kyria_rev3_$1 -DZMK_CONFIG=$config_folder/config"
	west build -d build/$1 -b $board_info
	# west build -d build/$1 -b nice_nano_v2 -- -DSHIELD=kyria_rev3_$1 -DZMK_CONFIG=$config_folder

	cp ./build/$1/zephyr/zmk.uf2  /run/media/huy/NICENANO$2/zmk.uf2
	cp ./build/$1/zephyr/zmk.uf2  "$config_folder/backups/$1.uf2"
	# cp ./build/$1/zephyr/zmk.uf2  /mnt/chromeos/removable/NICENANO$1/zmk.uf2
}

left() {
	side left $@
}

right() {
	side right $@
}

if [ $# -eq 0 ]; then
	left &
	right 1 &
	exit 0
elif declare -f "$1" > /dev/null; then
	"$@"
	exit 0
else
	# Show a helpful error
	echo "'$1' is not a known function name" >&2
	exit 1
fi
