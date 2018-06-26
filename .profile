#
# ~/.profile
#
[ -r "$HOME/.profile.local" ] && . "$HOME/.profile.local"

if [ "$0" = "sh" -o "$0" = "-sh" ]
then
    HOSTNAME=`hostname | cut -d . -f 1`
    ENV="$HOME/.shrc"; export ENV
    printf "\033]0;${USER}@${HOSTNAME}\007"
fi

if type vim > /dev/null 2>&1
then
    EDITOR=vim
else
    EDITOR=vi
fi

VISUAL=$EDITOR
PAGER=less
LESS="-FMRqX#10"
export EDITOR VISUAL PAGER LESS

WWW_HOME=https://danielmoch.com; export WWW_HOME

if type lesspipe > /dev/null 2>&1
then
    eval `lesspipe`
else
    LESSOPEN="|$HOME/.lessfilter %s"
    export LESSOPEN
fi

if type brew > /dev/null 2>&1
then
    HOMEBREW_NO_ANALYTICS=1
    HOMEBREW_NO_INSECURE_REDIRECT=1
    HOMEBREW_CASK_OPTS=--require-sha\ --appdir="$HOME/Applications"
    HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_ANALYTICS HOMEBREW_NO_INSECURE_REDIRECT
    export HOMEBREW_CASK_OPTS HOMEBREW_NO_AUTO_UPDATE
fi

if type go > /dev/null 2>&1
then
    GOPATH="$HOME/.go"
    export GOPATH
fi

__addpath ()
{
    if [ -d "$1" ]
    then
        case ":$PATH:" in
            *:"$1":*)
                ;;
            *)
                if [ -z "$2" ]
                then
                    PATH="$PATH:$1"
                else
                    PATH="$1:$PATH"
                fi
        esac
    fi
}

__addpath "$HOME/.go/bin"
__addpath "$HOME/.cargo/bin"
if type brew > /dev/null 2>&1
then
    __addpath "`brew --prefix`/bin" "before"
fi
__addpath "$HOME/.local/bin" "before"

unset __addpath
export PATH

if [ -z "$SSH_TTY" ] && type gpgconf > /dev/null 2>&1
then
    if [ "`gpgconf --list-dirs agent-ssh-socket | wc -l`" -eq 1 ]
    then
        unset SSH_AGENT_PID
        SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
        export SSH_AUTH_SOCK
    fi
fi

if type my-init > /dev/null 2>&1 && [ ! -f "$HOME/._.djmoch" ]
then
    my-init
fi

my login
