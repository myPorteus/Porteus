#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for the Service config
#
# Copyright (C) 2010 Milan Bouchet-Valat
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

package ServiceConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use Init::Services;

my $OBJECT_NAME = "ServiceConfig2";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";

our $SERVICE_FORMAT = [ "struct", "string", [ "array", [ "struct", "string", "int32", "int32" ]]];

sub new
{
  my $class = shift;
  my $self  = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

#  Utils::Monitor::monitor_files (&Users::Groups::get_files (),
#                                 $self, $OBJECT_NAME, "changed");

  return $self;
}

dbus_method ("get", [ "string" ], [ $SERVICE_FORMAT ]);
dbus_method ("set", [ $SERVICE_FORMAT ], []);
dbus_signal ("changed", []);

sub get
{
  my ($self, $name) = @_;
  $self->SUPER::reset_counter ();

  return &Init::Services::get_service ($name);
}

sub set
{
  my ($self, @config) = @_;
  $self->SUPER::reset_counter ();

  &Init::Services::set_service (@config);
}

my $config = ServiceConfig->new ();

1;
