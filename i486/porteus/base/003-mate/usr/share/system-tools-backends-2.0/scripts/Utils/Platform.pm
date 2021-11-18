#!/usr/bin/perl
#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# Determine the platform we're running on.
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Arturo Espinosa <arturo@ximian.com>
#          Hans Petter Jansson <hpj@ximian.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.

package Utils::Platform;

use Utils::Parse;
use Utils::Backend;
use Utils::File;
use Utils::Replace;

# --- System guessing --- #

my $PLATFORM_INFO = {
  "debian"          => [ "Debian GNU/Linux" ],
  "redhat-5.2"      => [ "Red Hat Linux", "5.2", "Apollo" ],
  "redhat-6.0"      => [ "Red Hat Linux", "6.0", "Hedwig" ],
  "redhat-6.1"      => [ "Red Hat Linux", "6.1", "Cartman" ],
  "redhat-6.2"      => [ "Red Hat Linux", "6.2", "Zoot" ],
  "redhat-7.0"      => [ "Red Hat Linux", "7.0", "Guinness" ],
  "redhat-7.1"      => [ "Red Hat Linux", "7.1", "Seawolf" ],
  "redhat-7.2"      => [ "Red Hat Linux", "7.2", "Enigma" ],
  "redhat-7.3"      => [ "Red Hat Linux", "7.3", "Valhalla" ],
  "redhat-8.0"      => [ "Red Hat Linux", "8.0", "Psyche" ],
  "redhat-9"        => [ "Red Hat Linux", "9.0", "Shrike" ],
  "openna-1.0"      => [ "OpenNA Linux", "1.0", "VSLC" ],
  "mandrake-7.1"    => [ "Linux Mandrake", "7.1" ],
  "mandrake-7.2"    => [ "Linux Mandrake", "7.2", "Odyssey" ],
  "mandrake-8.0"    => [ "Linux Mandrake", "8.0", "Traktopel" ],
  "mandrake-9.0"    => [ "Linux Mandrake", "9.0", "Dolphin" ],
  "mandrake-9.1"    => [ "Linux Mandrake", "9.1", "Bamboo" ],
  "mandrake-9.2"    => [ "Linux Mandrake", "9.2", "FiveStar" ],
  "mandrake-10.0"   => [ "Linux Mandrake", "10.0" ],
  "mandrake-10.1"   => [ "Linux Mandrake", "10.1" ],
  "mandrake-10.2"   => [ "Linux Mandrake", "2005" ],
  "mandriva-2006.0" => [ "Mandriva Linux", "2006.0" ],
  "mandriva-2006.1" => [ "Mandriva Linux", "2006.1" ],
  "yoper-2.2"       => [ "Yoper Linux", "2.2" ],
  "blackpanther-4.0" => [ "Black Panther OS", "4.0", "" ],
  "conectiva-9"     => [ "Conectiva Linux", "9", "" ],
  "conectiva-10"    => [ "Conectiva Linux", "10", "" ],
  "suse-9.0"        => [ "SuSE Linux", "9.0", "" ],
  "suse-9.1"        => [ "SuSE Linux", "9.1", "" ],
  "slackware-9.1"   => [ "Slackware", "9.1", "" ],
  "slackware-10.0"  => [ "Slackware", "10.0", "" ],
  "slackware-10.1"  => [ "Slackware", "10.1", "" ],
  "slackware-10.2"  => [ "Slackware", "10.2", "" ],
  "slackware-11.0"  => [ "Slackware", "11.0", "" ],
  "slackware-12.0"  => [ "Slackware", "12.0", "" ],
  "slackware-14.0"  => [ "Slackware", "14.0", "" ],
  "slackware-14.1"  => [ "Slackware", "14.1", "" ],
  "bluewhite64-12.0.0" => [ "Bluewhite64", "12.0.0", "" ],
  "freebsd-4"       => [ "FreeBSD", "4", "" ],
  "freebsd-5"       => [ "FreeBSD", "5", "" ],
  "freebsd-6"       => [ "FreeBSD", "6", "" ],
  "freebsd-7"       => [ "FreeBSD", "7", "" ],
  "freebsd-8"       => [ "FreeBSD", "8", "" ],
  "gentoo"          => [ "Gentoo Linux", "", "" ],
  "vlos-1.2"        => [ "Vida Linux OS", "1.2" ],
  "archlinux"       => [ "Arch Linux", "", "" ],
  "pld-1.0"         => [ "PLD", "1.0", "Ra" ],
  "pld-1.1"         => [ "PLD", "1.1", "Ra" ],
  "pld-1.99"        => [ "PLD", "1.99", "Ac-pre" ],
  "pld-2.99"        => [ "PLD", "1.99", "Th-pre" ],
  "vine-3.0"        => [ "Vine Linux", "3.0", "" ],
  "vine-3.1"        => [ "Vine Linux", "3.1", "" ],
  "fedora-1"        => [ "Fedora Core", "1", "Yarrow" ],
  "fedora-2"        => [ "Fedora Core", "2", "Tettnang" ],
  "fedora-3"        => [ "Fedora Core", "3", "Heidelberg" ],
  "fedora-4"        => [ "Fedora Core", "4", "Stentz" ],
  "rpath"           => [ "rPath Linux" ],
  "ark"             => [ "Ark Linux" ],
  "solaris-2.11"    => [ "Solaris / OpenSolaris", "2.11", "Nevada" ],
  "nexenta-1.0"     => [ "Nexenta GNU/Solaris", "1.0", "Ellate" ],
  "yellowdog-4.1"   => [ "Yellow Dog Linux", "4.1", "Sagitta" ],
  "guadalinex-v4"   => [ "Guadalinex", "v4", "Toro" ],
};

sub get_platform_info
{
  return $PLATFORM_INFO;
}

sub ensure_distro_map
{
  my ($distro) = @_;

  # This is a distro metamap, if one distro
  # behaves *exactly* like another, just specify it here
  my %metamap =
    (
     "blackpanther-4.0" => "mandrake-9.0",
     "conectiva-10"     => "conectiva-9",
     "mandrake-7.1"     => "redhat-6.2",
     "mandrake-7.2"     => "redhat-6.2",
     "mandrake-9.1"     => "mandrake-9.0",
     "mandrake-9.2"     => "mandrake-9.0",
     "mandrake-10.0"    => "mandrake-9.0",
     "mandrake-10.1"    => "mandrake-9.0",
     "mandrake-10.2"    => "mandrake-9.0",
     "mandriva-2006.0"  => "mandrake-9.0",
     "mandriva-2006.1"  => "mandrake-9.0",
     "fedora-1"         => "redhat-7.2",
     "fedora-2"         => "redhat-7.2",
     "fedora-3"         => "redhat-7.2",
     "fedora-4"         => "redhat-7.2",
     "fedora-5"         => "redhat-7.2",
     "freebsd-6"        => "freebsd-5",
     "freebsd-7"        => "freebsd-5",
     "freebsd-8"        => "freebsd-5",
     "openna-1.0"       => "redhat-6.2",
     "pld-1.1"          => "pld-1.0",
     "pld-1.99"         => "pld-1.0",
     "pld-2.99"         => "pld-1.0",
     "redhat-9"         => "redhat-8.0",
     "rpath"            => "redhat-7.2",
     "yellowdog-4.1"    => "redhat-7.2",
     "slackware-10.0"  => "slackware-9.1",
     "slackware-10.1"  => "slackware-9.1",
     "slackware-10.2"  => "slackware-9.1",
     "slackware-11.0"  => "slackware-9.1",
     "slackware-12.0"  => "slackware-9.1",
     "slackware-14.0"  => "slackware-14.0",
     "slackware-14.1"  => "slackware-14.1",
     "bluewhite64-12.0.0" => "slackware-9.1.0",
     "suse-9.1"         => "suse-9.0",
     "vine-3.1"         => "vine-3.0",
     "vlos-1.2"         => "gentoo",
     "nexenta-1.0"      => "solaris-2.11",
     );

  return $metamap{$distro} if ($metamap{$distro});
  return $distro;
}
  
sub check_lsb
{
  my ($ver, $dist, %distmap);

  %distmap = {
    "gnu_solaris" => "nexenta"
  };

  $dist = lc (&Utils::Parse::get_sh ("/etc/lsb-release", "DISTRIB_ID"));
  $ver = lc (&Utils::Parse::get_sh ("/etc/lsb-release", "DISTRIB_RELEASE"));

  $dist = $$distmap{$dist} if exists $$distmap{$dist};

  return -1 if ($dist eq "") || ($ver eq "");
  return "$dist-$ver";
}

sub check_yoper
{
   open YOPER, "$gst_prefix/etc/yoper-release" or return -1;
   while (<YOPER>)
   {
     $ver = $_;
     chomp ($ver);
     if ($ver =~ m/Yoper (\S+)/)
     {
       close YOPER;
       # find the first digit of our release
       $mystring= ~m/(\d)/;
       #store it in $fdigit
       $fdigit= $1;
       # the end of the release is marked with -2 so find the -
       $end = index($ver,"-");
       $start = index($ver,$fdigit);
       # extract the substring into $newver
       $newver= substr($ver,$start,$end-$start);
       print $newver;
       return "yoper-$newver";
     }
   }
   close YOPER;
   return -1;
}

sub check_rpath
{
  open RPATH, "$gst_prefix/etc/distro-release" or return -1;

  while (<RPATH>)
  {
    $ver = $_;
    chomp ($ver);

    if ($ver =~ /^rPath Linux/)
    {
      close RPATH;
      return "rpath";
    }
    elsif ($ver =~ /Foresight/)
    {
      close RPATH;
      return "rpath";
    }
  }

  close RPATH;
  return -1;
}

sub check_ark
{
  open ARK, "$gst_prefix/etc/ark-release" or return -1;
  while (<ARK>)
  {
    $ver = $_;
    chomp ($ver);

    if ($ver =~ /^Ark Linux/)
    {
      close ARK;
      return "ark";
    }
  }

  close ARK;
  return -1;
}

sub check_freebsd
{
  my ($sysctl_cmd, @output);

  $sysctl_cmd = &Utils::File::locate_tool ("sysctl");
  @output = (readpipe("$sysctl_cmd -n kern.version"));
  foreach (@output)
  {
    chomp;
    if (/^FreeBSD\s([0-9]+)\.\S+.*/)
    {
      return "freebsd-$1";
    }
  }
  return -1;
}

sub check_solaris
{
  my ($fd, $dist);

  $fd = &Utils::File::run_pipe_read ("uname -r");
  return -1 if $fd eq undef;
  chomp ($dist = <$fd>);
  &Utils::File::close_file ($fd);

  if ($dist =~ /^5\.(\d+)/) { return "solaris-2.$1" }
  return -1;
}

sub check_distro_file
{
  my ($file, $dist, $re, $map) = @_;
  my ($ver);
  local *FILE;

  open FILE, "$gst_prefix/$file" or return -1;

  while (<FILE>)
  {
    chomp;

    if ($_ =~ "$re")
    {
      $ver = $1;
      $ver = $$map{$ver} if ($$map{$ver});

      close FILE;
      return "$dist-$ver";
    }
  }

  close FILE;
  return -1;
}

sub check_file_exists
{
  my ($file, $distro) = @_;

  return $distro if stat ("$gst_prefix/$file");
  return -1;
}

sub get_system
{
  # get the output of 'uname -s', it returns the system we are running
  $Utils::Backend::tool{"system"} = &Utils::File::run_backtick ("uname -s");
  chomp ($Utils::Backend::tool{"system"});
}

sub set_platform
{
  my ($platform) = @_;
  my ($p);

  if (&ensure_platform ($platform))
  {
    $platform = &ensure_distro_map ($platform);

    $Utils::Backend::tool{"platform"} = $gst_dist = $platform;
    &Utils::Report::do_report ("platform_success", $platform);
    &Utils::Report::end ();
    return;
  }

  &set_platform_unsupported ($object);
  &Utils::Report::do_report ("platform_unsup", $platform);
  &Utils::Report::end ();
}

sub set_platform_unsupported
{
  my ($object) = @_;

  $Utils::Backend::tool{"platform"} = $gst_dist = undef;
  #&Net::DBus::Object::emit_signal ($object, "noPlatformDetected");
}

sub ensure_platform
{
  my ($platform) = @_;

  return $platform if ($$PLATFORM_INFO{$platform} ne undef);
  return undef;
}

sub guess
{
  my ($object) = @_;
  my ($distro, $func);
  my ($checks, $check);

  my %platform_checks = (
    "Linux"   => [[ \&check_lsb ],
                  [ \&check_file_exists, "/etc/debian_version", "debian" ],
                  [ \&check_distro_file, "/etc/SuSE-release", "suse", "VERSION\\s*=\\s*(\\S+)" ],
                  [ \&check_distro_file, "/etc/blackPanther-release", "blackpanther", "^Linux Black Panther release (\\S+)" ],
                  [ \&check_distro_file, "/etc/blackPanther-release", "blackpanther", "^Black Panther ( L|l)inux release ([\\d\\.]+)" ],
                  [ \&check_distro_file, "/etc/vine-release", "vine", "^Vine Linux (\\S+)" ],
                  [ \&check_distro_file, "/etc/fedora-release", "fedora", "^Fedora Core release (\\S+)" ],
                  [ \&check_distro_file, "/etc/mandrake-release", "mandrake", "^Linux Mandrake release (\\S+)" ],
                  [ \&check_distro_file, "/etc/mandrake-release", "mandrake", "^Mandrake( L|l)inux release (\\S+)" ],
                  [ \&check_distro_file, "/etc/mandriva-release", "mandriva", "^Linux Mandriva release (\\S+)" ],
                  [ \&check_distro_file, "/etc/mandriva-release", "mandriva", "^Mandriva( L|l)inux release (\\S+)" ],
                  [ \&check_distro_file, "/etc/conectiva-release", "conectiva", "^Conectiva Linux (\\S+)" ],
                  [ \&check_distro_file, "/etc/redhat-release", "redhat", "^Red Hat Linux.*\\s+(\\S+)" ],
                  [ \&check_distro_file, "/etc/openna-release", "openna", "^OpenNA (\\S+)" ],
                  [ \&check_distro_file, "/etc/slackware-version", "slackware", "^Slackware (\\S+)" ],
                  [ \&check_distro_file, "/etc/bluewhite64-version", "bluewhite64", "^Bluewhite64 (\\S+)" ],
                  [ \&check_distro_file, "/etc/vlos-release", "vlos", "^VLOS.*\\s+(\\S+)" ],
                  [ \&check_file_exists, "/usr/portage", "gentoo" ],
                  [ \&check_distro_file, "/etc/pld-release", "pld", "^(\\S+) PLD Linux" ],
                  [ \&check_rpath ],
                  [ \&check_file_exists, "/etc/arch-release", "archlinux" ],
                  [ \&check_ark ],
                  [ \&check_yoper ],
                  [ \&check_distro_file, "/etc/yellowdog-release", "yellowdog", "^Yellow Dog Linux release (\\S+)" ],
                 ],
    "FreeBSD" => [[ \&check_freebsd ]],
    "SunOS"   => [[ \&check_solaris ]]
  );

  $distro = $Utils::Backend::tool{"system"};
  $checks = $platform_checks{$distro};

  foreach $check (@$checks) {
    $func = shift (@$check);
    $dist = &$func (@$check);

    if ($dist != -1 && &ensure_platform ($dist))
    {
      $dist = &ensure_distro_map ($dist);
      $Utils::Backend::tool{"platform"} = $gst_dist = $dist;
      &Utils::Report::do_report ("platform_success", $dist);
      return;
    }
  }

  &set_platform_unsupported ($tool, $object);
  &Utils::Report::do_report ("platform_unsup", $platform);
  &Utils::Report::end ();
}

sub get_cached_platform
{
  my ($file, $platform);

  $file = &Utils::File::get_base_path() . "/detected-platform";
  $platform = &Utils::Parse::get_first_line ($file);

  if (&ensure_platform ($platform))
  {
    $Utils::Backend::tool{"platform"} = $gst_dist = $platform;
    &Utils::Report::do_report ("platform_success", $platform);
    return 1;
  }

  return 0;
}

sub cache_platform
{
  my ($file, $platform);

  $file = &Utils::File::get_base_path() . "/detected-platform";
  &Utils::Replace::set_first_line ($file, $gst_dist);
}

sub init
{
  &get_system ();

  # FIXME: need to figure out whether the underlying platform has
  # been updated or changed, until now it's safer to ignore the cache,
  # this function is called just once in all the executable lifecicle,
  # so I don't expect any noticeable performance decrease.
  #if (!&get_cached_platform ())
  #{
    &guess ($self) if !$Utils::Backend::tool{"platform"};
    &cache_platform ();
  #}
}

1;
