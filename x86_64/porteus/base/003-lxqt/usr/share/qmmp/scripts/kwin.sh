#!/bin/sh

#This script adds kwin rules for qmmp windows

if ! type kreadconfig5 &> /dev/null; then
  exit 1
fi

if ! type kwriteconfig5 &> /dev/null; then
  exit 1
fi

# get count of rules
count=`kreadconfig5 --file kwinrulesrc --group General --key count`
i=1
found=0;

while [ $i -le $count ];
do
	# find qmmp window rule in KWin
    match=`kreadconfig5 --file kwinrulesrc --group $i --key wmclass`
    if [[ "${match,,}" = *"qmmp"* ]]; then
        found=$i
        break
    fi
    i=$((i+1))
done


qmmp_create_rule(){
	id=$1

	kwriteconfig5 --file kwinrulesrc --group General --key count $id
	kwriteconfig5 --file kwinrulesrc --group $id --key Description qmmp
}


qmmp_update_rule(){
	id=$1

    kwriteconfig5 --file kwinrulesrc --group $id --key skipswitcher true
    kwriteconfig5 --file kwinrulesrc --group $id --key skipswitcherrule 2
    kwriteconfig5 --file kwinrulesrc --group $id --key type 5
    kwriteconfig5 --file kwinrulesrc --group $id --key typerule 2
    kwriteconfig5 --file kwinrulesrc --group $id --key types 256
    kwriteconfig5 --file kwinrulesrc --group $id --key wmclass qmmp
    kwriteconfig5 --file kwinrulesrc --group $id --key wmclasscomplete false
    kwriteconfig5 --file kwinrulesrc --group $id --key wmclassmatch 1
}

reload_kwin_rules(){
	dbus-send --print-reply --dest=org.kde.KWin /KWin org.kde.KWin.reconfigure
}


if [ $found = "0" ]; then
	# rule not found (create new KWin window rule)
	id=$((count+1))

	qmmp_create_rule $id
	qmmp_update_rule $id
	reload_kwin_rules
fi