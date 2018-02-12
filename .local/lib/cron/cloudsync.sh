#!/bin/sh
#
# ~/.local/lib/cron/cloudsync.sh
#

echo "Beginning cloud sync at `date`"

year=`date '+%Y'`
month=`date '+%m'`
lastrun_dir="$HOME/.local/var/`basename $0`"
lastrun_file="$lastrun_dir/lastrun"
mobile_docs="$HOME/Documents/Mobile"

if [ -d "$lastrun_dir" ]
then
    if [ -f "$lastrun_file" ]
    then
        lastrun_year=`cat $lastrun_file | cut -d ' ' -f 1`
        lastrun_month=`cat $lastrun_file | cut -d ' ' -f 2`
    else
        firstrun=1
    fi
else
    firstrun=1
    mkdir -p "$lastrun_dir"
fi
echo "$year $month" > $lastrun_file

[ ! -d "$mobile_docs" ] && mkdir -p "$mobile_docs"

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
    LOCAL_PHOTOS=`xdg-user-dir PICTURES`
else
    LOCAL_PHOTOS="$HOME/Pictures"
fi

# Mount the WebDAV folder and set so only we can read it
if mount /mnt/nextcloud
then
    echo "NextCloud WebDAV successfully mounted. Setting permissions."
    chmod 700 /mnt/nextcloud

    # Rsync from WebDAV to ~/Photos
    echo "Syncing Photos from WebDAV to $LOCAL_PHOTOS"
    rsync -aq /mnt/nextcloud/Photos/$year/$month/* $LOCAL_PHOTOS
    if [ -z "$firstrun" -a $lastrun_month -ne $month ]
    then
        # TODO: What if we're more than a month behind?
        rsync -aq /mnt/nextcloud/Photos/$lastrun_year/$lastrun_month/* $LOCAL_PHOTOS
    fi

    # Rsync from ~/Photos to WebDAV 
    echo "Syncing Photos from $LOCAL_PHOTOS to WebDAV"
    rsync -aq $LOCAL_PHOTOS/$year/$month/* /mnt/nextcloud/Photos
    if [ -z "$firstrun" -a $lastrun_month -ne $month ]
    then
        # TODO: What if we're more than a month behind?
        rsync -aq $LOCAL_PHOTOS/$lastrun_year/$lastrun_month/* /mnt/nextcloud/Photos
    fi

    # Rsync from WebDAV to ~/Documents/Mobile
    echo "Syncing mobile documents from WebDAV to $mobile_docs"
    rsync -aq /mnt/nextcloud/Documents/* "$mobile_docs"

    # Rsync from ~/Documents/Mobile to WebDAV
    echo "Syncing mobile documents from $mobile_docs to WebDAV"
    rsync -aq "$mobile_docs"/* /mnt/nextcloud/Documents

    # Finish by unmounting the WebDAV folder
    echo "Unmounting nextcloud.danielmoch.com"
    umount /mnt/nextcloud
else
    echo "NextCloud WebDAV mount FAILED. Exiting."
    exit -2
fi

echo "Completed cloud sync at `date`"
