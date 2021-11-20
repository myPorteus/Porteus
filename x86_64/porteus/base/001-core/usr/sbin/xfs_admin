#!/bin/sh -f
# SPDX-License-Identifier: GPL-2.0
#
# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
#

status=0
DB_OPTS=""
REPAIR_OPTS=""
REPAIR_DEV_OPTS=""
LOG_OPTS=""
USAGE="Usage: xfs_admin [-efjlpuV] [-c 0|1] [-L label] [-O v5_feature] [-r rtdev] [-U uuid] device [logdev]"

while getopts "c:efjlL:O:pr:uU:V" c
do
	case $c in
	c)	REPAIR_OPTS=$REPAIR_OPTS" -c lazycount="$OPTARG;;
	e)	DB_OPTS=$DB_OPTS" -c 'version extflg'";;
	f)	DB_OPTS=$DB_OPTS" -f";;
	j)	DB_OPTS=$DB_OPTS" -c 'version log2'";;
	l)	DB_OPTS=$DB_OPTS" -r -c label";;
	L)	DB_OPTS=$DB_OPTS" -c 'label "$OPTARG"'";;
	O)	REPAIR_OPTS=$REPAIR_OPTS" -c $OPTARG";;
	p)	DB_OPTS=$DB_OPTS" -c 'version projid32bit'";;
	r)	REPAIR_DEV_OPTS=" -r '$OPTARG'";;
	u)	DB_OPTS=$DB_OPTS" -r -c uuid";;
	U)	DB_OPTS=$DB_OPTS" -c 'uuid "$OPTARG"'";;
	V)	xfs_db -p xfs_admin -V
		status=$?
		exit $status
		;;
	\?)	echo $USAGE 1>&2
		exit 2
		;;
	esac
done
set -- extra $@
shift $OPTIND
case $# in
	1|2)
		# Pick up the log device, if present
		if [ -n "$2" ]; then
			LOG_OPTS=" -l '$2'"
		fi

		if [ -n "$DB_OPTS" ]
		then
			eval xfs_db -x -p xfs_admin $LOG_OPTS $DB_OPTS "$1"
			status=$?
		fi
		if [ -n "$REPAIR_OPTS" ]
		then
			echo "Running xfs_repair to upgrade filesystem."
			eval xfs_repair $LOG_OPTS $REPAIR_DEV_OPTS $REPAIR_OPTS "$1"
			status=`expr $? + $status`
		fi
		;;
	*)	echo $USAGE 1>&2
		exit 2
		;;
esac
exit $status
