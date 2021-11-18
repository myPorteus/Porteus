#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>,
#          Arturo Espinosa <arturo@ximian.com>,
#          Tambet Ingo <tambet@ximian.com>.
#          Grzegorz Golawski <grzegol@pld-linux.org> (PLD Support)
#
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

package Users::Groups;

# enum like for verbose group array positions
my $i = 0;
my $LOGIN  = $i++;
my $PASSWD = $i++;
my $GID    = $i++;
my $USERS  = $i++;

# quite generic data
$group_names = "/etc/group";

# Where are the tools?
$cmd_groupdel = &Utils::File::locate_tool ("groupdel");
$cmd_groupadd = &Utils::File::locate_tool ("groupadd");
$cmd_groupmod = &Utils::File::locate_tool ("groupmod");

$cmd_delgroup = &Utils::File::locate_tool ("delgroup");
$cmd_addgroup = &Utils::File::locate_tool ("addgroup");

$cmd_usermod  = &Utils::File::locate_tool ("usermod");
$cmd_gpasswd  = &Utils::File::locate_tool ("gpasswd");	
$cmd_pw       = &Utils::File::locate_tool ("pw");

sub del_group
{
  my ($group) = @_;

  # Make backups manually, otherwise they don't get backed up.
  &Utils::File::do_backup ($group_names);

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    @command = ($cmd_pw, "groupdel", "-n", $$group[$LOGIN]);
  }
  else
  {
    @command  = (($cmd_delgroup) ? $cmd_delgroup : $cmd_groupdel,
                 $$group[$LOGIN]);
  }

  &Utils::File::run (@command);
}

# This is only for Linux and SunOS,
# pw groupadd manages this in FreeBSD
sub add_user_to_group
{
  my ($group, $user) = @_;
  my (@command);

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    my ($groups, @arr);

    $groups = &Utils::File::run_backtick ("groups $user");
    $groups =~ s/.*://;
    chomp ($groups);

    @arr = split (/ /, $groups);
    push @arr, $group;
    $groups = join (',', @arr);
    $groups =~ s/^,//;
    $groups =~ s/,$//;

    @command = ($cmd_usermod, "-G", $groups, $user);
  }
  else
  {
    @command = ($cmd_gpasswd, "-a", $user, $group);
  }

  &Utils::File::run (@command);
}

# This is only for Linux and SunOS,
# pw groupdel manages this in FreeBSD
sub delete_user_from_group
{
  my ($group, $user) = @_;
  my (@command);

  if ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    my ($groups, @groups_arr);

    $groups = &Utils::File::run_backtick ("groups $user");
    $groups =~ s/.*://;
    chomp ($groups);

    # delete the user
    $groups =~ s/[ \t]+$group//;

    @groups_arr = split (/ /, $groups);
    
    @command = ($cmd_usermod, "-G", @groups_arr, $user);
  }
  else
  {
    @command = ($cmd_gpasswd, "-d", $user, $group);
  }

  &Utils::File::run (@command);
}

sub add_group
{
  my ($group) = @_;
  my ($u, $user, @users);

  # Make backups manually, otherwise they don't get backed up.
  &Utils::File::do_backup ($group_names);

  $u = $$group[$USERS];

  # max value means default UID or GID here
  $real_gid = ($$group[$GID] != 0xFFFFFFFF);

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    @users = sort @$u;


    @command = ($cmd_pw, "groupadd", "-n", $$group[$LOGIN],
                                     "-M", @users);

    push (@command, ("-g", $$group[$GID])) if $real_gid;

    &Utils::File::run (@command);
  }
  else
  {
    if ($cmd_addgroup)
    {
      @command = ($cmd_addgroup, $$group[$LOGIN]);
      push (@command, ("--gid", $$group[$GID])) if $real_gid;
    }
    else
    {
      @command = ($cmd_groupadd, $$group[$LOGIN]);
      push (@command, ("-g", $$group[$GID])) if $real_gid;
    }

    &Utils::File::run (@command);

    foreach $user (sort @$u)
    {
      &add_user_to_group ($$group[$LOGIN], $user);
    }
  }
}

sub change_group
{
	my ($old_group, $new_group) = @_;
  my (%users, %user, $users_arr, $str);

	my ($n, $o, $users, $i, $j, $max_n, $max_o, $r, @tmp); # for iterations

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    if (($$old_group[$GID] != $$new_group[$GID]) || ($$old_group[$LOGIN] ne $$new_group[$LOGIN])
        || !Utils::Util::struct_eq ($$new_group[$USERS], $$old_group[$USERS]))
    {
      $users_arr = $$new_group[$USERS];
      $str = join (",", sort @$users_arr);

      @command = ($cmd_pw, "groupmod", "-n", $$old_group[$LOGIN],
                                       "-g", $$new_group[$GID],
                                       "-l", $$new_group[$LOGIN],
                                       "-M", $str);

      &Utils::File::run (@command);
    }
  }
  else
  {
    if (($$old_group[$GID] != $$new_group[$GID]) || ($$old_group[$LOGIN] ne $$new_group[$LOGIN]))
    {
      @command = ($cmd_groupmod, "-g", $$new_group[$GID],
                                 "-n", $$new_group[$LOGIN],
                                       $$old_group[$LOGIN]);
  
      &Utils::File::run (@command);
    }

    # Let's see if the users that compose the group have changed.
    if (!Utils::Util::struct_eq ($$new_group[$USERS], $$old_group[$USERS]))
    {
      $users{$_} |= 1 foreach (@{$$new_group[$USERS]});
      $users{$_} |= 2 foreach (@{$$old_group[$USERS]});

      foreach $user (keys %users)
      {
        $state = $users{$user};

        if ($state == 2)
        {
          # users with state 2 are those that only appeared
          # in the old group configuration, so we must delete them
          &delete_user_from_group ($$new_group [$LOGIN], $user);
        }
        elsif ($state == 1)
        {
          # users with state 1 are those who were added
          # to the new group configuration
          &add_user_to_group ($$new_group[$LOGIN], $user);
        }
      }
    }
  }
}

sub get_group
{
  my ($login) = @_;
  my ($groups) = &get ();

  foreach $group (@$groups)
  {
    next if ($login != $$group[$LOGIN]);
    return $group;
  }

  return NULL;
}

sub set_group
{
  my ($new_group) = @_;
  my ($groups) = &get ();

  # Make backups manually, otherwise they don't get backed up.
  &Utils::File::do_backup ($group_names);

  foreach $group (@$groups)
  {
    if ($$new_group[$LOGIN] eq $$group[$LOGIN])
    {
      &change_group ($group, $new_group);
      return;
    }
  }
}

sub get
{
  my ($ifh, @groups, $group_last_modified);
  my (@line, $copy, @a);

  $ifh = &Utils::File::open_read_from_names($group_names);
  return unless ($ifh);

  # Parse the file.
  @groups = ();

  while (<$ifh>)
  {
    chomp;

    # FreeBSD allows comments in the group file. */
    next if &Utils::Util::ignore_line ($_);

    @line = split ':', $_, 4;
    @a = split ',', pop @line;
    push @line, [@a];
    $copy = [@line];
    push (@groups, $copy);
  }

  &Utils::File::close_file ($ifh);

  return \@groups;
}

sub get_files
{
  my @arr;

  push @arr, $group_names;
  return \@arr;
}

sub set
{
  my ($config) = @_;
  my ($groups) = &get ();
  my ($new_group, $group);

  return if (!$config);


  # Make backups manually, otherwise they don't get backed up.
  &Utils::File::do_backup ($group_names);

  # Change groups that are present in both old and new config.
  # Groups won't be removed or added this way, for more safety.
  foreach $new_group (@$config)
  {
    foreach $group (@$groups)
    {
      if ($$new_group[$LOGIN] eq $$group[$LOGIN])
      {
        &change_group ($group, $new_group);
        break;
      }
  }
  }
}

1;
