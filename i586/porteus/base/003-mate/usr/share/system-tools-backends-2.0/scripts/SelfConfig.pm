#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for self user configuration
#
# Copyright (C) 2009 Milan Bouchet-Valat
#
# Authors: Milan Bouchet-Valat <nalimilan@club.fr>.
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

package SelfConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use Users::Users;

my $OBJECT_NAME = "SelfConfig2";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";

# user is only allowed to change his own GECOS fields, locale, location
my $format = [ "uint32", [ "array", "string" ], "string", "string" ];

sub new
{
  my $class = shift;
  my $self  = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

  return $self;
}

# UID is filled by dispatcher
dbus_method ("get", "uint32", $format);
dbus_method ("set", $format, []);

sub get
{
  my ($self, $uid) = @_;

  return Users::Users::get_self ($uid);
}

sub set
{
  my ($self, @config) = @_;

  Users::Users::set_self (@config);
}

sub getFiles
{
  my ($self) = @_;

  return Users::Users::get_files ();
}

my $config = SelfConfig->new ();

1;
