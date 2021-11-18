#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
# Users account manager. Designed to be architecture and distribution independent.
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>,
#          Arturo Espinosa <arturo@ximian.com>,
#          Tambet Ingo <tambet@ximian.com>.
#          Grzegorz Golawski <grzegol@pld-linux.org> (PLD Support),
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

# Best viewed with 100 columns of width.

# Configuration files affected:
#
# /etc/passwd
# /etc/group
# /etc/shadow
# /etc/login.defs
# /etc/shells
# /etc/skel/

# NIS support will come later.

# Running programs affected/used:
#
# adduser: creating users.
# usermod: modifying user data.
# passwd: assigning or changing passwords. (Un)locking users.
# chfn: modifying finger information - Name, Office, Office phone, Home phone.
# pw: modifying users/groups and user/group data on FreeBSD.

package Users::Users;

use Utils::Util;
use Utils::Report;
use Utils::File;
use Utils::Backend;
use Utils::Replace;

# --- System config file locations --- #

# We list each config file type with as many alternate locations as possible.
# They are tried in array order. First found = used.
@passwd_names =     ( "/etc/passwd" );
@shadow_names =     ( "/etc/shadow", "/etc/master.passwd" );
@login_defs_names = ( "/etc/login.defs", "/etc/adduser.conf" );
@shell_names =      ( "/etc/shells" );
@skel_dir =         ( "/usr/share/skel", "/etc/skel" );

# Where are the tools?
$cmd_usermod  = &Utils::File::locate_tool ("usermod");
$cmd_userdel  = &Utils::File::locate_tool ("userdel");
$cmd_useradd  = &Utils::File::locate_tool ("useradd");

$cmd_adduser  = &Utils::File::locate_tool ("adduser");
$cmd_deluser  = &Utils::File::locate_tool ("deluser");

$cmd_chfn     = &Utils::File::locate_tool ("chfn");
$cmd_pw       = &Utils::File::locate_tool ("pw");

$cmd_passwd   = &Utils::File::locate_tool ("passwd");
$cmd_chpasswd = &Utils::File::locate_tool ("chpasswd");

# enum like for verbose group array positions
my $i = 0;
my $LOGIN         = $i++;
my $PASSWD        = $i++;
my $UID           = $i++;
my $GID           = $i++;
my $COMMENT       = $i++;
my $HOME          = $i++;
my $SHELL         = $i++;
my $PASSWD_STATUS = $i++;
my $ENC_HOME      = $i++;
my $HOME_FLAGS    = $i++;
my $LOCALE        = $i++;
my $LOCATION      = $i++;
my $FACE          = $i++;

%login_defs_prop_map = ();
%profiles_prop_map = ();

sub get_login_defs_prop_array
{
  my @prop_array;
  my @login_defs_prop_array_default =
    (
     "QMAIL_DIR",      "qmail_dir",
     "MAIL_DIR",       "mailbox_dir",
     "MAIL_FILE",      "mailbox_file",
     "PASS_MAX_DAYS",  "pwd_maxdays",
     "PASS_MIN_DAYS",  "pwd_mindays",
     "PASS_MIN_LEN",   "pwd_min_length",
     "PASS_WARN_AGE",  "pwd_warndays",
     "UID_MIN",        "umin",
     "UID_MAX",        "umax",
     "GID_MIN",        "gmin",
     "GID_MAX",        "gmax",
     "USERDEL_CMD",    "del_user_additional_command",
     "CREATE_HOME",    "create_home",
     "", "");

  my @login_defs_prop_array_suse =
    (
     "QMAIL_DIR",      "qmail_dir",
     "MAIL_DIR",       "mailbox_dir",
     "MAIL_FILE",      "mailbox_file",
     "PASS_MAX_DAYS",  "pwd_maxdays",
     "PASS_MIN_DAYS",  "pwd_mindays",
     "PASS_MIN_LEN",   "pwd_min_length",
     "PASS_WARN_AGE",  "pwd_warndays",
     "UID_MIN",        "umin",
     "UID_MAX",        "umax",
     "SYSTEM_GID_MIN", "gmin",
     "GID_MAX",        "gmax",
     "USERDEL_CMD",    "del_user_additional_command",
     "CREATE_HOME",    "create_home",
     "", "");

  if ($Utils::Backend::tool{"platform"} =~ /^suse/)
  {
    @prop_array = @login_defs_prop_array_suse;
  }
  else
  {
    @prop_array = @login_defs_prop_array_default;
  }

  for ($i = 0; $prop_array [$i] ne ""; $i += 2)
  {
    $login_defs_prop_map {$prop_array [$i]}     = $prop_array [$i + 1];
    $login_defs_prop_map {$prop_array [$i + 1]} = $prop_array [$i];
  }
}

sub get_profiles_prop_array
{
  my @prop_array;
  my @profiles_prop_array_default =
    (
     "NAME" ,          "name",
     "COMMENT",        "comment",
     "LOGINDEFS",      "login_defs",
     "HOME_PREFFIX",   "home_prefix",
     "SHELL",          "shell",
     "GROUP",          "group",
     "SKEL_DIR",       "skel_dir",
     "QMAIL_DIR" ,     "qmail_dir",
     "MAIL_DIR" ,      "mailbox_dir",
     "MAIL_FILE" ,     "mailbox_file",
     "PASS_RANDOM",    "pwd_random",
     "PASS_MAX_DAYS" , "pwd_maxdays",
     "PASS_MIN_DAYS" , "pwd_mindays",
     "PASS_MIN_LEN" ,  "pwd_min_length",
     "PASS_WARN_AGE" , "pwd_warndays",
     "UID_MIN" ,       "umin",
     "UID_MAX" ,       "umax",
     "GID_MIN" ,       "gmin",
     "GID_MAX" ,       "gmax",
     "USERDEL_CMD" ,   "del_user_additional_command",
     "CREATE_HOME" ,   "create_home",
     "", "");

  my @profiles_prop_array_suse =
    (
     "NAME" ,          "name",
     "COMMENT",        "comment",
     "LOGINDEFS",      "login_defs",
     "HOME_PREFFIX",   "home_prefix",
     "SHELL",          "shell",
     "GROUP",          "group",
     "SKEL_DIR",       "skel_dir",
     "QMAIL_DIR" ,     "qmail_dir",
     "MAIL_DIR" ,      "mailbox_dir",
     "MAIL_FILE" ,     "mailbox_file",
     "PASS_RANDOM",    "pwd_random",
     "PASS_MAX_DAYS" , "pwd_maxdays",
     "PASS_MIN_DAYS" , "pwd_mindays",
     "PASS_MIN_LEN" ,  "pwd_min_length",
     "PASS_WARN_AGE" , "pwd_warndays",
     "UID_MIN" ,       "umin",
     "UID_MAX" ,       "umax",
     "GID_MIN" ,       "gmin",
     "GID_MAX" ,       "gmax",
     "USERDEL_CMD" ,   "del_user_additional_command",
     "CREATE_HOME" ,   "create_home",
     "", "");

  if ($Utils::Backend::tool{"platform"} =~ /suse/)
  {
    @prop_array = @profiles_prop_array_suse;
  }
  else
  {
    @prop_array = @profiles_prop_array_default;
  }

  for ($i = 0; $prop_array[$i] ne ""; $i += 2)
  {
    $profiles_prop_map {$prop_array [$i]}     = $prop_array [$i + 1];
    $profiles_prop_map {$prop_array [$i + 1]} = $prop_array [$i];
  }
}

#FIXME: do not hardcode GIDs like that
my $rh_logindefs_defaults = {
  'shell'    => '/bin/bash',
  'group'    => -1,
  'skel_dir' => '/etc/skel/',
};

my $gentoo_logindefs_defaults = {
  'shell'    => '/bin/bash',
  'group'    => 100,
  'skel_dir' => '/etc/skel/',
};

my $freebsd_logindefs_defaults = {
  'shell'    => '/bin/sh',
  'group'    => -1,
  'skel_dir' => '/etc/skel/',
};

my $logindefs_dist_map = {
  'redhat-6.2'      => $rh_logindefs_defaults,
  'redhat-7.0'      => $rh_logindefs_defaults,
  'redhat-7.1'      => $rh_logindefs_defaults,
  'redhat-7.2'      => $rh_logindefs_defaults,
  'redhat-7.3'      => $rh_logindefs_defaults,
  'redhat-8.0'      => $rh_logindefs_defaults,
  'mandrake-9.0'    => $rh_logindefs_defaults,
  'pld-1.0'         => $rh_logindefs_defaults,
  'fedora-1'        => $rh_logindefs_defaults,
  'debian'          => $rh_logindefs_defaults,
  'vine-3.0'        => $rh_logindefs_defaults,
  'gentoo'	        => $gentoo_logindefs_defaults,
  'archlinux'       => $gentoo_logindefs_defaults,
  'slackware-9.1.0' => $gentoo_logindefs_defaults,
  'slackware-14.0'  => $gentoo_logindefs_defaults,
  'slackware-14.1'  => $gentoo_logindefs_defaults,
  'freebsd-5'       => $freebsd_logindefs_defaults,
  'suse-9.0'        => $gentoo_logindefs_defaults,
  'solaris-2.11'    => $gentoo_logindefs_defaults,
};


# Add reporting table.

&Utils::Report::add ({
  'users_read_profiledb_success' => ['info', 'Profiles read successfully.'],
  'users_read_profiledb_fail'    => ['warn', 'Profiles read failed.'],
  'users_read_users_success'     => ['info', 'Users read successfully.'],
  'users_read_users_fail'        => ['warn', 'Users read failed.'],
  'users_read_users_invalid'     => ['warn', 'Invalid user found while reading (missing fields).'],
  'users_read_groups_success'    => ['info', 'Groups read successfully.'],
  'users_read_groups_fail'       => ['warn', 'Groups read failed.'],
  'users_read_shells_success'    => ['info', 'Shells read successfully.'],
  'users_read_shells_fail'       => ['warn', 'Reading shells failed.'],

  'users_write_profiledb_success' => ['info', 'Profiles written successfully.'],
  'users_write_profiledb_fail'    => ['warn', 'Writing profiles failed.'],
  'users_write_users_success'     => ['info', 'Users written successfully.'],
  'users_write_users_fail'        => ['warn', 'Writing users failed.'],
  'users_write_groups_success'    => ['info', 'Groups written successfully.'],
  'users_write_groups_fail'       => ['warn', 'Writing groups failed.'],
});

sub logindefs_add_defaults
{
  # Common for all distros
  my $logindefs = {
    'home_prefix' => '/home/',
  };

  &get_profiles_prop_array ();

  # Distro specific
  my $dist_specific = $logindefs_dist_map->{$Utils::Backend::tool{"platform"}};

  # Just to be 100% sure SOMETHING gets filled:
  unless ($dist_specific)
  {
    $dist_specific = $rh_logindefs_defaults;
  }

  foreach my $key (keys %$dist_specific)
  {
    # Make sure there's no crappy entries
    if (exists ($profiles_prop_map{$key}) || $key eq "groups")
    {
      $logindefs->{$key} = $dist_specific->{$key};
    }
  }
  return $logindefs;
}

sub get_logindefs
{
  my $logindefs;

  &get_login_defs_prop_array ();
  $logindefs = &logindefs_add_defaults ();

  # Get new data in case someone has changed login_defs manually.
  my $fh = &Utils::File::open_read_from_names (@login_defs_names);

  if ($fh)
  {
    while (<$fh>)
    {
      next if &Utils::Util::ignore_line ($_);
      chomp;
      my @line = split /[ \t]+/;

      if (exists $login_defs_prop_map{$line[0]})
      {
        $logindefs->{$login_defs_prop_map{$line[0]}} = $line[1];
      }
    }

    close $fh;
  }
  else
  {
    # Put safe defaults for distros/OS that don't have any defaults file
    $logindefs->{"umin"} = '1000';
    $logindefs->{"umax"} = '60000';
    $logindefs->{"gmin"} = '1000';
    $logindefs->{"gmax"} = '60000';
  }

  return $logindefs;
}

sub get
{
  my ($ifh, @users, %users_hash, $fd, @passwd_status);
  my (@line, @users);

  # Find the passwd file.
  $ifh = &Utils::File::open_read_from_names(@passwd_names);
  return unless ($ifh);

  while (<$ifh>)
  {
    chomp;
    # FreeBSD allows comments in the passwd file.
    next if &Utils::Util::ignore_line ($_);

    @line  = split ':', $_, -1;
    $login = $line[$LOGIN];

    # skip invalid users, else they will create troubles
    if (($line[$LOGIN] eq "") || ($line[$UID] eq ""))
    {
      &Utils::Report::do_report ("users_read_users_invalid");
      next;
    }

    @comment = split ',', $line[$COMMENT], 5;

    # we need to make sure that there are 5 elements
    push @comment, "" while (scalar (@comment) < 5);
    $line[$COMMENT] = [@comment];

    # always return empty string - anyway, passwd should be in /etc/shadow
    $line[$PASSWD] = "";

    $users_hash{$login} = [@line];

    # Detect lock status of password
    # We run 'passwd' instead of reading /etc/shadow directly
    # to avoid leaving sensitive data in memory (hard to clear in perl)
    $fd = &Utils::File::run_pipe_read ("passwd -S $login");
    @passwd_status = split ' ', <$fd>;
    &Utils::File::close_file ($fd);

    if ($passwd_status[1] eq "P")
    {
      $users_hash{$login}[$PASSWD_STATUS] = 0;
    }
    elsif ($passwd_status[1] eq "NP")
    {
      $users_hash{$login}[$PASSWD_STATUS] = 1;
    }
    else # "L", means locked password
    {
      $users_hash{$login}[$PASSWD_STATUS] = 1 << 1;
    }

    # max value for an unsigned 32 bits integer means no main group
    $users_hash{$login}[$GID] = 0xFFFFFFFF if (!$users_hash{$login}[$GID]);

    # TODO: read actual values
    $users_hash{$login}[$ENC_HOME] = 0;
    $users_hash{$login}[$HOME_FLAGS] = 0;
    $users_hash{$login}[$LOCALE] = "";
    $users_hash{$login}[$LOCATION] = "";
    $users_hash{$login}[$FACE] = "";
  }

  &Utils::File::close_file ($ifh);

  # transform the hash into an array
  foreach $login (keys %users_hash)
  {
    push @users, $users_hash{$login};
  }

  return \@users;
}

sub del_user
{
  my ($user) = @_;
  my (@command, $remove_home);
  
  $remove_home = $$user[$HOME_FLAGS] & 1;
	
  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    if ($remove_home)
      {
        @command = ($cmd_pw, "userdel", "-r", "-n", $$user[$LOGIN]);
      }
    else
      {
        @command = ($cmd_pw, "userdel", "-n", $$user[$LOGIN]);
      }
  }
  elsif ($cmd_deluser) # use deluser (preferred method)
    {
      if ($remove_home)
      {
        @command = ($cmd_deluser, "--remove-home", $$user[$LOGIN]);
      }
      else
      {
        @command = ($cmd_deluser, $$user[$LOGIN]);
      }
    }
  else # use userdel
    {
      if ($remove_home)
      {
        @command = ($cmd_userdel, "--remove", $$user[$LOGIN]);
      }
      else
      {
        @command = ($cmd_userdel, $$user[$LOGIN]);
      }
  }

  &Utils::File::run (@command);
}

sub change_user_chfn
{
  my ($login, $old_comment, $comment) = @_;
  my ($fname, $office, $office_phone, $home_phone);
  my (@command, $str);

  return if !$login;

  # Compare old and new data
  return if (Utils::Util::struct_eq ($old_comment, $comment));
  $str = join (",", @$comment);

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    @command = ($cmd_pw, "usermod", "-n", $login,
                                    "-c", $str);
  }
  else
  {
    @command = ($cmd_usermod, "-c", $str, $login);
  }

  &Utils::File::run (@command);
}

sub set_passwd
{
  my ($login, $password, $passwd_status) = @_;
  my ($pwdpipe);

  # handle empty password via passwd, as all tools don't support it
  if ($passwd_status & 1)
  {
    &Utils::File::run ("passwd", "-d", $login);
    return;
  }

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    my ($command);
    $command = "$cmd_pw usermod \'$login\' -h 0";
    $pwdpipe = &Utils::File::run_pipe_write ($command);
    print $pwdpipe $password;
    &Utils::File::close_file ($pwdpipe);
  }
  elsif ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    my ($command);
    $command = "$cmd_passwd --stdin \'$login\'";
    $pwdpipe = &Utils::File::run_pipe_write ($command);
    print $pwdpipe $password;
    &Utils::File::close_file ($pwdpipe);
  }
  else
  {
    $pwdpipe = &Utils::File::run_pipe_write ($cmd_chpasswd);
    print $pwdpipe "$login:$password";
    &Utils::File::close_file ($pwdpipe);
  }
}

# Enable/disable password, only call if value has changed
sub set_lock
{
  my ($login, $passwd_status) = @_;
  my ($pwdpipe);

  if ($passwd_status & (1 << 1))
  {
    &Utils::File::run ("passwd", "-l", $login);
  }
  else
  {
    &Utils::File::run ("passwd", "-u", $login);
  }
}

# This function allows empty values to be passed, in which cas
# the platform's tools will choose the default.
sub add_user
{
  my ($user) = @_;
  my ($tool_mkdir, $chown_home, $real_uid, $real_gid);
  
  $tool_mkdir = &Utils::File::locate_tool ("mkdir");

  # If directory is specified, ensure its parents exist.
  # When using default prefix, we assume the directory exists.
  if ($$user[$HOME])
  {
    my $home_parents, $erase_home;

    $home_parents = $$user[$HOME];
    $home_parents =~ s/\/+[^\/]+\/*$//;
    &Utils::File::run ($tool_mkdir, "-p", $home_parents);

    $erase_home = $$user[$HOME_FLAGS] & (1 << 3);

    # Remove home if asked, it will be created from scratch by platform tools
    if ($erase_home && -e $$user[$HOME] && $$user[$HOME] ne "/")
    {
      # Remove trailing slash(es) to avoid issues with rm on symlinks
      $$user[$HOME] =~ s|/*$||;

      @command = ("rm", "-Rf", $$user[$HOME]);
      &Utils::File::run (@command);
    }
  }

  # max value means default UID or GID here
  $real_uid = ($$user[$UID] != 0xFFFFFFFF);
  $real_gid = ($$user[$GID] != 0xFFFFFFFF);

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    my $logindefs;

    # FreeBSD doesn't create the home directory
    if (!$$user[$HOME])
    {
      $logindefs = &get_logindefs ();
      $$user[$HOME] = "$$logindefs{'home_prefix'}/$$user[$LOGIN]";
    }
    &Utils::File::run ($tool_mkdir, "-p", $$user[$HOME]);

    @command = ($cmd_pw, "useradd", "-n", $$user[$LOGIN],
                                    "-h", "-"); # disable login until password is set

    push (@command, ("-s", $$user[$HOME])) if ($$user[$HOME]);
    push (@command, ("-s", $$user[$SHELL])) if ($$user[$SHELL]);
    push (@command, ("-u", $$user[$UID])) if ($real_uid);
    push (@command, ("-g", $$user[$GID])) if ($real_gid);

    &Utils::File::run (@command);
  }
  elsif ($Utils::Backend::tool{"system"} eq "SunOS")
  {
    @command = ($cmd_useradd);

    push (@command, ("-d", $$user[$HOME])) if ($$user[$HOME]);
    push (@command, ("-s", $$user[$SHELL])) if ($$user[$SHELL]);
    push (@command, ("-u", $$user[$UID])) if ($real_uid);
    push (@command, ("-g", $$user[$GID])) if ($real_gid);
    push (@command, $$user[$LOGIN]);

    &Utils::File::run (@command);
  }
  else
  {
    if ($cmd_adduser &&
        $Utils::Backend::tool{"platform"} !~ /^slackware/ &&
        $Utils::Backend::tool{"platform"} !~ /^archlinux/ &&
        $Utils::Backend::tool{"platform"} !~ /^redhat/ &&
        $Utils::Backend::tool{"platform"} !~ /^gentoo/)
    {
      # use adduser if available and valid (slackware one is b0rk)
      # set empty gecos fields and password, they will be filled out later
      @command = ($cmd_adduser, "--gecos", "",
                                "--disabled-password");

      push (@command, ("--home", $$user[$HOME])) if ($$user[$HOME]);
      push (@command, ("--shell", $$user[$SHELL])) if ($$user[$SHELL]);
      push (@command, ("--uid", $$user[$UID])) if ($real_uid);
      push (@command, ("--gid", $$user[$GID])) if ($real_gid);

      # Allow encrypted home if the tool is present
      if ($$user[$ENC_HOME] && &Utils::File::locate_tool ("mount.ecryptfs"))
      {
        push (@command, "--encrypt-home");
      }

      push (@command, $$user[$LOGIN]);

      &Utils::File::run (@command);
    }
    else
    {
      # fallback to useradd
      @command = ($cmd_useradd, "-m");

      push (@command, ("-d", $$user[$HOME])) if ($$user[$HOME]);
      push (@command, ("-s", $$user[$SHELL])) if ($$user[$SHELL]);
      push (@command, ("-u", $$user[$UID])) if ($real_uid);
      push (@command, ("-g", $$user[$GID])) if ($real_gid);
      push (@command, $$user[$LOGIN]);

      &Utils::File::run (@command);
    }
  }

  &change_user_chfn ($$user[$LOGIN], undef, $$user[$COMMENT]);
  &set_passwd ($$user[$LOGIN], $$user[$PASSWD], $$user[$PASSWD_STATUS]);
  &set_lock ($$user[$LOGIN], $$user[$PASSWD_STATUS]);

  $chown_home = $$user[$HOME_FLAGS] & (1 << 1);

  # update user to get values that were filled
  $user = &get_user ($$user[$LOGIN]);

  # ensure user owns its home dir if asked
  if ($chown_home && $$user[$HOME] ne "/")
  {
    @command = ("chown", "-R", "$$user[$LOGIN]:$$user[$GID]", $$user[$HOME]);
    &Utils::File::run (@command);
  }

  # Return the new user with default values filled.
  # Returns NULL if user doesn't exist, which means failure.
  return $user;
}

sub change_user
{
  my ($old_user, $new_user) = @_;
  my $chown_home, $move_home, $copy_home, $erase_home;

  if ($Utils::Backend::tool{"system"} eq "FreeBSD")
  {
    @command = ($cmd_pw, "usermod", $$old_user[$LOGIN],
                         "-l", $$new_user[$LOGIN],
                         "-u", $$new_user[$UID],
                         "-d", $$new_user[$HOME],
                         "-g", $$new_user[$GID],
                         "-s", $$new_user[$SHELL]);

    &Utils::File::run (@command);
  }
  else
  {
    @command = ($cmd_usermod, "-d", $$new_user[$HOME],
                              "-g", $$new_user[$GID],
                              "-l", $$new_user[$LOGIN],
                              "-s", $$new_user[$SHELL],
                              "-u", $$new_user[$UID],
                                    $$old_user[$LOGIN]);

    &Utils::File::run (@command);
  }

  &change_user_chfn ($$new_user[$LOGIN], $$old_user[$COMMENT], $$new_user[$COMMENT]);
  &set_passwd ($$new_user[$LOGIN], $$new_user[$PASSWD], $$user[$PASSWD_STATUS]);

  # Only change lock status if status has changed
  if (($$new_user[$PASSWD_STATUS] & (1 << 1)) != ($$old_user[$PASSWD_STATUS] & (1 << 1)))
  {
    &set_lock ($$new_user[$LOGIN], $$new_user[$PASSWD_STATUS]);
  }


  # Home directory handling
  if ($$new_user[$HOME] ne $$old_user[$HOME])
  {
    # remove old home dir
    $remove_home = $$new_user[$HOME_FLAGS] & (1 << 0);
    # ensure user owns home dir
    $chown_home  = $$new_user[$HOME_FLAGS] & (1 << 1);
    # copy old home files to new dir
    $copy_home   = $$new_user[$HOME_FLAGS] & (1 << 2);
    # remove files present in path to new home
    $erase_home  = $$new_user[$HOME_FLAGS] & (1 << 3);

    # Remove trailing slash(es) to avoid issues with rm on symlinks
    # '/' becomes empty, which is easier to check for security below
    $$new_user[$HOME] =~ s|/*$||;
    $$old_user[$HOME] =~ s|/*$||;

    if ($erase_home && $$new_user[$HOME] && -e $$new_user[$HOME])
    {
      @command = ("rm", "-Rf", $$new_user[$HOME]);
      &Utils::File::run (@command);
    }

    if ($copy_home && $$new_user[$HOME] && $$old_user[$HOME])
    {
      # Remove new directory if present, to avoid troubles when merging.
      # GUIs should ask the user before passing this flag anyway!
      if (-e $$new_user[$HOME])
      {
        @command = ("rm", "-Rf", $$new_user[$HOME]);
        &Utils::File::run (@command);
      }

      if (-e $$old_user[$HOME])
      {
        if ($remove_home)
        {
          @command = ("mv", "-f", $$old_user[$HOME], $$new_user[$HOME]);
        }
        else
        {
          if ($Utils::Backend::tool{"system"} eq "SunOS")
          {
            @command = ("cp", "-RPpf", $$old_user[$HOME], $$new_user[$HOME]);
          }
          else
          {
            @command = ("cp", "-af", $$old_user[$HOME], $$new_user[$HOME]);
          }
        }
        &Utils::File::run (@command);
      }
    }
    elsif ($remove_home && $$old_user[$HOME] && -e $$old_user[$HOME] )
    {
      @command = ("rm", "-Rf", $$old_user[$HOME]);
      &Utils::File::run (@command);
    }

    # Create home directory owned by user if not present
    # If a file with this name exists, skip
    if (!-e $$new_user[$HOME] && $$new_user[$HOME])
    {
      @command = ("mkdir", "-p", $$new_user[$HOME]);
      &Utils::File::run (@command) if (!-d $$new_user[$HOME]);

      @command = ("chown", "-f", "$$new_user[$LOGIN]:$$new_user[$GID]", $$new_user[$HOME]);
      &Utils::File::run (@command);
    }
    elsif ($chown_home && $$new_user[$HOME])
    {
      @command = ("chown", "-Rf", "$$new_user[$LOGIN]:$$new_user[$GID]", $$new_user[$HOME]);
      &Utils::File::run (@command);
    }
  }

  # Erase password string to avoid it from staying in memory
  $$new_user[$PASSWD] = '0' x length ($$new_user[$PASSWD]);
}

sub set_logindefs
{
  my ($config) = @_;
  my ($logindefs, $key, $file);

  return unless $config;

  &get_login_defs_prop_array ();

  foreach $key (@login_defs_names)
  {
    if (-f $key)
    {
      $file = $key;
      last;
    }
  }

  unless ($file) 
  {
    &Utils::Report::do_report ("file_open_read_failed", join (", ", @login_defs_names));
    return;
  }

  foreach $key (keys (%$config))
  {
    # Write ONLY login.defs values.
    if (exists ($login_defs_prop_map{$key}))
    {
      &Utils::Replace::split ($file, $login_defs_prop_map{$key}, "[ \t]+", $$config{$key});
    }
  }
}

sub get_self
{
  my ($uid) = @_;
  my ($users) = &get ();

  foreach $user (@$users)
  {
    next if ($uid != $$user[$UID]);
    return ($$user[$COMMENT], $$user[$LOCALE]);
  }

  return ([""], "");
}

sub get_user
{
  my ($login) = @_;
  my ($users) = &get ();

  foreach $user (@$users)
  {
    next if ($login ne $$user[$LOGIN]);
    return $user;
  }

  return NULL;
}

sub set_user
{
  my ($new_user) = @_;
  my ($users) = &get ();

  # Make backups manually, otherwise they don't get backed up.
  &Utils::File::do_backup ($_) foreach (@passwd_names);
  &Utils::File::do_backup ($_) foreach (@shadow_names);

  foreach $user (@$users)
  {
    if ($$new_user[$LOGIN] eq $$user[$LOGIN])
    {
      &change_user ($user, $new_user);
      return;
    }
  }
}

sub set_self
{
  my ($uid, @comments, $locale, $location) = @_;
  my ($users) = &get ();

  # Make backups manually, otherwise they don't get backed up.
  &Utils::File::do_backup ($_) foreach (@passwd_names);
  &Utils::File::do_backup ($_) foreach (@shadow_names);

  foreach $user (@$users)
  {
    if ($uid == $$user[$UID])
    {
      &change_user_chfn ($$user[$LOGIN], $$user[$COMMENT], @comments);
      return;
    }
  }
  # TODO: change locale and location
}


sub get_files
{
  my ($arr);

  push @$arr, @passwd_names;
  push @$arr, @shadow_names;

  return $arr;
}

1;
