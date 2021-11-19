#! /bin/bash

# Check if we are root
    if [ "$UID" -ne 0 ]; then
      if [ "$DISPLAY" ]; then
        /opt/porteus-scripts/xorg/psu $0
      else
        echo "Enter root password"
        su -c $0
      fi
      exit
    fi

export MODULE_LOAD_DIR="/mnt/live/memory/images"
export TMPFILE="/tmp/${$}_port_modules"
export LOADEDENTRIES="grep -c gtk-yes $TMPFILE | tr -d '\n'"
export NUMENTRIES="wc -l $TMPFILE | cut -f 1 -d ' '"
export PORTROOTDIR=`grep -q copy2ram /proc/cmdline && echo "/mnt/live/memory/copy2ram" || grep -A1 "Porteus data found in" /var/log/porteus-livedbg | tail -n1`

    trap sigint_handler INT
    sigint_handler()
    {
        rm -f "$TMPFILE"
    }

# Functions modified from the linuxrc
    function value() { egrep -o " $1=[^ ]+" /proc/cmdline | cut -d= -f2; }

    function search()
    {
     local FOUND=""
     for x in `ls /mnt | tac`; do
      if [ -e /mnt/$x/$1 -a $(grep -c "/mnt/$x/$1" /var/log/porteus-livedbg) -ne 0 ]; then
       FOUND="$x"
       break
      fi
     done
     echo $FOUND
    }

export EXTRAMODS=`value extramod | sed 's/;/ /g'`

# Load modules activated after booting.
    function load_remaining_modules
    {
      local PORTMODULES="$(ls $MODULE_LOAD_DIR | sort)"
      for PORTMODULE in $PORTMODULES
      do
         local MODNAME="$(basename -a $PORTMODULE)"
         if ! grep -q "$MODNAME" "$TMPFILE"; then
           local MODDIR="$(losetup  -a | grep $MODNAME | cut -d \( -f2 | cut -d \) -f1)"
           MODDIR="$(dirname $MODDIR)"
          echo "gtk-yes|${MODNAME}|${MODDIR}" >> "$TMPFILE"
         fi
      done   
    }

# Loads modules from porteus base/modules/optional directories and extramod= directories
    function load_modules
    {
      local PORTMODULES="$(find $PORTROOTDIR -name "*.xzm" | sort)"
      for PORTMODULE in $PORTMODULES
      do
         local MODNAME="$(basename -a $PORTMODULE)"
         local MODDIR="$(dirname $PORTMODULE)"
         local OUT="${MODNAME}|${MODDIR}"
     
         if [ -e "${MODULE_LOAD_DIR}/${MODNAME}" ]; then
           echo "gtk-yes|${OUT}" >> "$TMPFILE"
         else
           echo "gtk-no|${OUT}" >> "$TMPFILE"
         fi
      done

# Copy2Ram copies even the extramods to copy2ram directory. No need to check it again
      if [ "$EXTRAMODS" -a "$PORTROOTDIR" != "/mnt/live/memory/copy2ram" ]; then
       for EXTRAMOD in $EXTRAMODS; do
        echo $EXTRAMOD | egrep -q '^UUID|^LABEL' && EXTRAMOD="$(echo $EXTRAMOD | cut -d \/ -f2-)"
        echo $EXTRAMOD | egrep -q '^/mnt/' && EXTRAMOD="$(echo $EXTRAMOD | cut -d \/ -f4-)"
       RET=$(search $EXTRAMOD)
       if [ $RET ]; then
         PORTMODULES="$(find /mnt/${RET}/${EXTRAMOD} -name "*.xzm" | sort)"
        else
         PORTMODULES="$(find ${EXTRAMOD} -name "*.xzm" | sort)"
        fi     
       for PORTMODULE in $PORTMODULES
       do
         local MODNAME="$(basename -a $PORTMODULE)"
         local MODDIR="$(dirname $PORTMODULE)"
         local OUT="${MODNAME}|${MODDIR}"
           
         if [ -e "${MODULE_LOAD_DIR}/${MODNAME}" ]; then
          echo "gtk-yes|${OUT}" >> "$TMPFILE"
         else
          echo "gtk-no|${OUT}" >> "$TMPFILE"
         fi
       done
       done
      fi
      load_remaining_modules
    }

# Activate or deactivate a modules
    function activate_module
    {
      if [ "$1" = "" ]; then return; fi

      local MODDIR="$(grep $1 $TMPFILE | cut -f 3 -d "|")"
      local MODULE="${MODDIR}/${1}"

      if [ -e "${MODULE_LOAD_DIR}/${1}" ]; then
       deactivate "$MODULE"
      else
       activate "$MODULE"
      fi
     refresh_modules
    }

# Refresh module list
    function refresh_modules
    {
      rm -f "$TMPFILE"
      load_modules
    }

    export -f load_modules
    export -f refresh_modules
    export -f load_remaining_modules
    export -f activate_module
    export -f value
    export -f search

    echo $PORTROOTDIR | egrep -q 'isoloop' && PORTROOTDIR="/mnt/live${PORTROOTDIR}" #isoloop workaround, to be removed in 3.2 final
    load_modules

    export MODULES_MAIN='
    <window window_position="1" title="Porteus Modules" default-height="550" default-width="500" icon-name="cdr" resizable="true" decorated="true">
    <vbox>
     <hbox>
      <text>
       <label>"Modules Activated: "</label>
      </text>
      <text>
       <variable>ENTRIES</variable>
       <input>'$LOADEDENTRIES'</input>
      </text>
     </hbox>
     <tree homogeneous="true" selection-mode="1" file-monitor="true">
      <variable>ENTRY</variable>
      <label>"Module Name                        |Containing Directory               "</label>
      <input file icon_column="0">'$TMPFILE'</input>
      <action signal="row-activated">"activate_module $ENTRY"</action>
      <action signal="file-changed" type="refresh">ENTRY</action>
      <action signal="file-changed" type="refresh">ENTRIES</action>
     </tree>
     <hseparator default-width="300"></hseparator>
     <hbox>
      <button space-fill="true">
       <label>Refresh</label>
       <input file stock="gtk-refresh"></input>
       <action>refresh_modules</action>
      </button> 
      <button space-fill="true">
       <label>Quit</label>
       <input file stock="gtk-quit"></input>
       <action>exit:0</action>
      </button> 
     </hbox>
    </vbox>
    </window>
    ' 

    gtkdialog --program=MODULES_MAIN -c
    rm -f $TMPFILE