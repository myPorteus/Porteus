#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# NTP Configuration handling
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>
#          Carlos Garnacho     <carlosg@gnome.org>
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

package Time::NTP;

sub get_config_file ()
{
  my %dist_map =
  (
    "redhat-6.2"      => "redhat-6.2",
    "redhat-7.0"      => "redhat-6.2",
    "redhat-7.1"      => "redhat-6.2",
    "redhat-7.2"      => "redhat-6.2",
    "redhat-7.3"      => "redhat-6.2",
    "redhat-8.0"      => "redhat-6.2",
    "mandrake-9.0"    => "redhat-6.2",
    "debian"          => "redhat-6.2",
    "suse-9.0"        => "redhat-6.2",
    "slackware-9.1.0" => "redhat-6.2",
    "slackware-14.0"  => "redhat-6.2",
    "slackware-14.1"  => "redhat-6.2",
    "gentoo"          => "redhat-6.2",
    "pld-1.0"         => "pld-1.0",
    "vine-3.0"        => "redhat-6.2",
    "freebsd-5"       => "redhat-6.2",
    "archlinux"       => "redhat-6.2",
    "solaris-2.11"    => "solaris-2.11",
  );

  my %dist_table =
  (
    "redhat-6.2"   => "/etc/ntp.conf",
    "pld-1.0"      => "/etc/ntp/ntp.conf",
    "solaris-2.11" => "/etc/inet/ntp.conf",
  );

  my $dist = $dist_map{$Utils::Backend::tool{"platform"}};
  return $dist_table{$dist} if $dist;

  &Utils::Report::do_report ("platform_no_table", $$tool{"platform"});
  return undef;
}

sub get_ntp_servers
{
  $ntp_conf = &get_config_file ();

  return &Utils::Parse::split_all_array_with_pos ($ntp_conf, "server", 0, "[ \t]+", "[ \t]+");
}

sub ntp_conf_replace
{
  my ($file, $key, $re, $value) = @_;
  my ($fd, @line, @res);
  my ($buff, $i);
  my ($pre_space, $post_comment);
  my ($line_key, $val, $rest);
  my ($n, $ret);

  # If config file does not exist, and no server has to be written,
  # don't create and empty file that will confuse package managers.
  # Notably, this avoids creating an empty file when simply running ntpdate.
  return if (!&Utils::File::exists ($file) && !@$value);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_split", $key, $file);

  $buff = &Utils::File::load_buffer ($file);
  
  foreach $i (@$buff)
  {
    $pre_space = $post_comment = "";

    chomp $i;

    $pre_space    = $1 if $i =~ s/^([ \t]+)//;
    $post_comment = $1 if $i =~ s/([ \t]*\#.*)//;
    
    if ($i ne "")
    {
      @line = split ($re, $i, 3);
      $line_key = shift (@line);
      $val      = shift (@line);
      $rest     = shift (@line);

      # found the key?
      if ($line_key eq $key)
      {
        $n = 0;

        while (@$value[$n] && (@$value[$n] ne $val))
        {
          $n++;
        }

        if (@$value[$n] ne $val)
        {
          $i = "";
          next;
        }

        delete @$value[$n];
        chomp $val;
        $i  = &Utils::Replace::set_value ($key, $val, $re) . " " . $rest;
      }
    }

    $i = $pre_space . $i . $post_comment . "\n";
  }

  foreach $i (@$value)
  {
    push (@$buff, &Utils::Replace::set_value ($key, $i, $re) . "\n") if ($i ne "");
  }

  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

sub set_ntp_servers
{
  my (@config) = @_;
  my ($ntp_conf);

  $ntp_conf = &get_config_file ();
  return &ntp_conf_replace ($ntp_conf, "server", "[ \t]+", @config);
}

sub apply_ntp_date
{
  my ($config) = @_;
  my ($servers, $server);

  foreach $server (@$config) {
      $servers .= " $server";
  }

  if ($server eq "") {
      # There are no servers, pick them from the ntp.org pool
      $server = "0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org";
  }

  # run ntpdate, this will only be effective
  # when there isn't any NTP server running
  &Utils::File::run ("ntpdate", "-b", $servers) if ($servers);
}

sub get
{
  return &get_ntp_servers ();
}

sub set
{
  &apply_ntp_date (@_);
  return &set_ntp_servers (@_);
}

sub get_files
{
  my ($files);

  push @$files, &get_config_file ();
  return $files;
}

1;
