type rsync > /dev/null 2>&1 || return

rsync() {
	command rsync -C --include=.git "$@"
}
