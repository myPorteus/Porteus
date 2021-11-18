#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>
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

package Shares::SMB;

use Utils::File;

# --- share_export_smb_info; information on a particular SMB export --- #

sub gst_share_smb_info_set
{
  my ($info, $key, $value) = @_;
  
  if ($value eq "")
  {
    delete $info->{$key};
  }
  else
  {
    $info->{$key} = $value;
  }
}

sub gst_share_smb_info_get_name
{
  return $_[0]->{'name'};
}

sub gst_share_smb_info_set_name
{
  &gst_share_smb_info_set ($_[0], 'name', $_[1]);
}

sub gst_share_smb_info_get_point
{
  return $_[0]->{'point'};
}

sub gst_share_smb_info_set_point
{
  &gst_share_smb_info_set ($_[0], 'point', $_[1]);
}

sub gst_share_smb_info_get_comment
{
  return $_[0]->{'comment'};
}

sub gst_share_smb_info_set_comment
{
  &gst_share_smb_info_set ($_[0], 'comment', $_[1]);
}

sub gst_share_smb_info_get_enabled
{
  return $_[0]->{'enabled'};
}

sub gst_share_smb_info_set_enabled
{
  &gst_share_smb_info_set ($_[0], 'enabled', $_[1]);
}

sub gst_share_smb_info_get_browse
{
  return $_[0]->{'browse'};
}

sub gst_share_smb_info_set_browse
{
  &gst_share_smb_info_set ($_[0], 'browse', $_[1]);
}

sub gst_share_smb_info_get_public
{
  return $_[0]->{'public'};
}

sub gst_share_smb_info_set_public
{
  &gst_share_smb_info_set ($_[0], 'public', $_[1]);
}

sub gst_share_smb_info_get_write
{
  return $_[0]->{'write'};
}

sub gst_share_smb_info_set_write
{
  &gst_share_smb_info_set ($_[0], 'write', $_[1]);
}


# --- share_smb_table; multiple instances of share_smb_info --- #

sub smb_table_find
{
  my ($name, $shares) = @_;

  foreach $i (@$shares)
  {
    return $i if ($$i[0] eq $name)
  }

  return undef;
}

sub get_distro_smb_file
{
  my ($smb_comb);

  my %dist_map =
  (
   "debian"          => "debian",
   "redhat-6.2"      => "redhat-6.2",
   "redhat-7.0"      => "debian",
   "redhat-7.1"      => "debian",
   "redhat-7.2"      => "debian",
   "redhat-7.3"      => "debian",
   "redhat-8.0"      => "debian",
   "mandrake-9.0"    => "debian",
   "suse-9.0"        => "debian",
   "slackware-9.1.0" => "debian",
   "slackware-14.0"  => "debian",
   "slackware-14.1"  => "debian",
   "gentoo"          => "debian",
   "archlinux"       => "debian",
   "pld-1.0"         => "pld-1.0",
   "vine-3.0"        => "debian",
   "freebsd-5"       => "freebsd-5",
  );

  my %dist_tables =
  (
   "redhat-6.2" => "/etc/smb.conf",
   "debian" => "/etc/samba/smb.conf",
   "pld-1.0"    => "/etc/smb/smb.conf",
   "freebsd-5"  => "/usr/local/etc/smb.conf",
  );

  my $dist = $dist_map {$Utils::Backend::tool{"platform"}};
  return $dist_tables{$dist} if $dist;
  return undef;
}

sub get_share_info
{
  my ($smb_conf_name, $section) = @_;
  my @share;

  push @share, $section;
  push @share, &Utils::Parse::get_from_ini      ($smb_conf_name, $section, "path");
  push @share, &Utils::Parse::get_from_ini      ($smb_conf_name, $section, "comment");
  push @share, &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "available");
  push @share, &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "browsable") ||
               &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "browseable");
  push @share, &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "public")      ||
               &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "guest");
  push @share, &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "writable")    ||
               &Utils::Parse::get_from_ini_bool ($smb_conf_name, $section, "writeable");

  return \@share;
}

sub set_share_info
{
  my ($smb_conf_file, $share) = @_;
  my ($section);

  $section = shift (@$share);

  &Utils::Replace::set_ini        ($smb_conf_file, $section, "path",      shift (@$share));
  &Utils::Replace::set_ini        ($smb_conf_file, $section, "comment",   shift (@$share));
  &Utils::Replace::set_ini_bool   ($smb_conf_file, $section, "available", shift (@$share));
  &Utils::Replace::set_ini_bool   ($smb_conf_file, $section, "browsable", shift (@$share));
  &Utils::Replace::set_ini_bool   ($smb_conf_file, $section, "public",    shift (@$share));
  &Utils::Replace::set_ini_bool   ($smb_conf_file, $section, "writable",  shift (@$share));

  &Utils::Replace::remove_ini_var ($smb_conf_file, $section, "browseable");
  &Utils::Replace::remove_ini_var ($smb_conf_file, $section, "guest");
  &Utils::Replace::remove_ini_var ($smb_conf_file, $section, "writeable");
}

sub get_shares
{
  my ($smb_conf_file) = @_;
  my (@sections, @table, $share);

  # Get the sections.
  @sections = &Utils::Parse::get_ini_sections ($smb_conf_file);

  for $section (@sections)
  {
    next if ($section =~ /^(global)|(homes)|(printers)|(print\$)$/);
    next if (&Utils::Parse::get_from_ini_bool ($smb_conf_file, $section, "printable"));

    $share = &get_share_info ($smb_conf_file, $section);
    push @table, $share;
  }

  return \@table;
}

sub get_smb_users
{
  my ($fd, @info, $users);

  $fd = &Utils::File::run_pipe_read ("pdbedit -L");
  return [] if (!$fd);

  while (<$fd>)
  {
    chomp;
    @info = split (/:/, $_);
    push @$users, [ $info[0], "" ];
  }

  return $users;
}

sub get
{
  my ($smb_conf_file);
  my ($shares, $workgroup, $desc, $wins, $winsserver, $users);

  $smb_conf_file = &get_distro_smb_file;
  $shares = &get_shares ($smb_conf_file);

  $workgroup = &Utils::Parse::get_from_ini ($smb_conf_file, "global", "workgroup");
  $smbdesc = &Utils::Parse::get_from_ini ($smb_conf_file, "global", "server string");
  $wins = &Utils::Parse::get_from_ini_bool ($smb_conf_file, "global", "wins support");
  $winsserver = &Utils::Parse::get_from_ini ($smb_conf_file, "global", "wins server");
  $users = &get_smb_users ();

  return ($shares, $workgroup, $smbdesc, $wins, $winsserver, $users);
}

sub set_shares
{
  my ($smb_conf_file, $shares) = @_;
  my (@sections, $section, $share);

  # Get the sections.
  @sections = &Utils::Parse::get_ini_sections ($smb_conf_file);

  # remove deleted sections
  foreach $section (@sections)
  {
    next if ($section =~ /^(global)|(homes)|(printers)|(print\$)$/);
    next if (&Utils::Parse::get_from_ini_bool ($smb_conf_file, $section, "printable"));

    if (!&smb_table_find ($section, $shares))
    {
      Utils::Replace::remove_ini_section ($smb_conf_file, $section);
    }
  }

  for $share (@$shares)
  {
    &set_share_info ($smb_conf_file, $share);
  }
}

sub set_smb_users
{
  my ($users) = @_;
  my ($old_users, $user, $config, $state);
  my ($hash, $old_hash, $pipe);

  $old_users = &get_smb_users ();

  foreach $user (@$users)
  {
    $$config{$$user[0]} |= 1;
    $hash{$$user[0]} = $user;
  }

  foreach $user (@$old_users)
  {
    $$config{$$user[0]} |= 2;
    $old_hash{$$user[0]} = $user;
  }

  foreach $i (keys %$config)
  {
    $state = $$config{$i};
    $user = $hash{$i};

    if ($state == 1 || ($state == 3 && $$user[1]))
    {
      # User added, or password was modified
      $user = $hash{$i};
      $pipe = &Utils::File::run_pipe_write ("smbpasswd -s -a $$user[0]");
      # Have to write the password twice
      print $pipe "$$user[1]\n";
      print $pipe "$$user[1]\n";
      &Utils::File::close_file ($pipe);
    }
    elsif ($state == 2)
    {
      # User deleted
      $user = $old_hash{$i};
      &Utils::File::run ("pdbedit", "--delete", "-u", $$user[0]);
    }
  }
}

sub set
{
  my ($shares, $workgroup, $desc, $wins, $winsserver, $users) = @_;
  my ($smb_conf_file);
  my (@sections, $export);

  $smb_conf_file = &get_distro_smb_file;

  &set_shares ($smb_conf_file, $shares);

  &Utils::Replace::set_ini ($smb_conf_file, "global", "workgroup", $workgroup);
  &Utils::Replace::set_ini ($smb_conf_file, "global", "server string", $desc);
  &Utils::Replace::set_ini_bool ($smb_conf_file, "global", "wins support", $wins);
  &Utils::Replace::set_ini ($smb_conf_file, "global", "wins server", ($wins) ? "" : $winsserver);

  &set_smb_users ($users);
}

sub get_files
{
  my ($files);

  push @$files, &get_distro_smb_file ();
  return $files;
}

1;
