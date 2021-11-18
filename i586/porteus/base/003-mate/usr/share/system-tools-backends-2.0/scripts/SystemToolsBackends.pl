#!/usr/bin/perl
#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# Loader for the system tools backends.
#
# Copyright (C) 2005 Carlos Garnacho
#
# Authors: Carlos Garnacho Parro  <carlosg@gnome.org>
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

use lib "/usr/share/system-tools-backends-2.0/scripts";
use lib "/usr/share/system-tools-backends-2.0/modules";

our $localstatedir = "/var";
our $filesdir = "/usr/share/system-tools-backends-2.0/files";

BEGIN {
  my $i = 0;

  # Clean undesired entries in @INC
  while ($INC[$i]) {
    delete $INC[$i] if ($INC[$i] =~ /^@/);
    $i++;
  }
}

use Utils::Backend;

# Initialize tool
&Utils::Backend::init (@ARGV);

if (!$Utils::Backend::tool{"module"})
{
  print STDERR "Error: You must specify a module to load.\n\n";
  exit (-1);
}

require $Utils::Backend::tool{"module"};

&Utils::DBus::run ();
