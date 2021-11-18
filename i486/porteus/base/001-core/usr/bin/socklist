#!/usr/bin/perl

# socklist
# Simple and effective substitute for "lsof" for Linux with a proc filesystem.
# Standard permissions on the proc filesystem make this program only
# useful when run as root.

# Larry Doolittle <ldoolitt@jlab.org>
# September 1997

# example output (with # added given the context of a perl program):
#
# type  port      inode     uid    pid   fd  name
# tcp   1023     394218     425  23333    3  ssh
# tcp   1022     394166     425  23312    3  ssh
# tcp   6000     387833     313   3942    0  X
# tcp   2049      81359       0  13296    4  rpc.nfsd
# tcp    745      81322       0  13287    4  rpc.mountd
# tcp    111      81282       0  13276    4  portmap
# tcp     22      26710       0   7372    3  sshd
# tcp     25      25902       0    156   18  inetd
# tcp     80      20151       0   2827    4  boa-0.92
# tcp     23       2003       0    156    5  inetd
# udp    620     855681       0      0    0  
# udp    655     394445       0      0    0  
# udp   2049      81356       0  13296    3  rpc.nfsd
# udp    743      81319       0  13287    3  rpc.mountd
# udp    111      81281       0  13276    3  portmap
# udp    707       2776       0      0    0  
# udp    514       1861       0    124    1  syslogd
# raw      1          0       0      0    0  
#
# It appears that each NFS mount generates an open udp port, which
# is not associated with any process.  This is the origin of those
# mysterious ports 620, 655, and 707 above.  I still don't understand
# the meaning of raw port 1.

# part 1: scan through the /proc filesystem building up
# a list of what processes own what network "inodes".
# result is associative array %sock_proc.

opendir (PROC, "/proc") || die "proc";
for $f (readdir(PROC)) {
    next if (! ($f=~/[0-9]+/) );
    if (! opendir (PORTS, "/proc/$f/fd")) {
        # print "failed opendir on process $f fds\n";
        closedir PORTS;
        next;
    }
    for $g (readdir(PORTS)) {
        next if (! ($g=~/[0-9]+/) );
        $r=readlink("/proc/$f/fd/$g");

# 2.0.33: [dev]:ino 
#	($dev,$ino)=($r=~/^\[([0-9a-fA-F]*)\]:([0-9]*)$/);
# 2.0.78: socket:[ino]
#	($dev,$ino)=($r=~/^(socket):\[([0-9]*)\]$/);
# -svm-
	($dev,$ino)=($r=~/^(socket|\[[0-9a-fA-F]*\]):\[?([0-9]*)\]?$/);

        # print "$f $g $r DEV=$dev INO=$ino\n";
        if ($dev == "[0000]" || $dev == "socket") {$sock_proc{$ino}=$f.":".$g;}
    }
    closedir PORTS;
}
closedir PROC;

# exit;

# for $a (keys(%sock_proc)) {print "$a $sock_proc{$a}\n";}

# part 2: read /proc/net/tcp, /proc/net/udp, and /proc/net/raw,
# printing the answers as we go.

print "type  port      inode     uid    pid   fd  name\n";
sub scheck {
    open(FILE,"/proc/net/".$_[0]) || die;
    while (<FILE>) {
        @F=split();
        next if ($F[9]=~/uid/);
        @A=split(":",$F[1]);
        $a=hex($A[1]);
        ($pid,$fd)=($sock_proc{$F[9]}=~m.([0-9]*):([0-9]*).);
        $cmd = "";
        if ($pid && open (CMD,"/proc/$pid/status")) {
           $l = <CMD>;
           ($cmd) = ( $l=~/Name:\s*(\S+)/ );
           close(CMD);
	}
        printf "%s %6d %10d  %6d %6d %4d  %s\n",
            $_[0], $a ,$F[9], $F[7], $pid, $fd, $cmd;
    }
    close(FILE);
}

scheck("tcp");
scheck("udp");
scheck("raw");
