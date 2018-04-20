#
# ~/.zshrc
#
[ -r "$HOME/.shrc" ] && source "$HOME/.shrc"
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

setopt auto_list extended_glob append_history hist_ignore_all_dups
setopt prompt_subst correct auto_param_slash

bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line

HISTSIZE=1000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=1000

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source "$HOME/.local/lib/sh/git-prompt.sh"

autoload -Uz colors && colors

if [ $TERM = linux ]
then
    usercolor="$fg_bold[blue]"
else
    usercolor="$fg[blue]"
fi
reset=$'\e[00m'

RPS1="[%?]"
PS1="%{$usercolor%}%n%{$reset%}@%{$fg[green]%}%m:%{$reset%}%c%{$fg[red]%}\$(__git_ps1 \" (%s)\")%{$reset%}%(!.#.\$) "
unset usercolor reset

precmd() { echo -ne "\033]0;${USER}@${HOST}:${PWD}\007" }
preexec() { echo -ne "\033]0;${USER}@${HOST}:${@}\007" }

[ -d /usr/share/zsh/site-functions/ ] && fpath=(/usr/share/zsh/site-functions/ $fpath)
[ -d "$HOME/.zsh/functions" ] && fpath=("$HOME/.zsh/functions" $fpath)

_my()
{
    local state ret=1

    typeset -A opt_args
    _arguments -C \
        ':subcommand:->subcommand' \
        '*::options:->options' && ret=0

    case $state in
        subcommand)
            subcommands=(
                'lock:lock the screen'
                'wallpaper:set the wallpaper'
                'standby:standby the machine'
                'shutdown:shut down the machine'
                'perms:set home folder perms'
                'init:initial setup'
                'open:open a file'
                'sound:adjust sound'
                'kbopts:set keyboard options'
                'screen:adjust screen'
                'brightness:adjust brightness'
                'battery:query battery information'
                'status:current status'
                'i3status:current status (i3status compatible)'
                'copy:copy'
                'paste:paste'
                'netrc:query netrc file'
                'dotfiles:operate on dotfiles'
                'cron:run cron jobs'
                'login_async:login (blocking)'
                'login:login'
            )
            _describe -t subcommands 'my subcommand' subcommands && ret=0
            ;;
        options)
            case $words[1] in
                sound)
                    if [ $CURRENT -eq 2 ]
                    then
                        subcommands=(
                            'status:current sound source/sink status'
                            'set-sink-volume:set speaker volume'
                            'set-source-volume:set input volume'
                            'set-sink-mute:set speaker mute'
                            'set-source-mute:set input mute'
                        )
                        _describe -t subcommands 'sound subcommand' subcommands && ret=0
                    elif [ $CURRENT -eq 3 ]
                    then
                        if [[ $words[2] = *"-mute" ]]
                        then
                            subcommands=(
                                'toggle:toggle sink/source state'
                            )
                            _describe -t subcommands "$words[2] subcommand" subcommands && ret=0
                        elif [ $words[2] = "set-sink-volume" ]
                        then
                            subcommands=($(my sound list sinks short | cut -f 1))
                            _describe -t subcommands 'set-sink-volume subcommand' subcommands && ret=0
                        elif [ $words[2] = "set-source-volume" ]
                        then
                            subcommands=($(my sound list sources short | cut -f 1))
                            _describe -t subcommands 'set-source-volume subcommand' subcommands && ret=0
                        fi
                    fi
                    ;;
                brightness)
                    if [ $CURRENT -eq 2 ]
                    then
                        subcommands=(
                            'monitor:adjust monitor brightness'
                            'kbd:adjust keyboard brightness'
                        )
                        _describe -t subcommands 'brightness subcommand' subcommands && ret=0
                    elif [ $CURRENT -eq 3 ]
                    then
                        subcommands=(
                            'inc:increase brightness'
                            'dec:decrease brightness'
                        )
                        _describe -t subcommands "$words[2] subcommand" subcommands && ret=0
                    fi
                    ;;
                battery)
                    if [ $CURRENT -eq 2 ]
                    then
                        subcommands=(
                            'remaining:raw remaining power'
                            'total:raw capacity'
                            'percent:percent remaining'
                        )
                        _describe -t subcommands 'battery subcommand' subcommands && ret=0
                    fi
                    ;;
                dotfiles)
                    if [ $CURRENT -eq 2 ]
                    then
                        subcommands=(
                            'check:check the age of the dotfiles'
                            'update:update the dotfiles'
                        )
                        _describe -t subcommands 'dotfiles subcommand' subcommands && ret=0
                    fi
                    ;;
                open)
                    _files
                    ;;
                init)
                    args=(
                        '-f[force re-initialization]'
                        '-c[install crontab]'
                    )
                    _arguments -C $args && ret=0
                    ;;
                netrc)
                    if [ $CURRENT -eq 2 ]
                    then
                        subcommands=($(grep \^machine "$HOME/.netrc" | cut -d ' ' -f 2))
                        _describe -t subcommands 'netrc subcommand' subcommands && ret=0
                    elif [ $CURRENT -eq 3 ]
                    then
                        subcommands=(
                            'login:user name'
                            'account:alternate account'
                            'password:password'
                        )
                        _describe -t subcommands 'netrc subcommand' subcommands && ret=0
                    fi
                    ;;
            esac
    esac
}
# The following lines were added by compinstall

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
# End of lines added by compinstall
compdef _my my
