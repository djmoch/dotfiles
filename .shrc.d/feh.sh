type feh > /dev/null 2>&1 || return

feh() {
	feh --auto-rotate --scale-down "$@"
}
