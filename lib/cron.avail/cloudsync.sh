#!/bin/sh
#
# ~/lib/cron.avail/cloudsync.sh
#

echo "Beginning cloud sync at `date`"

year=`date '+%Y'`
month=`date '+%m'`
lastrun_dir="$HOME/var/`basename $0`"
lastrun_file="$lastrun_dir/lastrun"
mobile_docs="$HOME/doc/mobile"
notes="$HOME/doc/notes"
server_fqdn="nextcloud.djmoch.org"
rsync_flags="-qu"

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

# Only do the following if the server is reachable
if ping -c 1 $server_fqdn > /dev/null 2>&1
then
    echo "$server_fqdn reachable. Proceeding."
else
    echo "$server_fqdn NOT reachable. Exiting."
    exit -1
fi

LOCAL_PHOTOS="$HOME/doc/pix"

# Mount the folder
if doas /sbin/mount /mnt/nextcloud
then
    # Rsync from WebDAV to ~/Photos
    echo "Syncing Photos from NextCloud to $LOCAL_PHOTOS"
    [ ! -d $LOCAL_PHOTOS/$year/$month ] && mkdir -p $LOCAL_PHOTOS/$year/$month
    rsync $rsync_flags /mnt/nextcloud/Photos/$year/$month/* $LOCAL_PHOTOS/$year/$month
    if [ -z "$firstrun" -a $lastrun_month -ne $month ]
    then
        # TODO: What if we're more than a month behind?
        if [ ! -d $LOCAL_PHOTOS/$lastrun_year/$lastrun_month ]
        then
            mkdir -p $LOCAL_PHOTOS/$lastrun_year/$lastrun_month
        fi
        rsync $rsync_flags /mnt/nextcloud/Photos/$lastrun_year/$lastrun_month/* $LOCAL_PHOTOS/$lastrun_year/$lastrun_month
    fi

    # Rsync from ~/Photos to NextCloud
    echo "Syncing Photos from $LOCAL_PHOTOS to NextCloud"
    [ ! -d /mnt/nextcloud/Photos/$year/$month ] && mkdir -p /mnt/nextcloud/Photos/$year/$month
    rsync $rsync_flags $LOCAL_PHOTOS/$year/$month/* /mnt/nextcloud/Photos/$year/$month
    if [ -z "$firstrun" -a $lastrun_month -ne $month ]
    then
        if [ ! -d /mnt/nextcloud/Photos/$lastrun_year/$lastrun_month ]
        then
            mkdir -p /mnt/nextcloud/Photos/$lastrun_year/$lastrun_month
        fi
        # TODO: What if we're more than a month behind?
        rsync $rsync_flags $LOCAL_PHOTOS/$lastrun_year/$lastrun_month/* /mnt/nextcloud/Photos/$lastrun_year/$lastrun_month
    fi

    # Rsync from ~/Documents/Mobile to NextCloud
    echo "Syncing mobile documents from $mobile_docs to NextCloud"
    rsync $rsync_flags "$mobile_docs"/* /mnt/nextcloud/Documents

    # Rsync from NextCloud to ~/Documents/Mobile
    echo "Syncing mobile documents from NextCloud to $mobile_docs"
    rsync $rsync_flags /mnt/nextcloud/Documents/* "$mobile_docs"

    # Finish by unmounting the WebDAV folder
    echo "Unmounting $server_fqdn"
    doas /sbin/umount /mnt/nextcloud
else
    echo "NextCloud mount FAILED. Exiting."
    exit -2
fi

echo "Completed cloud sync at `date`"
