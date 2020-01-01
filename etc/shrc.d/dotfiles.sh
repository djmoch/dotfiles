dotfiles() {
	git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

dot() {
	dotfiles "$@"
}
