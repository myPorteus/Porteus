#!/usr/bin/perl

######################################################################
#
# This script uses wpg2svg to convert batches of WPG files to 
# SVG. For more info type: wpg2svgbatch.pl -h
#
# Copyright 2007 Ariya Hidayat (ariya@kde.org)
# Modification from wpd2sxwbatch.pl
# Copyright 2003 Michael Clark <miark@gardnerbusiness.com>
# Written with the support of Brent Hasty.
#
# This program is free software, redistributable and/or modifiable
# under the terms of the GNU General Public License as published 
# by the Free Software Foundation. You can read the GPL at
# http://www.gnu.org/copyleft/gpl.html
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
######################################################################

use Getopt::Std;

######################################################################
#
## Variables

getopts('thvurd:o:');
$ext_in  = "wpg";
$ext_in  = "wpg" if $opt_t == 1;


######################################################################
#
## Display help page 

if ($opt_h == 1) {
  print << "  EOF";

  Usage: wpg2svgbatch.pl [-hruv] [-d dir] [-o dir]

  wpg2svgbatch.pl uses wpg2svg to convert batches of WordPerfect
  word processor files (WPG) to the Scalable Vector Graphics
  (SVG) format. The SVG files are generated anew and do not replace 
  the original wpg files.

  Running wpg2svgbatch.pl more than once on the same directory will 
  cause the existing SVG file to be replaced with a new one.

  -d <dir>
      begins the conversion process in directory \"dir\"
      instead of the current directory. Use this switch
      separately from the other switches, (-vr -d /home/robin)
      or at the end of a switch string (-rvd /home/robin).

  -h  displays this help text.

  -o <dir>
      causes all the generated SVG files to be deposited in
      this single specified output directory. When not used, the 
      generated SVG files are deposited in the same directory
      in which the original WPG file was found. Use this switch
      separately from the other switches, (-vr -o /home/robin)

  -r  converts files in either the current directory or the
      directory specified by the -d switch (see below) and
      all the wpg files in all the subdirectories.

  -u  replaces spaces with underscores in the target filename(s).

  -v  Displays statistics and the progress of the conversion.

  EOF

  exit;
}


######################################################################
#
## Let user know if they specified a bad directory

if ($opt_d && !-e $opt_d) {
  print STDERR "\nWarning! Input directory $opt_d does not exist!\n\n";
  exit;
}

if ($opt_d && !-d $opt_d) {
  print STDERR "\nWarning! Input directory $opt_d is not a directory!\n\n";
  exit;
}

if ($opt_d && !-w $opt_d) {
  print STDERR "\nWarning! Input directory $opt_d is not a writable!\n\n";
  exit;
}

if ($opt_o && !-e $opt_o) {
  print STDERR "\nWarning! Output directory $opt_o does not exist!\n\n";
  exit;
}

if ($opt_o && !-d $opt_o) {
  print STDERR "\nWarning! Output directory $opt_o is not a directory!\n\n";
  exit;
}

if ($opt_o && !-w $opt_o) {
  print STDERR "\nWarning! Output directory $opt_o is not a writable!\n\n";
  exit;
}


######################################################################
#
## The quick and dirty version when no switches are used

if ($opt_v != 1 && $opt_d eq "" && opt_r == 1 && $opt_o eq "") {
  my @files = `find ./ -type f -iname \"*.$ext_in\"`;

  foreach (@files) {
    chomp $_;
    my $in  = $_;
    my $out = $_;
    $out =~ s/\.$ext_in$/.svg/i;
    $out =~ s/\s+/_/g;
    system("wpg2svg '$in' > '$out'") if $opt_t != 1; 
    print "\nwpg2svg '$in' > '$out'" if $opt_t == 1;
  }

  exit;
}


######################################################################
#
## Determine the working directory(s)

if ($opt_v == 1) {
  system('clear');
  print "== Converting WPG Files ==================================\n\n";
}

if ($opt_d) {
  @dirs = ("$opt_d");
  print "* Working in directory \"$opt_d\".\n" if $opt_v == 1;
}

else {
  @dirs = ("./");
  print "* Working in current directory ($dirs[0]).\n" if $opt_v == 1;
}

if ($opt_r == 1) {
  @dirs = `find $dirs[0] -type d`;

  foreach (@dirs) { 
    chomp $_; 
    $dir_count++;
  }

  $dir_count = $dir_count - 1;
  print "* Working in $dir_count subdirectories.\n" if $dir_count > 0 && $opt_v == 1;
  @dirs = ("./") if $dir_count < 1;
}


######################################################################
#
## Count existing WPG files

if ($opt_v == 1) {
  @wpg_files = `find $dirs[0] -type f -iname \"*.$ext_in\"`;
  $wpg_count = @wpg_files;
  print "* Working on $wpg_count WPG files.\n\n";
}


######################################################################
#
## Perform the conversion

foreach $dir (@dirs) {
  print "- Working in $dir... " if $opt_v == 1;
  my($found, $found_ct);

  opendir DIR, "$dir";
  @files = readdir DIR;
  close DIR;

  foreach $file (@files) {
    $path = $dir . "/" . $file;
    $path =~ s/\/\//\//;

    if ($file =~ m/\.$ext_in$/i) {
      $found = 1;
      $found_ct++;

      $in  = $dir . "/" . $file;
      $in =~ s/\/+/\//g;

      $file =~ s/\s/_/g if $opt_u == 1;
      $out = $dir . "/" . $file;
      $out = $opt_o . "/" . $file if $opt_o;
      $out =~ s/\/+/\//g;
      $out =~ s/\.$ext_in$/.svg/i;

      system("wpg2svg '$in' > '$out'") if $opt_t != 1;
      print "\nwpg2svg '$in' > '$out'" if $opt_t == 1;
    }
  }
  print "no WPG files.\n" 		 if $found != 1 && $opt_v == 1;
  print "converted $found_ct file(s).\n" if $found == 1 && $opt_v == 1;
  $total = $total + $found_ct;
}

print "\n* Successfully converted $total files.\n\n" if $opt_v == 1;

