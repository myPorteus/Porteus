#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

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

package Utils::Monitor;

use Cwd;
use strict;
use base qw(Net::DBus::Object);
use Utils::Backend;
eval "use Sys::Gamin;";
my $eval_gamin = $@;

my $has_gamin = ($eval_gamin eq "") ? 1 : 0;
my $fm;
my %objects;

if ($has_gamin)
{
  $fm = new Sys::Gamin;
}

sub do_monitor_files
{
  my ($event, $data, $func, $path, $object);

  return if (!$has_gamin);

  while ($fm->pending)
  {
    $event = $fm->next_event;
    
    if ($event->type eq "change" ||
        $event->type eq "create")
    {
      $data = $objects {$event->filename};
      $object = $$data{"object"};

      $object->emit_signal ($$data{"signal"});
    }
  }
}

sub add_file
{
  my ($file, $object, $name, $signal) = @_;
  my ($path);
  
  $path = &Cwd::abs_path ($file);
  return unless -f $path;

  $objects {$path} = { "object" => $object,
                       "name"   => $name,
                       "signal" => $signal};
  $fm->monitor ($path);
}

sub monitor_files
{
  my ($files, $object, $name, $signal) = @_;
  my ($f);

  return if (!$has_gamin);

  if (ref $files eq "ARRAY")
  {
    foreach $f (@$files)
    {
      &add_file ($f, $object, $name, $signal);
    }
  }
  else
  {
    &add_file ($files, $object, $name, $signal);
  }
}

sub init_file_monitor
{
  return if (!$has_gamin);

  # should not use internal stuff in $fm like that
  Net::DBus::Reactor->main->add_read ($fm->{conn}->fd (),
                                      Net::DBus::Callback->new(method => \&Utils::Monitor::do_monitor_files));
}

1;
