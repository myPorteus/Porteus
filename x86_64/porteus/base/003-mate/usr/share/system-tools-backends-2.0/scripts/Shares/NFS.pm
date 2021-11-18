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

package Shares::NFS;

use Utils::Parse;

sub get_distro_nfs_file
{
  return "/etc/dfs/dfstab" if ($Utils::Backend::tool{"system"} eq "SunOS");
  return "/etc/exports";
}

sub get_share_client_info
{
  my ($client) = @_;
  my ($pattern, $options_str, @options, $option);
  my ($rw);

  $client =~ /^([a-zA-Z0-9.-_*?@\/]+)/;
  $pattern = $1;
  $pattern = "0.0.0.0/0" if $pattern eq "";
  $rw = 0;

  if ($client =~ /\((.+)\)/)
  {
    $option_str = $1;
    @options = ($option_str =~ /([a-zA-Z0-9_=-]+),?/mg);

    for $option (@options)
    {
      $rw = 1 if ($option eq "rw");
      # Add supported NFS export options here. Some might have to be split on '='.
    }
  }

  return [ $pattern, !$rw ];
}

sub get_share_info
{
  my ($clients) = @_;
  my (@share_info, $client);

  foreach $client (@$clients)
  {
    push @share_info, &get_share_client_info ($client);
  }

  return \@share_info;
}

sub get_share_info_sunos
{
  my ($str) = @_;
  my (@options, $opt, @values, @share_info);

  @options = split (/\s*,\s*/, $str);

  foreach $opt (@options)
  {
    my ($option, $value);

    @values = split /\s*=\s*/, $opt;
    $option = $values[0];
    $value = $values[1];

    # only support "rw" and "ro" at the moment
    if ($option eq "rw" || $option eq "ro")
    {
      my ($rw, $client);
      $rw = ($option eq "rw") ? 1 : 0;

      if (!$value)
      {
        push @share_info, [ $rw, "0.0.0.0/0" ];
      }
      else
      {
        my @clients;

        # get the clients list
        @clients = split (/:/, $value);

        foreach $client (@clients)
        {
          push @share_info, [ $client, $rw ];
        }
      }
    }
  }

  return \@share_info;
}

sub get_client_opts_sunos
{
  my ($clients) = @_;
  my (@rw_clients, @ro_clients, $client, $str, $i);

  foreach $i (@$clients)
  {
    #FIXME: broken logic?
    if (!$$i[1])
    {
      push @rw_clients, $$i[0];
    }
    else
    {
      push @ro_clients, $$i[0];
    }
  }

  # get rw clients
  if (scalar (@rw_clients))
  {
    $str .= "rw=" . join (":", @rw_clients);
  }

  # get ro clients
  if (scalar (@ro_clients))
  {
    $str .= ",ro=" . join (":", @ro_clients);
  }

  return $str;
}

sub get_export_line
{
  my ($share) = @_;
  my ($str, $i);

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    $str  = "share -F nfs";
    $str .= " -o " . &get_client_opts_sunos ($$share[1]);
    $str .= " " . $$share[0];
  }
  else
  {
    $str = sprintf ("%-15s ", $$share[0]);

    foreach $i (@{$$share[1]})
    {
      $str .= $$i[0];
      #FIXME: broken logic?
      $str .= "(rw)" if (!$$i[1]);
      $str .= " ";
    }

    $str .= "\n";
  }

  return $str;
}

sub share_line_matches
{
  my ($share, $line) = @_;

  return 0 if (&Utils::Util::ignore_line ($line));
  chomp $line;

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    return 0 if ($line !~ /\-F\s+nfs/);
    return 1 if ($line =~ /$$share[0]$/);
  }
  else
  {
    my @arr;

    @arr = split /[ \t]+/, $line;
    return 1 if ($arr[0] eq $$share[0]);
  }
}

sub add_entry
{
  my ($share, $file) = @_;
  my ($buff);

  $buff = &Utils::File::load_buffer ($file);
  push @$buff, &get_export_line ($share);

  &Utils::File::save_buffer ($buff, $file);
}

sub delete_entry
{
  my ($share, $file) = @_;
  my ($buff, $i, $line, @arr);

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $i = 0;

  while ($$buff[$i])
  {
    if (&share_line_matches ($share, $$buff[$i]))
    {
      delete $$buff[$i];
    }

    $i++;
  }

  &Utils::File::clean_buffer ($buff);
  &Utils::File::save_buffer  ($buff, $file);
}

sub change_entry
{
  my ($old_share, $share, $file) = @_;
  my ($buff, $i, $line, @arr);

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $i = 0;

  while ($$buff[$i])
  {
    if (&share_line_matches ($old_share, $$buff[$i]))
    {
      $$buff[$i] = &get_export_line ($share);
    }

    $i++;
  }

  &Utils::File::clean_buffer ($buff);
  &Utils::File::save_buffer  ($buff, $file);
}

sub get_dfstab_shares
{
  my ($file, $type) = @_;
  my ($buff, $line, @arr);

  # dfstab example:
  #
  #       share [-F fstype] [-o fs_options ] [-d description] [pathname [resourcename]]
  #       .e.g,
  #       share  -F nfs  -o rw=engineering  -d "home dirs"  /export/home2

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  return [] if (!$buff);

  foreach $line (@$buff)
  {
    chomp $line;
      
    if ($line =~ /^\s*\S*share\s+(.*)/)
    {
      my $share;
      my $line = $1;

      if ($line =~ /\s-F\s+(\S+)/) { $share->{'type'} = $1; }
      else { $share->{'type'} = "nfs"; }

      # skip undesired shares
      next if ($share->{'type'} ne $type);

      if ($line =~ /\s+(\/\S+)/ || $line =~ /\s+(\/)/ || $line eq "/") { $share->{'dir'} = $1; }
      if ($line =~ /-o\s+"([^\"]+)"/ || $line =~ /-o\s+(\S+)/) { $share->{'opts'} = $1; }
      #if ($line =~ /-d\s+\"([^\"]+)\"/ || $line =~ /-d\s+(\S+)/) { $share->{'desc'} = $1; }

      push @arr, $share;
    }
  }
  
  return \@arr;
}

sub get
{
  my ($nfs_file);
  my (@sections, @table, $entries);
  my ($point, $share_info);

  $nfs_file = &get_distro_nfs_file ();

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    my $shares = &get_dfstab_shares ($nfs_file, "nfs");

    foreach $share (@$shares)
    {
      $point = $share->{'dir'};

      $share_info = &get_share_info_sunos ($share->{'opts'});
      push @table, [ $point, $share_info ];
    }
  }
  else
  {
    $entries = &Utils::Parse::split_hash_with_continuation ($nfs_file, "[ \t]+", "[ \t]+");

    foreach $point (keys %$entries)
    {
      my $clients = $$entries{$point};

      $share_info = &get_share_info ($clients);
      push @table, [ $point, $share_info ];
    }
  }

  return \@table;
}

sub set
{
  my ($config) = @_;
  my ($nfs_exports_file);
  my ($old_config, %shares);
  my (%config_hash, %old_config_hash);
  my ($state, $i);

  $nfs_exports_name = &get_distro_nfs_file ();
  $old_config = &get ();

  foreach $i (@$config)
  {
    $shares{$$i[0]} |= 1;
    $config_hash{$$i[0]} = $i;
  }

  foreach $i (@$old_config)
  {
    $shares{$$i[0]} |= 2;
    $old_config_hash{$$i[0]} = $i;
  }

  foreach $i (sort keys (%shares))
  {
    $state = $shares{$i};

    if ($state == 1)
    {
      # These entries have been added
      &add_entry ($config_hash{$i}, $nfs_exports_name);
    }
    elsif ($state == 2)
    {
      # These entries have been deleted
      &delete_entry ($old_config_hash{$i}, $nfs_exports_name);
    }
    elsif (($state == 3) &&
           (!Utils::Util::struct_eq ($config_hash{$i}, $old_config_hash{$i})))
    {
      # These entries have been modified
      &change_entry ($old_config_hash{$i}, $config_hash{$i}, $nfs_exports_name);
    }
  }

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    &Utils::File::run ("unshareall", "-F", "nfs");
    &Utils::File::run ("shareall", "-F", "nfs");
  }
}

sub get_files
{
  my ($files);

  push @$files, &get_distro_nfs_file ();
  return $files;
}

1;
