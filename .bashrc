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

if [ $TERM = linux ]
then
    usercolor='\[\033[01;34m\]'
else
    usercolor='\[\033[34m\]'
fi

export PS1=$usercolor'\u\[\033[m\]@\[\033[32m\]\h:\[\033[m\]\W\[\033[31m\]$(__git_ps1 " (%s)")\[\033[m\]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'

[ -r "$BASH_COMPLETION" ] && source "$BASH_COMPLETION"
unset BASH_COMPLETION

_my()
{
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    selector="${COMP_WORDS[1]}"
    opts="term lock wallpaper standby shutdown perms init open sound \
        kbopts screen brightness battery status i3status copy paste \
        netrc dotfiles cron login_async login"

    case "$selector" in
        sound)
            if [ "$prev" = "$selector" ]
            then
                opts="status set-sink-volume set-source-volume \
                    set-sink-mute set-source-mute"
                COMPREPLY=( $(compgen -W "$opts" -- $cur) )
            elif [[ "$prev" == *"-mute" ]]
            then
                COMPREPLY=( $(compgen -W "toggle" -- $cur) )
            elif [ "$prev" = "set-sink-volume" ]
            then
                sinks=$(my sound list sinks short | cut -f 1)
                COMPREPLY=( $(compgen -W "$sinks" -- $cur) )
            elif [ "$prev" = "set-source-volume" ]
            then
                sources=$(my sound list sources short | cut -f 1)
                COMPREPLY=( $(compgen -W "$sources" -- $cur) )
            fi
            return 0
            ;;
        brightness)
            opts="monitor kbd"
            if [ "$prev" = "$selector" ]
            then
                COMPREPLY=( $(compgen -W "$opts" -- $cur) )
            elif [[ "$opts" == *"$prev"* ]]
            then
                COMPREPLY=( $(compgen -W "inc dec" -- $cur) )
            fi
            return 0
            ;;
        battery)
            opts="remaining total percent"
            [ "$prev" = "$selector" ] && COMPREPLY=( $(compgen -W \
                "$opts" -- $cur) )
            return 0
            ;;
        dotfiles)
            opts="check update"
            [ "$prev" = "$selector" ] && COMPREPLY=( $(compgen -W "$opts" -- $cur) )
            return 0
            ;;
        open)
            _filedir
            return 0
            ;;
        init)
            opts="-f -c"
            [ "$prev" = "$selector" ] && COMPREPLY=( $(compgen -W "$opts" -- $cur) )
            return 0
            ;;
        netrc)
            [ -f "$HOME/.netrc" ] || return 1

            machines=$(cat "$HOME/.netrc" | grep ^machine | cut -d ' ' -f 2)
            opts="login account password"

            if [ "$prev" = "$selector" ]
            then
                COMPREPLY=( $(compgen -W "$machines" -- $cur) )
                return 0
            elif [[ "$opts" == *"${COMP_WORDS[COMP_CWORD-1]}"* ]]
            then
                return 0
            else
                COMPREPLY=( $(compgen -W "$opts" -- $cur) )
                return 0
            fi
            ;;
        *)
        ;;
    esac

    [ "$cur" = "$selector" ] && COMPREPLY=($(compgen -W "$opts" -- $cur))
    return 0
}
complete -F _my my
