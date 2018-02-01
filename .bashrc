#
# ~/.bashrc
#
[ -r "$HOME/.shrc" ] && source "$HOME/.shrc"
[ -r "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"

shopt -s globstar

export HISTCONTOL=erasedups

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source "$HOME/.local/lib/sh/git-prompt.sh"

if [ x$TERM == xlinux ]
then
    usercolor='\[\033[01;34m\]'
else
    usercolor='\[\033[34m\]'
fi

export PS1=$usercolor'\u\[\033[m\]@\[\033[32m\]\h:\[\033[m\]\W\[\033[31m\]$(__git_ps1 " (%s)")\[\033[m\]\$ '

if command -v brew > /dev/null 2>&1
then
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS=--require-sha\ --appdir="$HOME/Applications"
    export HOMEBREW_NO_AUTO_UPDATE=1
    export PATH="$(brew --prefix)/bin:$PATH"
    if [ -f "$(brew --prefix)/etc/bash_completion" ]
    then
        source "$(brew --prefix)/etc/bash_completion"
    fi
fi

[ -r "$BASH_COMPLETION" ] && source "$BASH_COMPLETION"
unset BASH_COMPLETION

if [[ "$OSTYPE" == "darwin"* ]]
then
    alias jackd="jackd -d coreaudio > /dev/null 2>&1 &"
fi
