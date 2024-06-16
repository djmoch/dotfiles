set -a
PATH="$PATH:$HOME/bin"
HOSTNAME=$(hostname | cut -d. -f1)
ENV="$HOME/etc/shrc"
LANG=en_US.UTF-8
EDITOR=ed
FCEDIT=ed
XDG_CONFIG_HOME="$HOME/etc"
XDG_CACHE_HOME="$HOME/var/cache"
XDG_DATA_HOME="$HOME/var"
PYTHONUSERBASE="$HOME"
GOPATH="$HOME"
TMPDIR="$HOME/tmp"
PYTHONSTARTUP="$HOME/etc/pythonrc"
GOPRIVATE=djmo.ch
SQLITE_HISTORY=/dev/null
NO_COLOR=1

case $HOSTNAME in
	aluminum)
		unset FCEDIT
		PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
		INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
		PLAN9=/usr/local/plan9
		font=/mnt/font/GoRegular/15a/font
		EDITOR=E
		PAGER=nobs
		PASSAGE_DIR=$XDG_CACHE_HOME/password-store/store
		PASSAGE_IDENTITIES_FILE=$XDG_CACHE_HOME/password-store/identities
		PATH=$PATH:$PLAN9/bin
		MANPATH="/opt/homebrew/share/man::$HOME/man"
		ZET_HOME="$HOME/Documents/z/zet"
		;;
	carbon)
		unset FCEDIT
		font=/mnt/font/DejaVuSans/10a/font
		NAMESPACE="$TMPDIR/9ns"
		BROWSER=surf
		EDITOR=E
		PAGER=nobs
		unset SSH_AGENT_PID
		GPG_TTY=$(tty)
		gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
		PASSWORD_STORE_DIR=$XDG_CACHE_HOME/password-store
		XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
		MANPATH=:$HOME/man
		if [ "$(tty)" = "/dev/tty1" ]
		then
			9start
			exec startx
		fi
		;;
	mail)
		MAIL=$HOME/Maildir
		PAGER=cat
		;;
esac
