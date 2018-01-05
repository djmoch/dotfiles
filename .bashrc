#
# ~/.bashrc
#
[ -r "$HOME/.shrc" ] && source "$HOME/.shrc"
[ -r "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"

shopt -s globstar

export HISTCONTOL=erasedups

# Git command line configuration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source "$HOME/.config/bash/git-prompt.sh"

# Customize the prompt
export PS1='\[\033[34m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[m\]\W\[\033[31m\]$(__git_ps1 " (%s)")\[\033[m\]\$ '

# Configure Homebrew
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

# $BASH_COMPLETION should contain the path to the bash_completion
# script. If the variable is defined and is readable, it will be
# sourced.
#
# NOTE: Might want to check that this isn't already sourced elsewhere
# (e.g.  /etc/profile).
[ -r "$BASH_COMPLETION" ] && source "$BASH_COMPLETION"
unset BASH_COMPLETION

if [[ "$OSTYPE" == "darwin"* ]]
then
    alias jackd="jackd -d coreaudio > /dev/null 2>&1 &"
fi

if command -v archey3 > /dev/null 2>&1 && [ -z "$TMUX"  ]
then
    archey3
fi
