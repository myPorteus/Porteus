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

# Initialize udev to manage /dev entries and hotplugging:
if [ -z "`egrep -o " nohotplug( |\$)" /proc/cmdline`" -a -x /etc/rc.d/rc.udev ]; then
    mkdir /dev/pts; mount -o mode=0620,gid=5 -nt devpts devpts /dev/pts
    mount -o bind /mnt/live/run /run
    /sbin/udevd -d
    echo "Triggering udev events:  /sbin/udevadm trigger --action=add"
    /sbin/udevadm trigger --type=subsystems --action=add
    /sbin/udevadm trigger --type=devices --action=add
    /sbin/udevadm settle --timeout=120
fi

# Change default time zone if 'timezone=' cheatcode is present:
tz=`egrep -o " timezone=[^ ]+" /proc/cmdline | cut -d= -f2`
if [ "$tz" ]; then
    if [ -e /usr/share/zoneinfo/$tz ]; then
	ln -sf /usr/share/zoneinfo/$tz /etc/localtime-copied-from
	cp -L /etc/localtime-copied-from /etc/localtime
	# Change time standard to utc if 'utc' cheatcode is present:
	if egrep -qo " utc( |\$)" /proc/cmdline; then
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

# Set the system time from the hardware clock.
# Check for a broken motherboard RTC clock (where ioports for rtc are
# unknown) to prevent hwclock causing a hang:
grep -qw rtc /proc/ioports || CLOCK_OPT="--directisa"
if grep -qw "^UTC" /etc/hardwareclock; then
    hwclock $CLOCK_OPT --utc -s &
else
    hwclock $CLOCK_OPT --localtime -s &
fi

# Raid support:
if grep -qw 'TYPE=".*_raid_member"' /mnt/live/tmp/devices 2>/dev/null; then
    echo "Assembling RAID arrays"
    # Create fstab entries:
    blkid | grep /dev/md | grep -v 'TYPE="LVM' | sort >/mnt/live/tmp/raid
    echo -e "\n# RAID arrays:" >>/etc/fstab
    MOPT=`egrep -o " mopt=[^ ]+" /proc/cmdline | cut -d= -f2`; [ $MOPT ] || MOPT="noatime,nodiratime,suid,dev,exec,async"
    RAID=`grep -c / /mnt/live/tmp/raid`; x=1;
    while [ $x -le $RAID ]; do
        NAME=`sed -n "$x"p /mnt/live/tmp/raid | cut -d: -f1 | sed s@/dev/@@`
        FS=` sed -n "$x"p /mnt/live/tmp/raid | egrep -o ' TYPE=[^ ]+' | cut -d'"' -f2`
        echo "/dev/$NAME /mnt/$NAME $FS $MOPT  0 0" >>/etc/fstab
        mkdir /mnt/$NAME; [ -z "`egrep -qo " noauto( |\$)" /proc/cmdline`" ] && mount /mnt/$NAME; let x=x+1
    done
fi

# LVM support:
if egrep -q 'TYPE="LVM|TYPE=".*_raid_member"' /mnt/live/tmp/devices 2>/dev/null; then
    echo "Initializing LVM (Logical Volume Manager):"
    vgscan --mknodes --ignorelockingfailure
    if [ $? = 0 ]; then
        vgchange -ay --ignorelockingfailure
        # Create fstab entries:
        blkid | grep /dev/mapper | sort >/mnt/live/tmp/lvm
        echo -e "\n# LVM volumes:" >>/etc/fstab
        MOPT=`egrep -o " mopt=[^ ]+" /proc/cmdline | cut -d= -f2`; [ $MOPT ] || MOPT="noatime,nodiratime,suid,dev,exec,async"
        LVM=`grep -c / /mnt/live/tmp/lvm`; x=1
        while [ $x -le $LVM ]; do
            NAME=`sed -n "$x"p /mnt/live/tmp/lvm | cut -d: -f1 | sed -e 's@/dev/mapper/@@' -e 's@-@/@g'`
            # Fallback mode:
            test -h /dev/$NAME || NAME=`sed -n "$x"p /mnt/live/tmp/lvm | cut -d: -f1 | sed s@/dev/mapper/@@`
            FS=` sed -n "$x"p /mnt/live/tmp/lvm | egrep -o " TYPE=[^ ]+" | cut -d'"' -f2`
            echo "/dev/$NAME /mnt/$NAME $FS $MOPT 0 0" >>/etc/fstab
            mkdir -p /mnt/$NAME; [ -z "`egrep -qo " noauto( |\$)" /proc/cmdline`" ] && mount /mnt/$NAME; let x=x+1
        done
    fi
fi

# Run SystemV init scripts for this runlevel:
[ -x /etc/rc.d/rc.sysvinit ] && . /etc/rc.d/rc.sysvinit
