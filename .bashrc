# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f $HOME/.bashrc.local ]]
then
    source $HOME/.bashrc.local
fi

export EDITOR=vim
export HISTCONTOL=erasedups

# Keep the go folder hidden
if command -v go > /dev/null 2>&1
then
    export GOPATH=$HOME/.go
fi

# Turn on ls colors
if command -v dircolors > /dev/null 2>&1
then
    eval $(dircolors $HOME/.dircolors)
    alias ls='ls --color=auto'
else
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
fi

# Colorize others if they exist
COLORIZE_CMDS="pacman grep egrep fgrep"
for cmd in $COLORIZE_CMDS
do
    if command -v $cmd > /dev/null 2>&1
    then
        alias $cmd="$cmd --color=auto"
    fi
done

# Configure GPG and start the agent if it isn't already running
if command -v gpg-connect-agent > /dev/null 2>&1
then
    gpg-connect-agent /bye > /dev/null 2>&1
fi

# Configure GPG as an SSH key provider
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
unset SSH_AGENT_PID

# Assume SSH agent is forwarded if we're in an SSH session
if [[ -z "$SSH_TTY" ]]
then
    if [[ -S $HOME/.gnupg/S.gpg-agent.ssh ]]
    then
        export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
    elif [[ -S /run/user/$UID/gnupg/S.gpg-agent.ssh ]]
    then
        export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    fi
fi

# Git command line configuration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source $HOME/.config/bash/git-prompt.sh

# Customize the prompt
export PS1='\[\033[34m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[m\]\W\[\033[31m\]$(__git_ps1 " (%s)")\[\033[m\]\$ '

# Append our default paths
__appendpath () {
    if [[ -d "$1" ]]
    then
        case ":$PATH:" in
            *:"$1":*)
                ;;
            *)
                PATH="$PATH:$1"
        esac
    fi
}

__appendpath "$HOME/.go/bin"
__appendpath "$HOME/.cargo/bin"
__appendpath "$HOME/.local/bin"

# Configure Homebrew
if command -v brew > /dev/null 2>&1
then
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS=--require-sha\ --appdir=$HOME/Applications
    export HOMEBREW_NO_AUTO_UPDATE=1
    export PATH=$(brew --prefix)/bin:$PATH
    if [ -f $(brew --prefix)/etc/bash_completion ]
    then
        source $(brew --prefix)/etc/bash_completion
    fi
fi

# $BASH_COMPLETION should contain the path to the bash_completion
# script. If the variable is defined and is readable, it will be
# sourced.
#
# NOTE: Might want to check that this isn't already sourced elsewhere
# (e.g.  /etc/profile).
if [[ -n "$BASH_COMPLETION" ]] && [[ -r $BASH_COMPLETION ]]
then
    source $BASH_COMPLETION
fi
unset BASH_COMPLETION

# Handy Tmux aliases
if command -v tmux > /dev/null 2>&1
then
    alias tas=tmux\ attach-session\ -t
    alias tns=tmux\ new-session\ -s
    alias tls=tmux\ list-sessions
fi

if [[ $OSTYPE == "darwin"* ]]
then
    alias jackd="jackd -d coreaudio > /dev/null 2>&1 &"
fi

ix()
{
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
        case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
        esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] &&
    {
        local filename="$1"
        shift
        [ "$filename" ] &&
            {
                curl $opts -F f:1=@"$filename" $* ix.io/$id
                return
            }
            echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}

if command -v archey3 > /dev/null 2>&1 && [[ -z "$TMUX"  ]]
then
    archey3
fi
