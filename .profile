#
# ~/.profile
#
[ -r "$HOME/.profile.local" ] && . "$HOME/.profile.local"

if [ "$0" = "sh" -o "$0" = "-sh" ]
then
    ENV="$HOME/.shrc"; export ENV
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

if type my-init > /dev/null 2>&1 && [ ! -f "$HOME/._.djmoch" ]
then
    my-init
fi

my login
