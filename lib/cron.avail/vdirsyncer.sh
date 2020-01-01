#!/bin/sh
echo "Beginning sync on `date`"

server_fqdn="nextcloud.djmoch.org"

# Only do the following if the server is reachable
if ping -c 1 $server_fqdn > /dev/null 2>&1
then
    echo "$server_fqdn reachable. Proceeding."
else
    echo "$server_fqdn NOT reachable. Exiting."
    exit -1
fi

vdirsyncer -v INFO sync

echo "Completed sync on `date`"
