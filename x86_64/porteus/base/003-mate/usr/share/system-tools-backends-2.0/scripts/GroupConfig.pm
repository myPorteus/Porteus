#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for the Groups list
#
# Copyright (C) 2009 Milan Bouchet-Valat
#
# Authors: Milan Bouchet-Valat <nalimilan@club.fr>
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

package GroupConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use Users::Groups;
use Users::Users;

my $OBJECT_NAME = "GroupConfig2";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";

# name, password, GID, users
our $GROUP_FORMAT = [ "struct", "string", "string", "uint32", [ "array", "string" ]];

sub new
{
  my $class = shift;
  my $self  = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

#  Utils::Monitor::monitor_files (&Users::Groups::get_files (),
#                                 $self, $OBJECT_NAME, "changed");
  return $self;
}

dbus_method ("get", [ "string" ], [ $GROUP_FORMAT ]);
dbus_method ("set", [ $GROUP_FORMAT ], []);
dbus_method ("add", [ $GROUP_FORMAT ], []);
dbus_method ("del", [ $GROUP_FORMAT ], []);
#dbus_signal ("changed", []);

sub get
{
  my ($self, $name) = @_;

  return Users::Groups::get_group ($name);
}

sub set
{
  my ($self, @config) = @_;

  Users::Groups::set_group (@config);
}

sub add
{
  my ($self, @config) = @_;

  Users::Groups::add_group (@config);
}

sub del
{
  my ($self, @config) = @_;

  Users::Groups::del_group (@config);
}

sub getFiles
{
  my ($self) = @_;

  return &Users::Groups::get_files ();
}

my $config = GroupConfig->new ();

1;
