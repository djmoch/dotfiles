type rsync > /dev/null 2>&1 || return

rsync() {
	rsync -C --include=.git "$@"
}
