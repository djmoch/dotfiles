#!/usr/bin/env bash
function __mkbrewdir()
{
    if [[ -d "/usr/local/$1" ]]
    then
        echo "Directory /usr/local/$1 already exists"
        return
    else
        echo "Creating directory /usr/local/$1"
        mkdir /usr/local/$1
    fi
    chown $LOGNAME:admin /usr/local/$1
}

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Reassigning directories to $LOGNAME. May need $USER password again."
sudo __mkbrewdir "Caskroom"
sudo __mkbrewdir "Cellar"
sudo __mkbrewdir "Frameworks"
sudo __mkbrewdir "Homebrew"
sudo __mkbrewdir "bin"
sudo __mkbrewdir "etc"
sudo __mkbrewdir "include"
sudo __mkbrewdir "lib"
sudo __mkbrewdir "opt"
sudo __mkbrewdir "sbin"
sudo __mkbrewdir "share"
sudo __mkbrewdir "var"
