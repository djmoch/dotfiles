#!/usr/bin/env bash
uname=$(uname -s)

case $uname in
    *Darwin*)
        reattach-to-user-namespace pbcopy
        ;;
    *CYGWIN*)
        cat > /dev/clipboard
        ;;
    *Linux*)
        xclip -selection clipboard
        ;;
    *)
        return
esac
