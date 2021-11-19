#!/bin/bash

# Script to set current logged in user as environment variable

DESKTOPS="cinnamon-session lxsession xfce4-session lxqt-session mate-session plasmashell"

for a in $DESKTOPS; do
	CUSER=`ps -C $a -o user=`
	if [ "$CUSER" ]; then
		export CURRENT_USER=$CUSER
		break 2
	fi
done
