#!/bin/sh
#GUI text editor caller (for ISO Master)
#by Marcin Zajaczkowski <mszpak ATT wp DOTT pl>
#version 0.1
#Script can be freely used for any purpose

#some other popular text editors with GUI?
for TEXT_EDITOR in gedit kate kedit mousepad gvim xemacs
do
	echo -n $TEXT_EDITOR
	COMMAND=`which $TEXT_EDITOR 2>/dev/null`
	RESULT=$?
	echo ,$RESULT
	if [ $RESULT -eq 0 ]
	then
		echo -n calling $COMMAND
		if [ -z "$1" ]
		then
			echo
	        $COMMAND
		else
			echo " ""$1" 
			$COMMAND "$1"
		fi
		exit
	fi
done

