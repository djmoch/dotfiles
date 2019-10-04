type tmux > /dev/null 2>&1 || return

alias tas="tmux attach-session -t"
alias tns="tmux new-session -s"
alias tls="tmux list-sessions"
alias ts="tmux-session"
