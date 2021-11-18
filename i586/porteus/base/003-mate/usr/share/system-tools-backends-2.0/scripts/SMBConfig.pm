#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for the SMB Configuration
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

package SMBConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use Shares::SMB;

my $OBJECT_NAME = "SMBConfig";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";
my $format = [[ "array", [ "struct", "string", "string", "string", "int32", "int32", "int32", "int32" ]],
              "string", "string", "int32", "string", [ "array", [ "struct", "string", "string" ]]];

sub new
{
  my $class   = shift;
  my $self    = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

  return $self;
}

dbus_method ("get", [], $format);
dbus_method ("set", $format, []);

sub get
{
  my ($self) = @_;
  $self->SUPER::reset_counter ();

  return &Shares::SMB::get ();
}

sub set
{
  my ($self, @config) = @_;
  $self->SUPER::reset_counter ();

  &Shares::SMB::set (@config);
}

sub getFiles
{
  return &Shares::SMB::get_files ();
}

my $config = SMBConfig->new ();

1;
