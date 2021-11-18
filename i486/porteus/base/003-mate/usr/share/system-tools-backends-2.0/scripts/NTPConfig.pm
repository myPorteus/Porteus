#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for the NTP config
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

package NTPConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use Utils::Backend;
use Time::NTP;

my $OBJECT_NAME = "NTPConfig";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";
my $format = [[ "array", "string" ]];

sub new
{
  my $class = shift;
  my $self  = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

#  Utils::Monitor::monitor_files (&Users::Groups::get_files (),
#                                 $self, $OBJECT_NAME, "changed");

  return $self;
}

dbus_method ("get", [], $format);
dbus_method ("set", $format, []);
#dbus_signal ("changed", []);

sub get
{
  my ($self) = @_;
  $self->SUPER::reset_counter ();

  return &Time::NTP::get ();
}

sub set
{
  my ($self, @config) = @_;
  $self->SUPER::reset_counter ();

  &Time::NTP::set (@config);  
}

sub getFiles
{
  return &Time::NTP::get_files ();
}

my $config = NTPConfig->new ();

1;
