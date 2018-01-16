#
# ~/.profile
#
[ -r "$HOME/.profile.local" ] && . "$HOME/.profile.local"

if [ "$0" == "sh" -o "$0" == "-sh" ]
then
    ENV="$HOME/.shrc"; export ENV
fi

if type -p vim > /dev/null 2>&1
then
    EDITOR=vim
else
    EDITOR=vi
fi

VISUAL=$EDITOR
PAGER=less
LESS="-FMRqX#10"
export EDITOR VISUAL PAGER LESS

if type -p lesspipe > /dev/null 2>&1
then
    eval `lesspipe`
else
    LESSOPEN="|$HOME/.lessfilter %s"
    export LESSOPEN
fi

# Keep the go folder hidden
if type -p go > /dev/null 2>&1
then
    GOPATH="$HOME/.go"
    export GOPATH
fi

# Add our default paths
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
__addpath "$HOME/.local/bin" "before"

unset __addpath
export PATH

if type -p my-init > /dev/null 2>&1 && [ ! -f "$HOME/._.djmoch" ]
then
    my-init
fi
