#!/bin/sh

echo "Beginning photo sync at `date`"

# Only do the following if nextcloud.danielmoch.com is reachable
if ping -c 1 nextcloud.danielmoch.com > /dev/null 2>&1
then
    echo "nextcloud.danielmoch.com reachable. Proceeding."
else
    echo "nextcloud.danielmoch.com NOT reachable. Exiting."
    exit -1
fi

if type -p xdg-user-dir > /dev/null 2>&1
then
    LOCAL_FOLDER=`xdg-user-dir PICTURES`
else
    LOCAL_FOLDER="$HOME/Pictures"
fi

# Mount the WebDAV folder and set so only we can read it
if mount /mnt/nextcloud > /dev/null 2>&1
then
    echo "NextCloud WebDAV successfully mounted. Setting permissions."
    chmod 700 /mnt/nextcloud

    # Rsync from WebDAV to ~/Photos (unidirectionally for now, in order to
    # preserve server space)
    echo "Syncing Photos from WebDAV to $LOCAL_FOLDER"
    rsync -aq /mnt/nextcloud/Photos/* $LOCAL_FOLDER

    # Finish by unmounting the WebDAV folder
    echo "Unmounting nextcloud.danielmoch.com"
    umount /mnt/nextcloud > /dev/null 2>&1
else
    echo "NextCloud WebDAV mount FAILED. Exiting."
    exit -2
fi

echo "Completed photo sync at `date`"
