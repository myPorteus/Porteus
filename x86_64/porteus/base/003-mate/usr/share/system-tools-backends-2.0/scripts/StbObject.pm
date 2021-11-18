#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
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

package StbObject;

use Utils::DBus;
use base qw(Net::DBus::Object);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);

dbus_method ("getFiles", [], [[ "array", "string" ]]);

sub new
{
  my $class   = shift;
  my $path    = shift;
  my $name    = shift;
  my $platform;

  my $bus = &Utils::DBus::get_bus ();
  my $service = $bus->export_service ($Utils::Backend::DBUS_PREFIX . ".$name");
  my $self = $class->SUPER::new ($service, $path);

  bless $self, $class;

  if (!$Utils::Backend::tool{"platform"})
  {
    $platform = &Utils::DBus::get_platform ();
    &Utils::Backend::set_dist (\%Utils::Backend::tool, $platform) if ($platform);
  }

  &set_counter ();

  return $self;
}

sub set_counter
{
  #wait three minutes until shutdown
  if (!$Utils::Backend::tool{"no-shutdown"})
  {
    $Utils::Backend::tool{"timer"} = &Utils::DBus::add_timeout (180000, \&Utils::DBus::shutdown);
  }
}

sub reset_counter
{
  &Utils::DBus::remove_timeout ($Utils::Backend::tool{"timer"});
  set_counter ();
}

1;
