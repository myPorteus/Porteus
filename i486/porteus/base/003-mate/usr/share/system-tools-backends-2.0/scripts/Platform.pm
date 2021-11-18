#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for the Services config
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

package Platform;

use base qw(Net::DBus::Object);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX . ".Platform");
use Utils::Platform;
use Utils::Backend;
use Utils::DBus;

my $OBJECT_NAME = "Platform";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";

dbus_method ("getPlatformList", [], [[ "array", [ "struct", "string", "string", "string", "string" ]]]);
dbus_method ("getPlatform", [], [ "string" ]);
dbus_method ("setPlatform", [ "string" ], []);

sub new
{
  my $class   = shift;
  my $service = shift;
  my $self    = $class->SUPER::new ($service, $OBJECT_PATH);

  bless $self, $class;

  &Utils::Platform::init ();
  return $self;
}

sub getPlatformList
{
  my ($self) = @_;
  my ($arr, $hash, $key);

  $hash = &Utils::Platform::get_platform_info ();

  foreach $key (keys %$hash)
  {
    push @$arr, [ $$hash{$key}[0],
			   $$hash{$key}[1],
			   $$hash{$key}[2],
			   $key ];
  }

  return $arr;
}

sub getPlatform
{
  return $Utils::Backend::tool{"platform"};
}

# A directive handler that sets the currently selected platform.
sub setPlatform
{
  my ($self, $platform) = @_;

  &Utils::Platform::set_platform ($platform);
}

my $bus = &Utils::DBus::get_bus ();
my $service = $bus->export_service ($Utils::Backend::DBUS_PREFIX . ".$OBJECT_NAME");
my $platforms_list  = Platform->new ($service);

1;
