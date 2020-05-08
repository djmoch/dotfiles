type feh > /dev/null 2>&1 || return

feh() {
	command feh --auto-rotate --scale-down "$@"
}
