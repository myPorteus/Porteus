#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# DBus object for the Users list
#
# Copyright (C) 2005 Carlos Garnacho
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

package UsersConfig;

use base qw(StbObject);
use Net::DBus::Exporter ($Utils::Backend::DBUS_PREFIX);
use UserConfig;
use Users::Users;
use Users::Shells;

my $OBJECT_NAME = "UsersConfig2";
my $OBJECT_PATH = "$Utils::Backend::DBUS_PATH/$OBJECT_NAME";

# settings: list of shells, umin, umax, home prefix, default shell, default group, encrypted home support
# only configuration settings are set via UsersConfig
my $set_format = [ [ "array", "string" ], "uint32", "uint32", "string", "string", "uint32", "bool" ];
# array of users plus configuration settings
my $get_format = [[ "array", $UserConfig::USER_FORMAT ], [ "array", "string" ], "uint32", "uint32", "string", "string", "uint32", "bool" ];


sub new
{
  my $class = shift;
  my $self  = $class->SUPER::new ($OBJECT_PATH, $OBJECT_NAME);

  bless $self, $class;

  return $self;
}

dbus_method ("get", [], $get_format);
dbus_method ("set", $set_format, []);

sub get
{
  my ($self) = @_;
  my $logindefs, $users, $shells, $ecryptfs_support;
  $self->SUPER::reset_counter ();

  $logindefs = &Users::Users::get_logindefs ();
  $users = &Users::Users::get ();
  $shells = &Users::Shells::get ();
  $ecryptfs_support = (&Utils::File::locate_tool ("mount.ecryptfs") ne "")
    && ($Utils::Backend::tool{"platform"} =~ /^debian/);

  return ($users, $shells, $$logindefs{"umin"},
          $$logindefs{"umax"}, $$logindefs{"home_prefix"},
          $$logindefs{"shell"}, $$logindefs{"group"},
          $ecryptfs_support);
}

sub set
{
  my ($self, @config) = @_;
  $self->SUPER::reset_counter ();

  Users::Shells::set ($config[0]);
  Users::Users::set_logindefs ({"umin"        => $config[2],
                                "umax"        => $config[3],
                                "home_prefix" => $config[4],
                                "shell"       => $config[5],
                                "group"       => $config[6]});
}


sub getFiles
{
  my ($self) = @_;
  my ($files);

  $files = &Users::Users::get_files ();

  return ($files);
}

my $config = UsersConfig->new ();

1;
