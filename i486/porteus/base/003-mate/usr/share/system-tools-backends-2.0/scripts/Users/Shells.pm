#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>,
#          Arturo Espinosa <arturo@ximian.com>,
#          Tambet Ingo <tambet@ximian.com>.
#          Grzegorz Golawski <grzegol@pld-linux.org> (PLD Support)
#          Carlos Garnacho <carlosg@gnome.org>
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

package Users::Shells;

use Utils::Util;
use Utils::Report;
use Utils::File;
use Utils::Replace;

# Totally generic atm
$shells_file = "/etc/shells";

sub get_files
{
  return $shells_file;
}

sub push_shell
{
  my ($shells, $shell) = @_;

  $$shells{$shell} = 1 if (stat ($shell));
}

sub get
{
  my ($ifh, %shells, $shell, @arr);

  # Init shells, I think every *nix has /bin/false.
  &push_shell (\%shells, "/bin/false");

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    #SunOS doesn't have anything like /etc/shells
    my $possible_shells =
      [ "/bin/bash", "/bin/csh", "/bin/jsh", "/bin/ksh", "/bin/pfcsh", "/bin/pfksh", "/bin/pfsh", "/bin/sh",
        "/bin/tcsh", "/bin/zsh", "/sbin/jsh", "/sbin/jsh", "/sbin/pfsh", "/sbin/sh", "/usr/bin/bash",
        "/usr/bin/csh", "/usr/bin/jsh", "/usr/bin/ksh", "/usr/bin/pfcsh", "/usr/bin/pfksh", "/usr/bin/pfsh",
        "/usr/bin/sh", "/usr/bin/tcsh", "/usr/bin/zsh", "/usr/xpg4/bin/sh" ];

    foreach $shell (@$possible_shells)
    {
      &push_shell (\%shells, $shell);
    }
  }
  else
  {
    $ifh = &Utils::File::open_read_from_names($shells_file);

    while (<$ifh>)
    {
      next if &Utils::Util::ignore_line ($_);
      chomp;
      &push_shell (\%shells, $_);
    }

    &Utils::File::close_file ($ifh);
  }

  foreach $i (keys (%shells)) {
    push @arr, $i;
  }

  return \@arr;
}

sub set
{
  my ($shells) = @_;
  my ($buff, $line, $nline);

  #SunOS doesn't have /etc/shells
  return if ($Utils::Backend::tool{"system"} eq "SunOS");

  $buff = &Utils::File::load_buffer ($shells_file);
  return unless $buff;

  &Utils::File::join_buffer_lines ($buff);
  $nline = 0;

  # delete all file entries that really exist,
  # this is done for not deleting entries that
  # might be installed later
  while ($nline <= $#$buff)
  {
    $line = $$buff[$nline];
    chomp $line;

    if (!&Utils::Util::ignore_line ($line))
    {
      delete $$buff[$nline] if (stat ($line));
    }

    $nline++;
  }

  # Add shells list
  foreach $line (@$shells)
  {
    push @$buff, "$line\n" if (stat ($line));
  }

  &Utils::File::save_buffer ($buff, $shells_file);
}
