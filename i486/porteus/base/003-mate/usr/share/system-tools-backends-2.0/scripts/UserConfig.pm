#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for a single user configuration
#
# Copyright (C) 2007 Carlos Garnacho
#
# Authors: Carlos Garnacho Parro  <carlosg@gnome.org>,
#          Milan Bouchet-Valat <nalimilan@club.fr>.
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

package UserConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use Users::Users;

my $OBJECT_NAME = "UserConfig2";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";

# base user struct, also used in UsersConfig
# variables: login, password, UID, main group GID, GECOS fields, home, shell,
# password flags, encrypted home, home dir flags, locale, location, face
our $USER_FORMAT = [ "struct", "string", "string", "uint32", "uint32", [ "array", "string" ], "string", "string",
                     "int32", "bool", "int32", "string", "string", "string" ];

sub new
{
  my $class = shift;
  my $self  = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

  return $self;
}

dbus_method ("get", [ "string" ], [ $USER_FORMAT ]);
dbus_method ("set", [ $USER_FORMAT ], []);
dbus_method ("add", [ $USER_FORMAT ], [ $USER_FORMAT ]);
dbus_method ("del", [ $USER_FORMAT ], []);

sub get
{
  my ($self, $login) = @_;

  return Users::Users::get_user ($login);
}

sub set
{
  my ($self, @config) = @_;

  Users::Users::set_user (@config);
}

sub add
{
  my ($self, @config) = @_;

  return Users::Users::add_user (@config);
}

sub del
{
  my ($self, @config) = @_;

  Users::Users::del_user (@config);
}

sub getFiles
{
  my ($self) = @_;

  return Users::Users::get_files ();
}

my $config = UserConfig->new ();

1;
