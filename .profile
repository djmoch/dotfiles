#
# ~/.profile
#
if [ -r "$HOME/.shrc" ]
then
    . $HOME/.shrc
    export ENV=$HOME/.shrc
fi
