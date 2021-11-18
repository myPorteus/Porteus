#!/usr/bin/perl
#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# parse.pl: Common parsing stuff for the ximian-setup-tools backends.
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

package Utils::Parse;

use Utils::Util;
use Utils::File;


# The concept of keyword (kw) here is a key, normaly in its own line, whose
# boolean representation is its own existence.

# Every final parsing function to be used by a table must handle one key
# at a time, but maybe parse several values from there and return a
# ref to array or hash.
#
# Always return a scalar. If you need to return an array or a hash,
# return a ref to it.

# First some helper functions for the whole process.
# Expand substrings of the form #$substr# to the $value in
# the string or recursively in the array $strarr.

sub expand
{
  my ($strarr, @args) = @_;

  if (ref $strarr eq "ARRAY")
  {
    my ($i);
    
    $strarr = [ @$strarr ];
    foreach $i (@$strarr)
    {
      $i = &expand ($i, @args);
    }

    return $strarr;
  }

  while (@args)
  {
    $substr = shift @args;
    $value  = shift @args;

    $strarr =~ s/\#$substr\#/$value/;
  }

  return $strarr;
}

sub replace_hash_values
{
  my ($cp, $hash) = @_;
  my ($j, $replace_key, $value);

  foreach $j (@$cp)
  {
    while ($j =~ /%([^%]*)%/)
    {
      $replace_key = $1;
      if (exists $$hash{$replace_key}) 
      {
        $value = $$hash{$replace_key};
        if (ref $value)
        {
          $j = $value;
        }
        else
        {
          $j =~ s/%$replace_key%/$value/g;
        }
      }
      else
      {
        return 0;
      }
    }
  }

  return 1;
}

sub replace_files
{
  my ($values, $fn_hash) = @_;
  my @ret;

  return () if $values eq undef;
  $values = [$values] if !ref $values;

  foreach $i (@$values)
  {
    if (exists $$fn_hash{$i})
    {
      push @ret, $$fn_hash{$i};
    }
    else
    {
      push @ret, $i;
    }
  }

  return @ret;
}

# Additional abstraction: parse table entries can have
# arrays inside. The parsing proc will be ran with every
# combination that the arrays provide. Ex:
# ["user", \&get_foo, [0, 1], [2, 3] ] will parse
# using the combinatory of [0, 1]x[2, 3] until a result
# ne undef is given. Check RedHat 7.2's network parse table
# for further enlightenment.
sub run_entry
{
  my ($hash, $key, $proc, $cp) = @_;
  my ($ncp, $i, $j, $res);

  $ncp = [@$cp];
  for ($i = 0; $i < scalar (@$cp); $i ++)
  {
    if (ref $$cp[$i] eq "ARRAY")
    {
      foreach $j (@{$$cp[$i]})
      {
        $$ncp[$i] = $j;
        $res = &run_entry ($hash, $key, $proc, $ncp);
        return $res if $res ne undef;
      }
      return undef;
    }
  }

  # OK, the given entry didn't have any array refs in it...
  
  return undef if (!&replace_hash_values ($cp, $hash));

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_table", "$key");
  &Utils::Report::leave ();
  
  $$hash{$key} = &$proc (@$cp);
  return $$hash{$key};
}

# OK, this is the good stuff:

# get_from_table takes a file mapping and a parse table.
#
# The functions in the replace tables, most of which are coded in
# this file, receive the mapped files of the first argument, and then
# a set of values.

# The value the parse function returns is set into a hash,
# using as key the first item of the parse table entry. This is done
# only if the $hash{$key} is empty, which allows us to try with
# several parse methods to try to get a value, where our parse functions
# can return undef if they failed to get the requested value.
#
# A ref to the hash with all the fetched values is returned.
sub get_from_table
{
  my ($fn, $table) = @_;
  my %hash;
  my ($key, $proc, @param);
  my ($i, @cp, @files);

  foreach $i (@$table)
  {
    @cp = @$i;
    $key = shift (@cp);

    if ($hash{$key} eq undef)
    {
      $proc = shift (@cp);
      @files = &replace_files (shift (@cp), $fn);

      # Don't unshift the resulting files if none were given.
      unshift @cp, @files if (scalar @files) > 0;

      &run_entry (\%hash, $key, $proc, \@cp);
    }
  }

  foreach $i (keys (%hash))
  {
    delete $hash{$i} if ($hash{$i} eq undef);
  }
  
  return \%hash;
}

# Just return the passed values. If there's just
# one value, the value. If more, a reference to an
# array with the values.
sub get_trivial
{
  my (@res) = @_;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_trivial", "@res");
  &Utils::Report::leave ();

  return $res[0] if (scalar @res) <= 1;
  return \@res;
}

# Try to read a line from $fd and remove any leading or
# trailing white spaces. Return ref to read $line or
# -1 if eof.
sub chomp_line_std
{
  my ($fd) = @_;
  my $line;

  $line = <$fd>;
  return -1 if !$line;

  chomp $line;
  $line =~ s/^[ \t]+//;
  $line =~ s/[ \t]+$//;

  return \$line;
}

# Assuming $line is a line read from a shell file,
# remove comments.
sub process_sh_line
{
  my ($line) = @_;
  my ($pline);

  # This will put escaped hashes out of danger.
  # But only inside valid quotes!
  while ($line =~ /([^\"\']*[\"\'][^\#\"\']*)(\#?)([^\"\']*[\"\'])/g)
  {
      $pline .= $1;
      $pline .= "__hash__" if ($2 ne undef);
      $pline .= $3;
  }

  # The line may not match the regexp above,
  $pline = $line if ($pline eq undef);

  $pline =~ s/\\\#/\\__hash__/g;

  # Nuke everything after a hash and bye bye trailing spaces.
  $pline =~ s/[ \t]*\#.*//;

  # Let escaped hashes come back home.
  $pline =~ s/__hash__/\#/g;

  return $pline;
}

# Same as chomp_line_std, but apply
# the sh line processing before returning.
# -1 if eof, ref to read $line if success.
sub chomp_line_hash_comment
{
  my ($fd) = @_;
  my $line;

  $line = &chomp_line_std ($fd);
  return -1 if $line == -1;

  $line = &process_sh_line ($$line);
  return \$line;
}

# Get an sh line, and remove the export keyword, if any.
sub chomp_line_sh_export
{
  my ($fd) = @_;
  my $line;

  $line = &chomp_line_hash_comment ($fd);
  return -1 if $line == -1;

  $line = $$line;

  $line =~ s/^export //;

  return \$line;
}

# Parse a $file, wich is assumed to have a column-based format, with $re matching field separators
# and one record per line. Search for $key, and return either a scalar with the first ocurrence,
# or an array with all the found ocurrences.
sub split_ref
{
  my ($file, $key, $re, $all, $line_read_proc) = @_;
  my ($fd, @line, @res);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_split", $key, $file);

  $proc = $line_read_proc? $line_read_proc : \&chomp_line_std;
  
  $fd = &Utils::File::open_read_from_names ($file);
  $all = 0 if !$fd;

  while (($line = &$proc ($fd)) != -1)
  {
    $line = $$line;
    next if $line eq "";

    @line = split ($re, $line, 2);

    if (shift (@line) =~ "^$key\$")
    {
      if ($all) {
        push @res, $line[0];
      }
      else
      {
        &Utils::Report::leave ();
        &Utils::File::close_file ($fd);
        return \$line[0];
      }
    }
  }

  &Utils::Report::leave ();
  &Utils::File::close_file ($fd);
  return \@res if ($all);
  return -1;
}

sub split
{
  my $res;

  # Don't pass @_ like this anywhere. This is bad practice.
  $res = &split_ref (@_);

  return $$res if ref $res eq "SCALAR";
  return @$res if ref $res eq "ARRAY";
  return undef;
}

# This gives meaning to the $all flag of &split, and returns a reference to the array, which
# is what we want. (ie search a.com\nsearch b.com\nsearch c.com)
sub split_all
{
  my ($file, $key, $re, $line_read_proc) = @_;
  my @a;

  @a = &split ($file, $key, $re, 1, $line_read_proc);

  return \@a;
}

# Same, but use the hash_comment routine for line analysis.
sub split_all_hash_comment
{
  my ($file, $key, $re) = @_;

  return &split_all ($file, $key, $re, \&chomp_line_hash_comment);
}

# Make the elements of the resulting array unique.
sub split_all_unique_hash_comment
{
  my ($file, $key, $re) = @_;
  my ($arr, @res);
  my (%hash, $i);

  $arr = &split_all ($file, $key, $re, \&chomp_line_hash_comment);

  foreach $i (@$arr)
  {
    next if exists $hash{$i};
    $hash{$i} = 1;
    push @res, $i;
  }

  return \@res;
}

sub split_all_array_with_pos
{
  my ($file, $key, $pos, $re, $sep, $line_read_proc) = @_;
  my ($arr, @s, @ret, $i);

  $arr = &split_all ($file, $key, $re, $line_read_proc);

  foreach $i (@$arr)
  {
    if ($i)
    {
      @s = split ($sep, $i);
      push @ret, @s[0];
    }
  }

  return \@ret;
}

# Same, but for $all = 0. (ie nameserver 10.0.0.1)
sub split_first_str
{
  my ($file, $key, $re, $line_read_proc) = @_;

  return &split ($file, $key, $re, 0, $line_read_proc);
}

# Interpret the result as a boolean. (ie multi on)
sub split_first_bool
{
  my ($file, $key, $re, $line_read_proc) = @_;
  my $ret;

  $ret = &split_first_str ($file, $key, $re, $line_read_proc);

  return undef if ($ret eq undef);
  return (&Utils::Util::read_boolean ($ret)? 1: 0);
}

# After getting the first field, split the result with $sep matching separators. (ie order hosts,bind)
sub split_first_array
{
  my ($file, $key, $re, $sep, $line_read_proc) = @_;
  my @ret;

  @ret = split ($sep, &split ($file, $key, $re, 0, $line_read_proc));

  return \@ret;
}

sub split_first_array_pos
{
  my ($file, $key, $pos, $re, $sep, $line_read_proc) = @_;
  my (@ret);

  @ret = split ($sep, &split ($file, $key, $re, 0, $line_read_proc));
  return $ret[$pos];
}

# Do an split_first_array and then make
# the array elements unique. This is to fix broken
# searchdomain entries in /etc/resolv.conf, for example.
sub split_first_array_unique
{
  my ($file, $key, $re, $sep, $line_read_proc) = @_;
  my (@arr, @res);
  my (%hash, $i);

  @arr = split ($sep, &split ($file, $key, $re, 0, $line_read_proc));

  foreach $i (@arr)
  {
    next if exists $hash{$i};
    $hash{$i} = 1;
    push @res, $i;
  }

  return \@res;
}

# For all keys in $file, sepparated from its values
# by $key_re, sepparate its values using $value_re
# and assign to a newly created hash. Use ONLY when
# you don't know what keys you are going to parse
# (i.e. /etc/hosts). Any other application will not
# be very portable and should be avoided.
sub split_hash
{
  my ($file, $key_re, $value_re) = @_;
  my ($fd, @line, %res, $key);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_split_hash", $file);
  
  $fd = &Utils::File::open_read_from_names ($file);
  
  while (<$fd>)
  {
    chomp;
    s/^[ \t]+//;
    s/[ \t]+$//;
    s/\#.*$//;
    next if (/^$/);
    @line = split ($key_re, $_, 2);

    $key = shift (@line);
    push @{$res{$key}}, split ($value_re, $line[0]);
  }

  &Utils::File::close_file ($fd);
  &Utils::Report::leave ();
  return undef if (scalar keys (%res) == 0);
  return \%res;
}

# Same as above, but join lines that end with '\'.
sub split_hash_with_continuation
{
  my ($file, $key_re, $value_re) = @_;
  my ($fd, $l, @line, %res, $key);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_split_hash_cont", $file);
  
  $fd = &Utils::File::open_read_from_names ($file);
  
  while (($l = &ini_line_read ($fd)) != -1)
  {
    $_ = $$l;
    chomp;
    s/^[ \t]+//;
    s/[ \t]+$//;
    s/\#.*$//;
    next if (/^$/);
    @line = split ($key_re, $_, 2);

    $key = shift (@line);
    $res{$key} = [ split ($value_re, $line[0]) ];
  }

  &Utils::File::close_file ($fd);
  &Utils::Report::leave ();
  return undef if (scalar keys (%res) == 0);
  return \%res;
}

# Remove escape sequences in a shell value.
sub unescape
{
  my $ret = $_[0];

  # Quote shell special chars.
  $ret =~ s/\\\"/\\_/g;
  $ret =~ s/\"//g;
  $ret =~ s/\\_/\"/g;
  $ret =~ s/\\\'/\\_/g;
  $ret =~ s/\'//g;
  $ret =~ s/\\_/\'/g;
  $ret =~ s/\\(.)/$1/g;

  return $ret;
}

# unescape (escape (x)) == x
sub escape
{
  my ($value) = @_;

  $value =~ s/([\ \"\`\$\\])/\\$1/g;
  #$value = "\"$value\"" if ($value =~ /[ \t\'&|*?\[\]\{\}\{\}<>]/);

  return $value;
}

# For files which are a list of /bin/sh shell variable declarations. (ie GATEWAY=10.10.10.1)
sub get_sh
{
  my ($file, $key) = @_;
  my $ret;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_sh", $key, $file);
  $ret = &split_first_str ($file, $key, "[ \t]*=[ \t]*",
                                     \&chomp_line_hash_comment);
  &Utils::Report::leave ();

  return &unescape ($ret);
}

# Same, but interpret the returning value as a bool. (ie NETWORKING=yes)
sub get_sh_bool
{
  my ($file, $key) = @_;
  my $ret;

  $ret = &get_sh ($file, $key);

  return undef if ($ret eq undef);
  return (&Utils::Util::read_boolean ($ret)? 1: 0);
}

# Get an sh value and then split with $re, returning ref to resulting array.
sub get_sh_split
{
  my ($file, $key, $re) = @_;
  my (@ret, $val);

  $val = &get_sh ($file, $key);
  @ret = split ($re, $val);

  return \@ret;
}

# Get a fully qualified hostname from a $key shell var in $file
# and extract the hostname from there. e.g.: suse70's /etc/rc.config's FQHOSTNAME.
sub get_sh_hostname
{
  my ($file, $key) = @_;
  my ($val);

  $val = &get_sh_split ($file, $key, "\\.");

  return $$val[0];
}

# Get a fully qualified hostname from a $key shell var in $file
# and extract the domain from there. e.g.: suse70's /etc/rc.config's FQHOSTNAME.
sub get_sh_domain
{
  my ($file, $key) = @_;
  my ($val);

  $val = &get_sh_split ($file, $key, "\\.");

  return join ".", @$val[1..$#$val];
}

# For files which are a list of /bin/sh shell variable exports. (eg export GATEWAY=10.10.10.1)
sub get_sh_export
{
  my ($file, $key) = @_;
  my $ret;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_sh", $key, $file);
  $ret = &split_first_str ($file, $key, "[ \t]*=[ \t]*",
                                     \&chomp_line_sh_export);
  &Utils::Report::leave ();

  return &unescape ($ret);
}

# Same, but interpret the returing value as a bool. (ie export NETWORKING=yes)
sub get_sh_export_bool
{
  my ($file, $key) = @_;
  my $ret;

  $ret = &get_sh_export ($file, $key);

  return undef if ($ret eq undef);
  return (&Utils::Util::read_boolean ($ret)? 1: 0);
}

# Same, but accepting a regexp and returning the value between the paren operator
sub get_sh_re
{
  my ($file, $key, $re) = @_;
  my $ret;

  $ret = &get_sh ($file, $key);

  $ret =~ /$re/i;
  return $1;
}


# Search for $keyword in $file, delimited by $re (default " ") or EOL.
# If keyword exists, return 1, else 0.
sub get_kw
{
  my ($file, $keyword, $re, $line_read_proc) = @_;
  my $res;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_kw", $keyword, $file);
  
  if (! -f "$gst_prefix/$file")
  {
    &Utils::Report::enter ();
    &Utils::Report::do_report ("file_open_read_failed", $file);
    &Utils::Report::leave ();
    &Utils::Report::leave ();
    return undef;
  }
  
  $re = " " if $re eq undef;
  $res = &split_ref ($file, $keyword, $re, 0, $line_read_proc);

  &Utils::Report::leave ();
  return 0 if $res == -1;
  return 1;
}

# A file containing the desired value in its first line. (ie /etc/hostname)
sub get_first_line
{
  my ($file) = @_;
  my ($fd, $res);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_line_first", $file);
  $fd = &Utils::File::open_read_from_names ($file);
  &Utils::Report::leave ();
  
  return undef if !$fd;

  chomp ($res = <$fd>);
  &Utils::File::close_file ($fd);
  return $res;
}

# parse a chat file, searching for an entry that matches $re.
# $re must have one paren operator (ie "^atd[^0-9]*([0-9, -]+)").
sub get_from_chatfile
{
  my ($file, $re) = @_;
  my ($fd, $found);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_chat", $file);
  $fd = &Utils::File::open_read_from_names ("$file");
  &Utils::Report::leave ();
  return undef if !$fd;

  while (<$fd>)
  {
    # We'll be emptying $_ as we "scan".
    chomp;
    while ($_ ne "")
    {
      s/^\s*//;

      # If it uses quotes. FIXME: Assuming they surround the whole string.
      if (/^\'/)
      {
        s/\'([^\']*)\' ?//;
        $found = $1;
      }
      else
      {
        s/(\S*)\s?//;
        $found = $1;
      }

      # If it looks like what we're looking for, return what matched the parens.
      if ($found =~ /$re/i)
      {
        &Utils::File::close_file ($fd);
        return $1;
      }
    }
  }
  
  &Utils::File::close_file ($fd);
  # Oops: not found.
  return undef;
}

# Clean an ini line of comments and leading or
# trailing spaces.
sub ini_line_clean
{
  $_ = $_[0];
  
  chomp;
  s/\#.*//;
  s/;.*//;
  s/^[ \t]+//;
  s/[ \t]+$//;

  return $_;
}

# Read an ini line, which may have to be joined
# with the next one if it ends with '\'.
sub ini_line_read
{
  my $fd = $_[0];
  my $l;

  $l = <$fd>;
  return -1 if ($l eq undef);
  
  $l = &ini_line_clean ($l);
  while ($l =~ /\\$/)
  {
    $l =~ s/\\$//;
    $l .= &ini_line_clean (scalar <$fd>);
  }

  return \$l;
}

# Return an array of all found sections in $file.
sub get_ini_sections
{
  my ($file) = @_;
  my (@sections, $line);

  $fd = &Utils::File::open_read_from_names ($file);
  
  while (($line = &ini_line_read ($fd)) != -1)
  {
    $_ = $$line;
    next if (/^$/);
    push @sections, $1 if (/\[([^\]]+)\]/i);
  }

  &Utils::File::close_file ($fd);

  return @sections;
}

# Get the value of a $var in a $section from $file.
sub get_from_ini
{
  my ($file, $section, $var) = @_;
  my ($fd, $res, $line);
  my $found_section_flag = 0;
  my $escaped_section;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_ini", $var, $file, $section);
  $fd = &Utils::File::open_read_from_names ($file);
  &Utils::Report::leave ();
  $res = undef;
  $escaped_section = &escape ($section);

  while (($line = &ini_line_read ($fd)) != -1)
  {
    $_ = $$line;
    next if (/^$/);

    if (/\[$escaped_section\]/i)
    {
      $found_section_flag = 1;
      next;
    }

    if ($found_section_flag)
    {
      if (/^$var[ \t]*=/i)
      {
        s/^$var[ \t]*=[ \t]*//i;
        $res = $_;
        last;
      }
      elsif (/\[\S+\]/i)
      {
        last;
      }
    }
  }

  &Utils::File::close_file ($fd);

  return $res;
}

# Same, but treat value as bool and return 1/0.
sub get_from_ini_bool
{
  my ($file, $section, $var) = @_;
  my $ret;
  
  $ret = &get_from_ini ($file, $section, $var);
  
  return 0 if ($ret eq undef);
  return (&Utils::Util::read_boolean ($ret)? 1 : 0);
}

# Debian interfaces(5) states that files starting with # are comments.
# Also, leading and trailing spaces are ignored.
sub interfaces_line_clean
{
  $_ = $_[0];
  
  chomp;
  s/^[ \t]+//;
  s/^\#.*//;
  s/[ \t]+$//;

  return $_;
}

# interfaces(5) also states that \ line continuation is possible.
sub interfaces_line_read
{
  my $fd = $_[0];
  my $l;

  $l = <$fd>;
  return -1 if ($l eq undef);
  
  $l = &interfaces_line_clean ($l);
  while ($l =~ /\\$/)
  {
    $l =~ s/\\$//;
    $l .= &interfaces_line_clean (scalar <$fd>);
  }

  return \$l;
}

# Read lines until a stanza, a line starting with $stanza_type is found.
# Return ref to an array with the stanza params split.
sub interfaces_get_next_stanza
{
  my ($fd, $stanza_type) = @_;
  my $line;

  while (($line = &interfaces_line_read ($fd)) != -1)
  {
    $_ = $$line;
    if (/^$stanza_type[ \t]+[^ \t]/)
    {
      s/^$stanza_type[ \t]+//;
      return [ split ("[ \t]+", $_) ];
    }
  }

  return -1;
}

# Read lines until a line not recognized as a stanza is
# found, and split in a "tuple" of key/value.
sub interfaces_get_next_option
{
  my $fd = $_[0];
  my $line;

  while (($line = &interfaces_line_read ($fd)) != -1)
  {
    $_ = $$line;
    next if /^$/;
    
    return [ split ("[ \t]+", $_, 2) ] if (!/^iface[ \t]/);
    return -1;
  }

  return -1;
}

# Get all stanzas from file. Return array.
sub get_interfaces_stanzas
{
  my ($file, $stanza_type) = @_;
  my ($fd, @res);

  $fd = &Utils::File::open_read_from_names ($file);
  $res = undef;
  
  while (($_ = &interfaces_get_next_stanza ($fd, $stanza_type)) != -1)
  {
    push @res, $_;
  }

  &Utils::File::close_file ($fd);

  return @res;
}

# Find stanza for $iface in $file, and return
# tuple for option with $key. Return -1 if unexisting.
sub get_interfaces_option_tuple
{
  my ($file, $iface, $key, $all) = @_;
  my ($fd, @res);

  $fd = &Utils::File::open_read_from_names ($file);

  while (($stanza = &interfaces_get_next_stanza ($fd, "iface")) != -1)
  {
    if ($$stanza[0] eq $iface)
    {
      while (($tuple = &interfaces_get_next_option ($fd)) != -1)
      {
        if ($$tuple[0] =~ /$key/)
        {
          return $tuple if !$all;
          push @res, $tuple;
        }
      }

      return -1 if !$all;
    }
  }

  return @res if $all;
  return -1;
}

# Go get option $kw for $iface stanza. If found,
# return 1 (true), else, false.
sub get_interfaces_option_kw
{
  my ($file, $iface, $kw) = @_;
  my $tuple;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_ifaces_kw", $kw, $file);
  $tuple = &get_interfaces_option_tuple ($file, $iface, $kw);
  &Utils::Report::leave ();

  if ($tuple != -1)
  {
    &Utils::Report::do_report ("parse_ifaces_kw_strange", $iface, $file) if ($$tuple[1] ne "");

    return 1;
  }

  return 0;
}

# For such keywords as noauto, whose existence means
# a false value.
sub get_interfaces_option_kw_not
{
  my ($file, $iface, $kw) = @_;
  
  return &get_interfaces_option_kw ($file, $iface, $kw)? 0 : 1;
}

# Go get option $key for $iface in $file and return value.
sub get_interfaces_option_str
{
  my ($file, $iface, $key) = @_;
  my $tuple;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("parse_ifaces_str", $kw, $file);
  $tuple = &get_interfaces_option_tuple ($file, $iface, $key);
  &Utils::Report::leave ();

  if ($tuple != -1)
  {
    return $$tuple[1];
  }

  return undef;
}


# Implementing pump(8) pump.conf file format parser.
# May be useful for dhcpd too.
sub pump_get_next_option
{
  my ($fd) = @_;
  my $line;

  while (($line = &interfaces_line_read ($fd)) != -1)
  {
    $line = $$line;
    if ($line ne "")
    {
      return [ split ("[ \t]+", $line, 2) ];
    }
  }

  return -1;
}

sub pump_get_device
{
  my ($fd, $iface) = @_;
  my ($opt);
  
  while (($opt = &pump_get_next_option ($fd)) != -1)
  {
    if ($$opt[0] eq "device")
    {
      $$opt[1] =~ s/[ \t]*\{//;
      return 1 if $$opt[1] eq $iface;
    }
  }

  return 0;
}

sub get_pump_iface_option_ref
{
  my ($file, $iface, $key) = @_;
  my ($fd, $opt, $ret);

  $fd = &Utils::File::open_read_from_names ($file);

  if (&pump_get_device ($fd, $iface))
  {
    while (($opt = &pump_get_next_option ($fd)) != -1)
    {
      if ($$opt[0] eq $key)
      {
        $ret = &unescape ($$opt[1]);
        return \$ret;
      }
      
      return -1 if ($$opt[0] eq "}");
    }
  }

  return -1;
}

sub get_pump_iface_kw
{
  my ($file, $iface, $key) = @_;
  my ($ret);

  return 1 if &get_pump_iface_option_ref ($file, $iface, $key) != -1;
  return 0;
}

sub get_pump_iface_kw_not
{
  my ($file, $iface, $key) = @_;

  return 0 if &get_pump_iface_option_ref ($file, $iface, $key) != -1;
  return 1;
}

# extracts hostname from a fully qualified hostname
# contained in a file
sub get_fq_hostname
{
  my ($file) = @_;
  my ($ret);

  $ret = &get_first_line ($file);
  $ret =~ s/\..*//; #remove domain

  return $ret;
}

# extracts domain from a fully qualified hostname
# contained in a file
sub get_fq_domain
{
  my ($file) = @_;
  my ($ret);

  $ret = &get_first_line ($file);
  $ret =~ s/^[^\.]*\.//;

  return $ret;
}

sub get_rcinet1conf
{
  my ($file, $iface, $kw) = @_;
  my ($line, $val);

  $iface =~ s/eth//;

  #we must double escape those []
  $line = "$kw\\[$iface\\]";
  $val = &get_sh ($file, $line);

  return undef if ($val eq "");
  return $val;
}

sub get_rcinet1conf_bool
{
  my ($file, $iface, $kw) = @_;
  my ($ret);

  $ret = &get_rcinet1conf ($file, $iface, $kw);
  
  return undef if ($ret eq undef);
  return (&Utils::Util::read_boolean ($ret)? 1: 0);
}

# function for parsing /etc/start_if.$iface files in FreeBSD
sub get_startif
{
  my ($file, $regex) = @_;
  my ($fd, $line, $val);

  $fd  = &Utils::File::open_read_from_names ($file);
  $val = undef;

  return undef if ($fd eq undef);

  while (<$fd>)
  {
    chomp;

    # ignore comments
    next if (/^\#/);
                 
    if (/$regex/)
    {
      $val = $1;
    }
  }

  # remove double quote
  if ($val =~ /\"(.*)\"/)
  {
    $val = $1;
  }

  return $val;
}

# functions for parsing /etc/ppp/ppp.conf sections in FreeBSD
sub pppconf_find_next_stanza
{
  my ($buff, $line_no) = @_;

  $line_no = 0 if ($line_no eq undef);

  while ($$buff[$line_no] ne undef)
  {
    if ($$buff[$line_no] !~ /^[\#\n]/)
    {
      return $line_no if ($$buff[$line_no] =~ /^[^ \t]+/);
    }

    $line_no++;
  }

  return -1;
}

sub pppconf_find_stanza
{
  my ($buff, $section) = @_;
  my ($line_no) = 0;
  
  while (($line_no = &pppconf_find_next_stanza ($buff, $line_no)) != -1)
  {
    return $line_no if ($$buff[$line_no] =~ /^$section\:/);
    $line_no++;
  }

  return -1;
}

sub get_pppconf_common
{
  my ($file, $section, $key) = @_;
  my ($fd, $val);

  $fd = &Utils::File::open_read_from_names ($file);
  return undef if ($fd eq undef);

  $val = undef;

  # First of all, we must find the line where the section begins
  while (<$fd>)
  {
    chomp;
    last if (/^$section\:[ \t]*/);
  }

  while (<$fd>)
  {
    chomp;

    # read until the next section arrives
    last if (/^[^ \t]/);

    next if (/^\#/);

    if (/^[ \t]+(add|set|enable|disable)[ \t]+$key/)
    {
      $val = $_;
      last;
    }
  }

  # this is done because commands can be multiline
  while (<$fd>)
  {
    last if (/^[^ \t]/);
    last if ($val !~ /\\$/);

    s/^[ \t]*/ /;
    $val =~ s/\\$//;
    $val .= $_;
  }

  &Utils::File::close_file ($fd);

  if ($val eq undef)
  {
    return undef if ($section eq "default");
    return &get_pppconf_common ($file, "default", $key);
  }
  else
  {
    $val =~ s/\#[^\#]*$//;
    $val =~ s/[ \t]*$//;
    $val =~ s/^[ \t]*//;
    return $val;
  }
}

sub get_pppconf
{
  my ($file, $section, $key) = @_;
  my ($val);

  $val = &get_pppconf_common ($file, $section, $key);

  if ($val =~ /$key[ \t]+(.+)/)
  {
    return $1;
  }
}

sub get_pppconf_bool
{
  my ($file, $section, $key) = @_;
  my ($val);

  $val = &get_pppconf_common ($file, $section, $key);

  return 1 if ($val ne undef);
  return 0;
}

sub get_pppconf_re
{
  my ($file, $section, $key, $re) = @_;
  my ($val);

  $val = &get_pppconf_common ($file, $section, $key);

  if ($val =~ /$re/i)
  {
    return $1;
  }
}

sub get_ppp_options_re
{
  my ($file, $re) = @_;
  my ($fd, @res);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_get_ppp_option", &Utils::Replace::regexp_to_separator ($re), $file);
  $fd = &Utils::File::open_read_from_names ("$file");
  &Utils::Report::leave ();

  return undef if !$fd;

  while (($_ = &chomp_line_hash_comment ($fd)) != -1)
  {
    $_ = $$_;

    if (/$re/)
    {
      return $1;
    }
  }

  return undef;
}

sub get_confd_net
{
  my ($file, $key) = @_;
  my ($str, $contents, $i);

  $contents = &Utils::File::load_buffer ($file);

  for ($i = 0; $i <= scalar (@$contents); $i++)
  {
    # search for key
    if ($$contents[$i] =~ /^$key[ \t]*=[ \t]*\(/)
    {
      # contents can be multiline,
      # just get the first value
      do {
        $$contents[$i] =~ /\"([^\"]*)\"/;
        $str = $1;
        $i++;
      } while (!$str);
    }
  }

  return $str;
}

sub get_confd_net_re
{
  my ($file, $key, $re) = @_;
  my ($str);

  $str = &get_confd_net ($file, $key);

  if ($str =~ /$re/i)
  {
    return $1;
  }
}

1;
