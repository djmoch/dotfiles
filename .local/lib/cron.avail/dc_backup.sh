#!/bin/sh
mount /mnt/timecapsule
rsync -aq danielmoch.com::backup /mnt/timecapsule/dotcom_backups
umount /mnt/timecapsule
