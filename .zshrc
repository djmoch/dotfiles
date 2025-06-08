[ -z "$ENV" ] || . "$ENV"

bindkey -e
bindkey -M emacs '\Mb' backward-word
bindkey -M emacs '\Mf' forward-word
unset HISTFILE
setopt NOMONITOR NOHUP POSIX_JOBS

set_title() { print -Pn "\033]0;%n@%m:$1\007" }
preexec() { set_title "$2" }
precmd() { set_title "%~" }

[ -d /opt/homebrew/share/zsh/site-functions/ ] && fpath=(/opt/homebrew/share/zsh/site-functions/ $fpath)
[ -d "$HOME/lib/zsh-functions/" ] && fpath=(~/lib/zsh-functions/ $fpath)
autoload ghcs

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose false
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
