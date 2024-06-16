[ -z "$ENV" ] || . "$ENV"
bindkey -M emacs '\MB' backward-word
bindkey -M emacs '\MF' forward-word
unset HISTFILE
setopt NOMONITOR NOHUP POSIX_JOBS
