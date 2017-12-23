#!/bin/sh
# newsbeuter bookmarking plugin for pinboard
# (c) 2007 Andreas Krennmair
# documentation: https://pinboard.in/api

username="djmoch"
password="$(secret-tool lookup account djmoch service in.pinboard)"

# You can enter up to 100 tags here, space delimited, or leave blank for no tag
tags="via:newsbeuter"

# Leave as 'yes' to bookmark as to be read, enter 'no' to mark as read
toread="yes"

url="$1"
title="$2"
desc="$3"

pinboard_url="https://api.pinboard.in/v1/posts/add?url=${url}&description=${title}&extended=${desc}&tags="${tags}"&toread=${toread}"

output=`wget --http-user=$username --http-passwd=$password -O - "$pinboard_url" 2> /dev/null`
output=`echo $output | sed 's/^.*code="\([^"]*\)".*$/\1/'`

if [ "$output" != "done" ] ; then
  echo "$output"
fi
