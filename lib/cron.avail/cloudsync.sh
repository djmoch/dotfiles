#!/bin/sh
#
# ~/lib/cron.avail/cloudsync.sh
#

echo "Beginning cloud sync at `date`"

year=`/bin/date '+%Y'`
month=`/bin/date '+%m'`
lastrun_dir="$HOME/var/`basename $0`"
lastrun_file="$lastrun_dir/lastrun"
mobile_docs="$HOME/doc/mobile"
notes="$HOME/doc/notes"
server_fqdn="silicon.djmoch.org"
openrsync_flags="--rsync-path=/usr/bin/openrsync -a"
nfs_mntpt=/mnt/djmoch

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
if doas /sbin/mount $nfs_mntpt
then
    # Rsync from WebDAV to ~/Photos
    echo "Syncing Photos from NFS Share to $LOCAL_PHOTOS"
    [ ! -d $LOCAL_PHOTOS/$year/$month ] && mkdir -p $LOCAL_PHOTOS/$year/$month
    openrsync $openrsync_flags $nfs_mntpt/Photos/$year/$month/ $LOCAL_PHOTOS/$year/$month
    if [ -z "$firstrun" -a $lastrun_month -ne $month ]
    then
        # TODO: What if we're more than a month behind?
        if [ ! -d $LOCAL_PHOTOS/$lastrun_year/$lastrun_month ]
        then
            mkdir -p $LOCAL_PHOTOS/$lastrun_year/$lastrun_month
        fi
        openrsync $openrsync_flags $nfs_mntpt/Photos/$lastrun_year/$lastrun_month/ $LOCAL_PHOTOS/$lastrun_year/$lastrun_month
    fi

    # Rsync from ~/Photos to NFS Share
    echo "Syncing Photos from $LOCAL_PHOTOS to NFS Share"
    [ ! -d $nfs_mntpt/Photos/$year/$month ] && mkdir -p $nfs_mntpt/Photos/$year/$month
    openrsync $openrsync_flags $LOCAL_PHOTOS/$year/$month/ $nfs_mntpt/Photos/$year/$month
    if [ -z "$firstrun" -a $lastrun_month -ne $month ]
    then
        if [ ! -d $nfs_mntpt/Photos/$lastrun_year/$lastrun_month ]
        then
            mkdir -p $nfs_mntpt/Photos/$lastrun_year/$lastrun_month
        fi
        # TODO: What if we're more than a month behind?
        openrsync $openrsync_flags $LOCAL_PHOTOS/$lastrun_year/$lastrun_month/ $nfs_mntpt/Photos/$lastrun_year/$lastrun_month
    fi

    # Rsync from ~/Documents/Mobile to NFS Share
    echo "Syncing mobile documents from $mobile_docs to NFS Share"
    openrsync $openrsync_flags "$mobile_docs"/ $nfs_mntpt/Documents

    # Rsync from NFS Share to ~/Documents/Mobile
    echo "Syncing mobile documents from NFS Share to $mobile_docs"
    openrsync $openrsync_flags $nfs_mntpt/Documents/ "$mobile_docs"

    # Finish by unmounting the WebDAV folder
    echo "Unmounting $server_fqdn"
    doas /sbin/umount $nfs_mntpt
else
    echo "NFS Share mount FAILED. Exiting."
    exit -2
fi

echo "Completed cloud sync at `date`"
