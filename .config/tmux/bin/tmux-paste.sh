#!/usr/bin/env bash
uname=$(uname -s)

case $uname in
    *Darwin*)
        reattach-to-user-namespace pbpaste
        ;;
    *CYGWIN*)
        cat /dev/clipboard
        ;;
    *Linux*)
        xclip -o
        ;;
    *)
        return
esac
