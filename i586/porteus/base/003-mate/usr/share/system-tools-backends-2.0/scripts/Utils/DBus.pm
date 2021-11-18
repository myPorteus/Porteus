#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# Common stuff for the ximian-setup-tools backends.
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>
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

package Utils::DBus;

use Net::DBus;
use Net::DBus::Service;
use Net::DBus::Reactor;

sub get_bus
{
  return Net::DBus->system;
}

sub run
{
  Net::DBus::Reactor->main->run ();
}

sub shutdown
{
  # exit the main loop
  Net::DBus::Reactor->main->shutdown ();
}

sub remove_timeout
{
  my ($timeout) = @_;
  Net::DBus::Reactor->main->remove_timeout ($timeout);
}

sub add_timeout
{
  my ($time, $func) = @_;
  return Net::DBus::Reactor->main->add_timeout ($time, Net::DBus::Callback->new(method => $func));
}

sub get_platform
{
  my $bus = Net::DBus->system;
  my $service = $bus->get_service("org.freedesktop.SystemToolsBackends");
  my $obj = $service->get_object ("/org/freedesktop/SystemToolsBackends/Platform");

  return $obj->getPlatform ();
}

1;
