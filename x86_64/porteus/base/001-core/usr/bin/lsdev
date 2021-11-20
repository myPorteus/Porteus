#!/usr/bin/perl
#
#	lsdev.pl
#
#	Created by Sander van Malssen <svm@ava.kozmix.cistron.nl>
#
#	Date:        1996-01-22 19:06:22
#	Last Change: 1998-05-31 15:26:58
#
# $Id: lsdev.pl,v 1.5 1999/05/15 22:16:03 svm Exp $
#

# MAIN #######################################################################

open (IRQ, "</proc/interrupts") || die "can't open /proc/interrupts";
while (<IRQ>) {
    next if /^[ \t]*[A-Z]/;
    chop;
    if (/PIC/) {
	$n = (@line = split());
    } else {
	$n = (@line = split(' [ +] '));
    }
    $name = $line[$n-1];
    $device{$name} = $name;
    @tmp = split(':', $line[0]);
    $tmp0 = int($tmp[0]);
    $irq{$name} = "$irq{$name} $tmp0";
}
close (IRQ);

open (DMA, "</proc/dma") || die "can't open /proc/dma";
while (<DMA>) {
    chop;
    @line = split(': ');
    @tmp = split (/[ \(]/, $line[1]);
    $name = $tmp[0];
    $device{$name} = $name;
    $dma{$name} = "$dma{$name}$line[0]";
}
close (DMA);

open (IOPORTS, "</proc/ioports") || die "can't open /proc/ioports";
while (<IOPORTS>) {
    chop;
    @line = split(' : ');
    @tmp = split (/[ \(]/, $line[1]);
    $name = $tmp[0];
    $device{$name} = $name;
    $port{$name} = "$port{$name} $line[0]";
}
close (IOPORTS);

printf ("%-16s %4s%6s %s\n------------------------------------------------\n",
	"Device", "DMA", "IRQ", " I/O Ports");

foreach $name (sort { uc($a) cmp uc($b) } keys %device) {
    printf ("%-16s %4s%6s %s\n",
	    $name, $dma{$name}, $irq{$name}, $port{$name});
}

# The End ####################################################################

# Local variables:
# rm-trailing-spaces: t
