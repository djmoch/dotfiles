#!/bin/sh
if ping -c 1 ipinfo.io > /dev/null 2>&1
then
    echo "ipinfo reachable. Proceeding."
else
    echo "ipinfo NOT reachable. Aborting."
    exit 1
fi

cd "$HOME/.local/lib/forecastio/"

./weather.py
