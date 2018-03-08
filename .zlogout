#
# ~/.zlogout
#
if [ $SHLVL -le 1 ]
then
    if [[ -n "$SSH_TTY" ]]
    then
        killall gpg-agent
    fi
    clear
fi
