#!/bin/bash
#
# /etc/rc.d/rc.S:  System initialization script.
#
# Written for Porteus by fanthom (also other rc scripts).

PATH=/sbin:/usr/sbin:/bin:/usr/bin

# Mounting proc, sys and devtmpfs:
mount -nt proc proc /proc
mount -nt sysfs sysfs /sys
mount -nt devtmpfs devtmpfs /dev

# Ensure sane guest perms
for a in `find /home -maxdepth 1 -type d | sed '1d'`; do
	b=${a##*/}
	if [[ `grep "$b" /etc/passwd` ]]; then
		chown -R $b: /home/$b
	fi
done
#chown -R guest: /home/guest

# Start the system logger:
[ -x /etc/rc.d/rc.syslog ] && sh /etc/rc.d/rc.syslog start >/dev/null &

# Start D-Bus:
[ -x /etc/rc.d/rc.messagebus ] && sh /etc/rc.d/rc.messagebus start >/dev/null &

# Update various cache's if additional xzm modules were added to the union:
egrep -qv 'changes$|/00.*.xzm' /mnt/live/tmp/modules && sh /opt/porteus-scripts/xorg/update-cache rc.S 2>/dev/null &

# Only rebuild dependencies if new kernel modules are found:
depmod -A 2>/dev/null

# Load any kernel modules that are needed:
if [ -x /etc/rc.d/rc.modules ]; then
    echo "Running /etc/rc.d/rc.modules:"
    . /etc/rc.d/rc.modules
fi

# Make sure /dev/shm exists and is mounted tmpfs
if [[ ! `grep /dev/shm /proc/mounts` ]]; then
	[ ! -d /dev/shm ] && mkdir /dev/shm
	mount -t tmpfs tmpfs /dev/shm
fi

# Initialize udev to manage /dev entries and hotplugging:
if [ -z "`egrep -o "^nohotplug( |\$)" /etc/bootcmd.cfg`" -a -x /etc/rc.d/rc.udev ]; then
    mkdir /dev/pts; mount -o mode=0620,gid=5 -nt devpts devpts /dev/pts
    mount -o bind /mnt/live/run /run
    /sbin/udevd -d
    echo "Triggering udev events:  /sbin/udevadm trigger --action=add"
    /sbin/udevadm trigger --type=subsystems --action=add
    /sbin/udevadm trigger --type=devices --action=add
    /sbin/udevadm settle --timeout=3
fi

# Change default time zone if 'timezone=' cheatcode is present:
. /etc/profile.d/porteus.sh

if [ `grep -qo timezone $PORTCFG` ]; then
	tz=`egrep -o "^timezone=[^ ]+" $PORTCFG | cut -d= -f2`
else
	tz=`egrep -o "^timezone=[^ ]+" /etc/bootcmd.cfg | cut -d= -f2`
fi

if [ "$tz" ]; then
    if [ -e /usr/share/zoneinfo/$tz ]; then
	ln -sf /usr/share/zoneinfo/$tz /etc/localtime-copied-from
	ln -sf /usr/share/zoneinfo/$tz /etc/localtime
	# Change time standard to utc if 'utc' cheatcode is present:
	if egrep -qo "^utc( |\$)" /etc/bootcmd.cfg; then
	    sed -i s/^localtime/UTC/g /etc/hardwareclock
	else
	    sed -i s/^UTC/localtime/g /etc/hardwareclock
	fi
	# Sync the clock once we have internet connection:
	(
	sleep 10
	ntpdate pool.ntp.org >/dev/null 2>&1
	# Store systemtime to hardware clock:
	grep -wq rtc /proc/ioports || CLOCK_OPT="--directisa"
	grep -wq "^UTC" /etc/hardwareclock && CLOCK_OPT="$CLOCK_OPT --utc" || CLOCK_OPT="$CLOCK_OPT --localtime"
	hwclock $CLOCK_OPT -w
	) &
    fi
fi

# Set the system time from the hardware clock using hwclock --hctosys.
if [ -x /sbin/hwclock ]; then
  # Check for a broken motherboard RTC clock (where ioports for rtc are
  # unknown) to prevent hwclock causing a hang:
  if ! grep -q " : rtc" /proc/ioports ; then
    CLOCK_OPT="--directisa"
  fi
  if [ /etc/adjtime -nt /etc/hardwareclock ]; then
    if grep -q "^LOCAL" /etc/adjtime ; then
      echo -n "Setting system time from the hardware clock (localtime):  "
    else
      echo -n "Setting system time from the hardware clock (UTC):  "
    fi
    /sbin/hwclock $CLOCK_OPT --hctosys
  elif grep -wq "^localtime" /etc/hardwareclock 2> /dev/null ; then
    echo -n "Setting system time from the hardware clock (localtime):  "
    /sbin/hwclock $CLOCK_OPT --localtime --hctosys
  else
    echo -n "Setting system time from the hardware clock (UTC):  "
    /sbin/hwclock $CLOCK_OPT --utc --hctosys
  fi
  date
fi

# Create a RAID Array:
if [ "$FS" = linux_raid_member ]; then
    echo "DEVICE partitions" > /etc/mdadm.conf; mdadm --misc --scan --detail --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm.conf
fi

# Run SystemV init scripts for this runlevel:
[ -x /etc/rc.d/rc.sysvinit ] && . /etc/rc.d/rc.sysvinit
