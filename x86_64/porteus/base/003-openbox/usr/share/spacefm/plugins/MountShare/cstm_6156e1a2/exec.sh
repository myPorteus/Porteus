#!/bin/bash

$fm_import
CONFIG="$fm_cmd_data"


PASSFILE="${CONFIG}/pass"
USERFILE="${CONFIG}/user"
POPULATE="${fm_cmd_dir}/populatedrop"

SERVERS="${CONFIG}/servers"
IPADDRESS="${CONFIG}/ip"
DROPDISK="${CONFIG}/disks"
SELECTEDDISK="${CONFIG}/selecteddisk"
CURRENTSERVER="${CONFIG}/currentserver"

mkdir -p "$CONFIG" &>/dev/null

export IPADDRESS
export SERVERS
export DROPDISK
export SELECTEDDISK
export CURRENTSERVER

if [ ! -e $IPADDRESS ];then
	echo "127.0.0.0" > $IPADDRESS
fi

if [ ! -e $PASSFILE ];then
	: > $PASSFILE
fi

if [ ! -e $USERFILE ];then
	whoami>"$USERFILE"
fi

if [ ! -e $SERVERS ];then
	echo " " > $SERVERS
fi

if [ ! -e $DROPDISK ];then
	echo " " > $DROPDISK
fi

if [ ! -e $SELECTEDDISK ];then
	echo " " > $SELECTEDDISK
fi

if [ ! -e $CURRENTSERVER ];then
	echo " " > $CURRENTSERVER
fi

eval "$(spacefm -g --radio "FTP" "0" disable drop1 %v -- disable drop2 %v -- disable freebutton1 %v --radio "SMB" "1" enable drop1 %v -- enable drop2 %v -- enable freebutton1 --label "IP Address" --hbox --free-button "Scan" -- $POPULATE 'server' --drop "@$SERVERS" "@$CURRENTSERVER" -- $POPULATE 'lookup' %v  --input  @$IPADDRESS -- $POPULATE 'disks' %v --close-box --label "Mount Point" --drop @$DROPDISK "@$SELECTEDDISK" --label "User Name" --input "@$USERFILE" --label "Password" --password @$PASSFILE --button Mount:gtk-apply --button Cancel:gtk-cancel)"

IP="$dialog_input1"
MP="$dialog_drop2"
USER="$dialog_input2"
PW="$dialog_password1"

if [ X"$dialog_radio1" = "X1" ];then
	TYPE="FTP"
else
	TYPE="SMB"
fi

if [ "X$USER" != "X" ];then
	OPTIONS="-o username=$USER,password=$PW,uid=$UID"
	FTPOPTIONS="${USER}:${PW}"
else
	OPTIONS=""
	FTPOPTIONS=""
fi

if [ "X$dialog_pressed" = "Xbutton1" ] && [ $TYPE = "SMB" ];then
	udevil mount -t cifs  $OPTIONS //$IP/$MP
fi

if [ "X$dialog_pressed" = "Xbutton1" ] && [ $TYPE = "FTP" ];then
	udevil mount -t curlftpfs ftp://$FTPOPTIONS@$IP
fi

echo -n "$PW" > "$PASSFILE"
echo -n "$USER" > "$USERFILE"
echo -n "$IP" > "$IPADDRESS"
echo -n "$MP" > "$SELECTEDDISK"

exit $?

