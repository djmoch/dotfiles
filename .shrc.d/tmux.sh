type tmux > /dev/null 2>&1 || return

tas() {
	tmux attach-session -t "$@"
}

tns() {
	tmux new-session -s "$@"
}

tls() {
	tmux list-sessions "$@"
}

ts() {
	tmux-session "$@"
}
