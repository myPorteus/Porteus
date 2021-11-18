#!/usr/bin/perl
#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# Functions for file manipulation. Find, open, read, write, backup, etc.
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>
#          Arturo Espinosa <arturo@ximian.com>
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

package Utils::File;

use Utils::Report;
use File::Path;
use File::Copy;
use File::Temp;
use Carp;

$FILE_READ  = 1;
$FILE_WRITE = 2;


# --- File operations --- #

sub get_base_path
{
  my $path = "/$main::localstatedir/cache/system-tools-backends";
  chmod (0755, $path);
  return $path;
}


sub get_tmp_path
{
  return (&get_base_path () . "/tmp");
}


sub get_backup_path
{
  return (&get_base_path () . "/backup");
}

# Give a command, and it will put in C locale and find
# the program to run in the path. Redirects stderr to null.
sub get_cmd_path
{
   my ($cmd) = @_;

   my ($tool_name, @argline) = split("[ \t]+", $cmd);
   my $tool_path = &locate_tool ($tool_name);
   return -1 if ($tool_path eq "");

   $command = "$tool_path @argline";
   return ("LC_ALL=C $command 2> /dev/null");
}

# necessary for some programs that output info through stderr
sub get_cmd_path_with_stderr
{
   my ($cmd) = @_;

   my $command = &get_cmd_path ($cmd);
   return ("LC_ALL=C $command 2>&1");
}


sub create_path
{
  my ($path, $perms) = @_;
  $prems = $perms || 0770;
  my @pelem;
  
  $path =~ tr/\///s;
  @pelem = split(/\//, $path); # 'a/b/c/d/' -> 'a', 'b', 'c', 'd', ''

  for ($path = ""; @pelem; shift @pelem)
  {
    $path = "$path$pelem[0]";
    mkdir($path, $perms);
    $path = "$path/";
  }

  &Utils::Report::enter ();
  &Utils::Report::do_report ("file_create_path", $_[0]);
  &Utils::Report::leave ();
}


sub create_path_for_file
{
  my ($path, $perms) = @_;
  $prems = $perms || 0770;
  my @pelem;
  
  $path =~ tr/\///s;
  @pelem = split(/\//, $path); # 'a/b/c/d/' -> 'a', 'b', 'c', 'd', ''
    
  for ($path = ""; @pelem; shift @pelem)
  {
    if ($pelem[1] ne "")
    {
      $path = "$path$pelem[0]";
      mkdir($path, $perms);
      $path = "$path/";
    }
  }

  &Utils::Report::enter ();
  &Utils::Report::do_report ("file_create_path", $_[0]);
  &Utils::Report::leave ();
}


$rotation_was_made = 0;

# If this is the first backup created by this tool on this invocation,
# rotate the backup directories and create a new, empty one.
sub rotate_backup_dirs
{
  my $backup_tool_dir = $_[0];
  
  &Utils::Report::enter ();
  
  if (!$rotation_was_made)
  {
    my $i;

    $rotation_was_made = 1;
    if (-e "$backup_tool_dir/9")
    {
      if (-s "$backup_tool_dir/9")
      {
        unlink ("$backup_tool_dir/9");
      }
      else
      {
        &rmtree ("$backup_tool_dir/9");
      }
    }

    for ($i = 8; $i; $i--)
    {
      if (stat ("$backup_tool_dir/$i"))
      {
        move ("$backup_tool_dir/$i", "$backup_tool_dir/" . ($i+1));
      }
    }

    if (!stat ("$backup_tool_dir/First"))
    {
      &create_path ("$backup_tool_dir/First");
      &run ("ln -s First $backup_tool_dir/1");
    }
    else
    {
      &create_path_for_file ("$backup_tool_dir/1/");
    }

    &Utils::Report::do_report ("file_backup_rotate", $backup_tool_dir);
  }
  
  &Utils::Report::enter ();
}

sub do_backup
{
  my $backup_file = $_[0];
  my $backup_tool_dir;

  &Utils::Report::enter ();
  
  $backup_tool_dir = &get_backup_path () . "/$gst_name/";

  &rotate_backup_dirs ($backup_tool_dir);
  
  # If the file hasn't already been backed up on this invocation, copy the
  # file to the backup directory.

  if (!stat ("$backup_tool_dir/1/$backup_file"))
  {
    &create_path_for_file ("$backup_tool_dir/1/$backup_file");
    copy ($backup_file, "$backup_tool_dir/1/$backup_file");
    &Utils::Report::do_report ("file_backup_success", $backup_tool_dir);
  }
  
  &Utils::Report::leave ();
}

# Return 1/0 depending on file existance.
sub exists
{
  my ($file) = @_;

  return (-f "$gst_prefix/$file")? 1: 0;
}

sub open_read_from_names
{
  local *FILE;
  my $fname = "";

  &Utils::Report::enter ();
  
  foreach $name (@_)
  {
    if (open (FILE, "$gst_prefix/$name"))
    {
      $fname = $name;
      last;
    }
  }
  
  (my $fullname = "$gst_prefix/$fname") =~ tr/\//\//s;  # '//' -> '/'	

  if ($fname eq "") 
  { 
    &Utils::Report::do_report ("file_open_read_failed", "@_");
    return undef;
  }

  &Utils::Report::do_report ("file_open_read_success", $fullname);
  &Utils::Report::leave ();

  return *FILE;
}


sub open_write_from_names
{
  local *FILE;
  my $name;
  my $fullname;

  &Utils::Report::enter ();
    
  # Find out where it lives.
    
  foreach $elem (@_) { if (stat($elem) ne "") { $name = $elem; last; } }
    
  if ($name eq "")
  {
    $name = $_[0];
    (my $fullname = "$gst_prefix/$name") =~ tr/\//\//s;
    &Utils::Report::do_report ("file_open_write_create", "@_", $fullname);
  }
  else
  {
    (my $fullname = "$gst_prefix/$name") =~ tr/\//\//s;
    &Utils::Report::do_report ("file_open_write_success", $fullname);
  }
    
  ($name = "$gst_prefix/$name") =~ tr/\//\//s;  # '//' -> '/' 
  &create_path_for_file ($name);
    
  # Make a backup if the file already exists - if the user specified a prefix,
  # it might not.
    
  if (stat ($name))
  {
    &do_backup ($name);
  }

  &Utils::Report::leave ();
  
  # Truncate and return filehandle.

  if (!open (FILE, ">$name"))
  {
    &Utils::Report::do_report ("file_open_write_failed",  $name);
    return undef;
  }

  return *FILE;
}

sub open_filter_write_from_names
{
  local *INFILE;
  local *OUTFILE;
  my ($filename, $name, $elem);

  &Utils::Report::enter ();

  # Find out where it lives.

  foreach $coin (@_)
  {
    if (-e $coin) { $name = $coin; last; }
  }

  if (! -e $name)
  {
    # If we couldn't locate the file, and have no prefix, give up.

    # If we have a prefix, but couldn't locate the file relative to '/',
    # take the first name in the array and let that be created in $prefix.

    if ($prefix eq "")
    {
      &Utils::Report::do_report ("file_open_filter_failed", "@_");
      return(0, 0);
    }
    else
    {
      $name = $_[0];
      (my $fullname = "$gst_prefix/$name") =~ tr/\//\//s;
      &Utils::Report::do_report ("file_open_filter_create", "@_", $fullname);
    }
  }
  else
  {
    (my $fullname = "$gst_prefix/$name") =~ tr/\//\//s;
    &Utils::Report::do_report ("file_open_filter_success", $name, $fullname);
  }

  ($filename) = $name =~ /.*\/(.+)$/;
  ($name = "$gst_prefix/$name") =~ tr/\//\//s;  # '//' -> '/' 
  &create_path_for_file ($name);

  # Make a backup if the file already exists - if the user specified a prefix,
  # it might not.

  if (-e $name)
  {
    &do_backup ($name);
  }

  # Return filehandles. Make a copy to use as filter input. It might be
  # invalid (no source file), in which case the caller should just write to
  # OUTFILE without bothering with INFILE filtering.

  my $tmp_path = &get_tmp_path ();

  &create_path ("$tmp_path");
  unlink ("$tmp_path/$gst_name-$filename");
  copy ($name, "$tmp_path/$gst_name-$filename");

  open (INFILE, "$tmp_path/$gst_name-$filename");

  if (!open (OUTFILE, ">$name"))
  {
    &Utils::Report::do_report ("file_open_filter_failed", $name);
    return (*INFILE, 0);
  }
    
  &Utils::Report::leave ();

  return (*INFILE, *OUTFILE);
}


sub open_write_compressed
{
  local *FILE;
  my ($name, $fullname, $gzip);

  $gzip = &locate_tool ("gzip");
  return undef if (!$gzip);

  &Utils::Report::enter ();
    
  # Find out where it lives.
    
  foreach $elem (@_) { if (stat($elem) ne "") { $name = $elem; last; } }
    
  if ($name eq "")
  {
    $name = $_[0];
    (my $fullname = "$gst_prefix/$name") =~ tr/\//\//s;
    &Utils::Report::do_report ("file_open_write_create", "@_", $fullname);
  }
  else
  {
    (my $fullname = "$gst_prefix/$name") =~ tr/\//\//s;
    &Utils::Report::do_report ("file_open_write_success", $fullname);
  }
    
  ($name = "$gst_prefix/$name") =~ tr/\//\//s;  # '//' -> '/' 
  &create_path_for_file ($name);
    
  # Make a backup if the file already exists - if the user specified a prefix,
  # it might not.
    
  if (stat ($name))
  {
    &do_backup ($name);
  }

  &Utils::Report::leave ();
  
  # Truncate and return filehandle.

  if (!open (FILE, "| $gzip -c > $name"))
  {
    &Utils::Report::do_report ("file_open_write_failed",  $name);
    return;
  }

  return *FILE;
}


sub run_pipe
{
  my ($cmd, $mode_mask, $stderr) = @_;
  my ($command);
  local *PIPE;

  $mode_mask = $FILE_READ if $mode_mask eq undef;

  &Utils::Report::enter ();
  
  if ($stderr)
  {
    $command = &get_cmd_path_with_stderr ($cmd);
  }
  else
  {
    $command = &get_cmd_path ($cmd);
  }

  if ($command == -1)
  {
    &Utils::Report::do_report ("file_run_pipe_failed", $command);
    &Utils::Report::leave ();
    return undef;
  }

  $command .= " |" if $mode_mask & $FILE_READ;
  $command = "| $command > /dev/null" if $mode_mask & $FILE_WRITE;

  open *PIPE, $command;
  &Utils::Report::do_report ("file_run_pipe_success", $command);
  &Utils::Report::leave ();
  return *PIPE;
}


sub run_pipe_read
{
  my ($cmd) = @_;

  return &run_pipe ($cmd, $FILE_READ);
}

sub run_pipe_read_with_stderr
{
   my ($cmd) = @_;

   return &run_pipe ($cmd, $FILE_READ, 1);
}

sub run_pipe_write
{
  my ($cmd) = @_;

  return &run_pipe ($cmd, $FILE_WRITE);
}


sub run_backtick
{
  my ($cmd, $stderr) = @_;
  my ($fd, $res);

  if ($stderr)
  {
    $fd = &run_pipe_read_with_stderr ($cmd);
  }
  else
  {
    $fd = &run_pipe_read ($cmd);
  }

  $res = join ('', <$fd>);
  &close_file ($fd);

  return $res;
}


sub close_file
{
  my ($fd) = @_;

  close $fd if (ref \$fd eq "GLOB");
}


sub remove
{
  my ($name) = @_;
  my ($file);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("file_remove", $name);

  $file = "$gst_prefix/$name";

  if (stat ($file))
  {
    &do_backup ($file);
  }

  unlink $file;
  &Utils::Report::leave ();
}

sub rmtree
{
  my($roots, $verbose, $safe) = @_;
  my(@files);
  my($count) = 0;
  $verbose ||= 0;
  $safe ||= 0;

  if ( defined($roots) && length($roots) ) {
    $roots = [$roots] unless ref $roots;
  }
  else {
    carp "No root path(s) specified\n";
    return 0;
  }

  my($root);
  foreach $root (@{$roots}) {
    $root =~ s#/\z##;
    (undef, undef, my $rp) = lstat $root or next;
    $rp &= 07777;	# don't forget setuid, setgid, sticky bits
    
    if ( -d $root ) { # $root used to be _, which is a bug.
                      # this is why we are replicating this function.
      
	    # notabene: 0777 is for making readable in the first place,
	    # it's also intended to change it to writable in case we have
	    # to recurse in which case we are better than rm -rf for 
	    # subtrees with strange permissions
	    chmod(0777, ($Is_VMS ? VMS::Filespec::fileify($root) : $root))
          or carp "Can't make directory $root read+writeable: $!"
              unless $safe;

      local *DIR;
	    if (opendir DIR, $root) {
        @files = readdir DIR;
        closedir DIR;
	    }
	    else {
        carp "Can't read $root: $!";
        @files = ();
	    }

	    # Deleting large numbers of files from VMS Files-11 filesystems
	    # is faster if done in reverse ASCIIbetical order 
	    @files = reverse @files if $Is_VMS;
	    ($root = VMS::Filespec::unixify($root)) =~ s#\.dir\z## if $Is_VMS;
	    @files = map("$root/$_", grep $_!~/^\.{1,2}\z/s,@files);
	    $count += &rmtree(\@files,$verbose,$safe);
	    if ($safe &&
          ($Is_VMS ? !&VMS::Filespec::candelete($root) : !-w $root)) {
        print "skipped $root\n" if $verbose;
        next;
	    }
	    chmod 0777, $root
          or carp "Can't make directory $root writeable: $!"
              if $force_writeable;
	    print "rmdir $root\n" if $verbose;
	    if (rmdir $root) {
        ++$count;
	    }
	    else {
        carp "Can't remove directory $root: $!";
        chmod($rp, ($Is_VMS ? VMS::Filespec::fileify($root) : $root))
            or carp("and can't restore permissions to "
                    . sprintf("0%o",$rp) . "\n");
	    }
    }
    else { 
	    if ($safe &&
          ($Is_VMS ? !&VMS::Filespec::candelete($root)
           : !(-l $root || -w $root)))
	    {
        print "skipped $root\n" if $verbose;
        next;
	    }
	    chmod 0666, $root
          or carp "Can't make file $root writeable: $!"
              if $force_writeable;
	    print "unlink $root\n" if $verbose;
	    # delete all versions under VMS
	    for (;;) {
        unless (unlink $root) {
          carp "Can't unlink file $root: $!";
          if ($force_writeable) {
            chmod $rp, $root
                or carp("and can't restore permissions to "
                        . sprintf("0%o",$rp) . "\n");
          }
          last;
        }
        ++$count;
        last unless $Is_VMS && lstat $root;
	    }
    }
  }

  $count;
}

# --- Buffer operations --- #


# Open $file and put it into @buffer, for in-line editting.
# \@buffer on success, undef on error.

sub load_buffer
{
  my ($file) = @_;
  my @buffer;
  my $fd;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("file_buffer_load", $file);

  $fd = &open_read_from_names ($file);
  return [] unless $fd;

  @buffer = (<$fd>);

  &Utils::Report::leave ();

  return \@buffer;
}

# Same with an already open fd.
sub load_buffer_from_fd
{
  my ($fd) = @_;
  my (@buffer);
  
  &Utils::Report::enter ();
  &Utils::Report::do_report ("file_buffer_load", $file);

  @buffer = (<$fd>);

  &Utils::Report::leave ();

  return \@buffer;
}

# Take a $buffer and save it in $file. -1 is error, 0 success.

sub save_buffer
{
  my ($buffer, $file) = @_;
  my ($fd, $i);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("file_buffer_save", $file);

  $fd = &open_write_from_names ($file);
  return -1 if !$fd;

  if (@$buffer < 1)
  {
    # We want to write single line.
    # Print only if $buffer is NOT a reference (it'll print ARRAY(0x412493) for example).
    print $fd $buffer if (!ref ($buffer));
  }

  else
  {
    # Let's print array
    
    foreach $i (@$buffer)
    {
      print $fd $i;
    }
  }

  &close_file ($fd);

  &Utils::Report::leave ();
  
  return 0;
}


# Erase all empty string elements from the $buffer.

sub clean_buffer
{
  my $buffer = $_[0];
  my $i;

  for ($i = 0; $i <= $#$buffer; $i++)
  {
    splice (@$buffer, $i, 1) if $$buffer[$i] eq "";
  }
}


sub join_buffer_lines
{
  my $buffer = $_[0];
  my $i;

  for ($i = 0; $i <= $#$buffer; $i++)
  {
    while ($$buffer[$i] =~ /\\$/)
    {
      chomp $$buffer[$i];
      chop $$buffer[$i];
      $$buffer[$i] .= $$buffer[$i + 1];
      splice (@$buffer, $i + 1, 1);
    }
  }
}

sub read_joined_lines
{
  my ($file) = @_;
  my ($buffer);

  $buffer = &load_buffer ($file);
  &join_buffer_lines ($buffer);

  $$buffer[0] =~ s/\n//;
  $$buffer[0] =~ s/\\//;

  return $$buffer[0];
}

# --- Command-line utilities --- #


# &run_full (<in background>, <command>, <array of arguments>)
#
# Takes a boolean indicating whether to run the program in the background,
# an array containing a command to run and the arguments to pass.
# Assumes the first word in the array is the command-line utility
# to run, and tries to locate it, replacing it with its full path. The path
# is cached in a hash, to avoid searching for it repeatedly. Output
# redirection is appended, to make the utility perfectly silent. The
# preprocessed command line is run, and its exit value is returned,
# or -1 on failure. When run in the background, 0 is returned if
# the fork did succeed, disregarding possible failure of exec().
#

sub run_full
{
  my ($background, $cmd, @arguments) = @_;
  my ($command, $tool_name, $tool_path, $pid);

  &Utils::Report::enter ();

  $tool_path = &locate_tool ($cmd);
  return -1 if ($tool_path eq "");
  return -1 if $cmd == -1;

  $command = join (" ", ($tool_path, @arguments));
  &Utils::Report::do_report ("file_run_full", $command);

  my $pid = fork();

  return -1 if (!defined $pid);

  if ($pid == 0)
  {
    $ENV{"LC_ALL"} = "C";
    open (STDOUT, "/dev/null");
    open (STDERR, "/dev/null");
    system ($tool_path, @arguments);

    # As documented in perlfunc, divide by 256.
    exit ($? / 256);
  }

  # If no error has occurred so far, assume success,
  # ignoring the future return value
  return 0 if ($background);

  waitpid ($pid, 0);

  if ($? != 0)
  {
    &Utils::Report::do_report ("file_run_full_failed", $command);
  }

  &Utils::Report::leave ();

  return ($?);
}

# Simple wrappers calling &run_full() with the right background parameter
sub run_bg
{
  return &run_full (1, @_);
}

sub run
{
  return &run_full (0, @_);
}

# &gst_file_locate_tool
#
# Tries to locate a command-line utility from a set of built-in paths
# and a set of user paths (found in the environment). The path (or a negative
# entry) is cached in a hash, to avoid searching for it repeatedly.

@gst_builtin_paths = ( "/sbin", "/usr/sbin", "/usr/local/sbin",
                       "/bin", "/usr/bin", "/usr/local/bin" );

%gst_tool_paths = ();

sub locate_tool
{
  my ($tool) = @_;
  my $found = "";
  my @user_paths;

  # We don't search absolute paths. Arturo.
  if ($tool =~ /^\//)
  {
    if (! (-x $tool))
    {
      &Utils::Report::do_report ("file_locate_tool_failed", $tool);
      return "";
    }
    
    return $tool;
  }

  &Utils::Report::enter ();
  
  $found = $gst_tool_paths{$tool};
  if ($found eq "0")
  {
    # Negative cache hit. At this point, the failure has already been reported
    # once.
    return "";
  }

  if ($found eq "")
  {
    # Nothing found in cache. Look for real.

    # Extract user paths to try.

    @user_paths = ($ENV{PATH} =~ /([^:]+):/mg);

    # Try user paths.

    foreach $path (@user_paths)
    {
      if (-x "$path/$tool" || -u "$path/$tool") { $found = "$path/$tool"; last; }
    }

    if (!$found)
    {
      # Try builtin paths.
      foreach $path (@gst_builtin_paths)
      {
        if (-x "$path/$tool" || -u "$path/$tool") { $found = "$path/$tool"; last; }
      }
    }

    # Report success/failure and update cache.

    if ($found)
    {
      $gst_tool_paths{$tool} = $found;
      &Utils::Report::do_report ("file_locate_tool_success", $tool);
    }
    else
    {
      $gst_tool_paths{$tool} = "0";
      &Utils::Report::do_report ("file_locate_tool_failed", $tool);
    }
  }
  
  &Utils::Report::leave ();
  
  return ($found);
}

sub tool_installed
{
  my ($tool) = @_;
  
  $tool = &locate_tool ($tool);
  return 0 if $tool eq "";
  return 1;
}

sub copy_file
{
  my ($orig, $dest) = @_;

  return if (!&exists ("$gst_prefix/$orig"));
  copy ("$gst_prefix/$orig", "$gst_prefix/$dest");
}

sub get_temp_name
{
  my ($prefix) = @_;

  return mktemp ($prefix);
}

sub copy_file_from_stock
{
  my ($orig, $dest) = @_;

  if (!copy ("$main::filesdir/$orig", $dest))
  {
    &Utils::Report::do_report ("file_copy_failed", "$main::filesdir/$orig", $dest);
    return -1;
  }

  return 0;
}

1;
