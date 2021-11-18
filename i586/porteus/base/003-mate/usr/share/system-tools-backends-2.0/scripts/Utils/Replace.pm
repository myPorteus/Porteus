#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

# replace.pl: Common in-line replacing stuff for the ximian-setup-tools backends.
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>
#          Arturo Espinosa <arturo@ximian.com>
#          Michael Vogt <mvo@debian.org> - Debian 2.[2|3] support.
#          David Lee Ludwig <davidl@wpi.edu> - Debian 2.[2|3] support.
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

package Utils::Replace;

use Utils::Util;
use Utils::File;
use Utils::Parse;


# General rules: all replacing is in-line. Respect unsupported values, comments
# and as many spacing as possible.

# The concept of keyword (kw) here is a key, normaly in its own line, whose
# boolean representation is its own existence.

# A $re is a regular expression. In most functions here, regular expressions
# are converted to simple separators, by using gst_replace_regexp_to_separator.
# This makes it easier to convert a parse table into a replace table.

# Every final replacing function to be used by a table must handle one key
# at a time, but may replace several values from there.
#
# Return 0 for success, and -1 for failure.
#
# Most of these functions have a parsing counterpart. The convention is
# that parse becomes replace and split becomes join:
# split_first_str -> join_first_str

# Additional abstraction: replace table entries can have
# arrays inside. The replace proc will be ran with every
# combination that the arrays provide. Ex:
# ["user", \&gst_replace_foo, [0, 1], [2, 3] ] will replace
# using all possibilities in the combinatory of [0, 1]x[2, 3].
# Check RedHat 7.2's network replace table for further
# enlightenment.
sub run_entry
{
  my ($values_hash, $key, $proc, $cp, $value) = @_;
  my ($ncp, $i, $j, $res);

  $ncp = [@$cp];
  for ($i = 0; $i < scalar (@$cp); $i ++)
  {
      if (ref $$cp[$i] eq "ARRAY")
      {
          foreach $j (@{$$cp[$i]})
          {
              $$ncp[$i] = $j;
              $res = -1 if &run_entry ($values_hash, $key, $proc, $ncp, $value);
          }
          return $res;
      }
  }
  
  # OK, the given entry didn't have any array refs in it...

  return -1 if (!&Utils::Parse::replace_hash_values ($ncp, $values_hash));
  push (@$ncp, $$values_hash{$key}) unless $key eq "_always_";
  $res = -1 if &$proc (@$ncp);
  return $res;
}

# gst_replace_from_table takes a file mapping, a replace table, a hash
# of values, probably made from XML parsing, and whose keys are
# the same keys the table handles.
#
# Table entries whose keys are not present in the values_hash
# will not be processed. More than one entry may process the same key.
#
# The functions in the replace tables, most of which are coded in
# this file, receive the mapped files of the first argument, and then
# a set of values. The last argument is the value of the $values_hash
# for the corresponding key of the entry.
sub set_from_table
{
  my ($fn, $table, $values_hash, $old_hash) = @_;
  my ($key, $proc, @param);
  my ($i, @cp, @files, $res);

  $$fn{"OLD_HASH"} = $old_hash;

  foreach $i (@$table)
  {
    @cp = @$i;
    $key = shift (@cp);

    $proc = shift (@cp);
    @files = &Utils::Parse::replace_files (shift (@cp), $fn);
    unshift @cp, @files if (scalar @files) > 0;

    # treat empty values as undef
    delete $$values_hash{$key} if ($$values_hash{$key} eq "");

    if ((exists $$values_hash{$key}) or ($key eq "_always_"))
    {
      $res = &run_entry ($values_hash, $key, $proc, \@cp, $$values_hash{$key});
    }
    elsif ((!exists $$values_hash{$key}) && (exists $$old_hash{$key}))
    {
      # we need to remove all the instances of the known variables that doesn't exist in the data structure
      $res = &run_entry ($values_hash, $key, $proc, \@cp, undef);
    }
  }

  return $res;
}

# Wacky function that tries to create a field separator from a regular expression.
# Doesn't work with all possible regular expressions: just with the ones we are working with.
sub regexp_to_separator
{
  $_ = $_[0];

  s/\[([^^])([^\]])[^\]]*\]/$1/g;
  s/\+//g;
  s/\$//g;
  s/[^\*]\*//g;

  return $_;
}

sub set_value
{
  my ($key, $val, $re) = @_;
  
  return $key . &regexp_to_separator ($re) . $val;
}

# Edit a $file, wich is assumed to have a column-based format, with $re matching field separators
# and one record per line. Search for lines with the corresponding $key.
# The last arguments can be any number of standard strings.
sub split
{
  my ($file, $key, $re, @value) = @_;
  my ($fd, @line, @res);
  my ($buff, $i);
  my ($pre_space, $post_comment);
  my ($line_key, $val, $ret);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_split", $key, $file);

  $buff = &Utils::File::load_buffer ($file);
  
  foreach $i (@$buff)
  {
    $pre_space = $post_comment = "";

    chomp $i;
    $pre_space    = $1 if $i =~ s/^([ \t]+)//;
    $post_comment = $1 if $i =~ s/([ \t]*\#.*)//;
    
    if ($i ne "")
    {
      @line = split ($re, $i, 2);
      $line_key = shift (@line);

      # found the key?
      if ($line_key eq $key)
      {
        shift (@value) while ($value[0] eq "" && (scalar @value) > 0);

        if ((scalar @value) == 0)
        {
          $i = "";
          next;
        }

        $val = shift (@value);

        chomp $val;
        $i = &set_value ($key, $val, $re);
      }
    }

    $i = $pre_space . $i . $post_comment . "\n";
  }

  foreach $i (@value)
  {
    push (@$buff, &set_value ($key, $i, $re) . "\n") if ($i ne "");
  }

  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

# Replace all key/values in file with those in @$value,
# deleting exceeding ones and appending those required.
sub join_all
{
  my ($file, $key, $re, $value) = @_;

  return &split ($file, $key, $re, @$value);
}

# Find first $key value and replace with $value. Append if not found.
sub join_first_str
{
  my ($file, $key, $re, $value) = @_;

  return &split ($file, $key, $re, $value);
}

# Treat value as a bool value, using val_off and val_on as corresponding
# boolean representations.
sub join_first_bool
{
  my ($file, $key, $re, $val_on, $val_off, $value) = @_;

  # Fixme: on and off should be a parameter.
  $value = ($value == 1)? $val_on: $val_off;
  
  return &split ($file, $key, $re, $value);
}

# Find first key in file, and set array join as value.
sub join_first_array
{
  my ($file, $key, $re1, $re2, $value) = @_;

  return &split ($file, $key, $re1, join (&regexp_to_separator ($re2), @$value));
}

# Escape $value in /bin/sh way, find/append key and set escaped value.
sub set_sh
{
  my ($file, $key, $value, $unescaped) = @_;
  my $ret;

  $value = &Utils::Parse::escape ($value) unless $unescaped;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_sh", $key, $file);

  # This will expunge the whole var if the value is empty.
  if ($value eq "")
  {
    $ret = &split ($file, $key, "[ \t]*=[ \t]*");
  }
  else
  {
    $ret = &split ($file, $key, "[ \t]*=[ \t]*", $value);
  }
  
  &Utils::Report::leave ();
  return $ret;
}

# Escape $value in /bin/sh way, find/append key and set escaped value, make sure line har 
sub set_sh_export
{
  my ($file, $key, $value) = @_;
  my $ret;

  $value = &Utils::Parse::escape ($value);

  # This will expunge the whole var if the value is empty.

  # FIXME: Just adding "export " works for the case I need, though it doesn't
  # handle arbitraty whitespace. Something should be written to replace split()
  # here.

  if ($value eq "")
  {
    $ret = &split ($file, "export " . $key, "[ \t]*=[ \t]*");
  }
  else
  {
    $ret = &split ($file, "export " . $key, "[ \t]*=[ \t]*", $value);
  }
  
  return $ret;
}

# Treat value as a yes/no bool, replace in shell style.
# val_true and val_false have default yes/no values.
# use &set_sh_bool (file, key, value) if defaults are desired.
sub set_sh_bool
{
  my ($file, $key, $val_true, $val_false, $value) = @_;

  # default value magic.
  if ($val_false eq undef)
  {
      $value = $val_true;
      $val_true = undef;
  }

  $val_true  = "yes" unless $val_true;
  $val_false = "no"  unless $val_false;

  $value = ($value == 1)? $val_true: $val_false;
  
  return &set_sh ($file, $key, $value);
}

# Treat value as a yes/no bool, replace in export... shell style.
sub set_sh_export_bool
{
  my ($file, $key, $val_true, $val_false, $value) = @_;

  # default value magic.
  if ($val_false eq undef)
  {
      $value = $val_true;
      $val_true = undef;
  }

  $val_true  = "yes" unless $val_true;
  $val_false = "no"  unless $val_false;

  $value = ($value == 1)? $val_true: $val_false;
  
  return &set_sh_export ($file, $key, $value);
}

# Get a fully qualified hostname from a $key shell var in $file
# and set the hostname part. e.g.: suse70's /etc/rc.config's FQHOSTNAME.
sub set_hostname
{
  my ($file, $key, $value) = @_;
  my ($domain);

  $domain = &Utils::Parse::get_sh_domain ($file, $key);
  return &set_sh ($file, $key, "$value.$domain");
}

# Get a fully qualified hostname from a $key shell var in $file
# and set the domain part. e.g.: suse70's /etc/rc.config's FQHOSTNAME.
sub set_domain
{
  my ($file, $key, $value) = @_;
  my ($hostname);

  $hostname = &Utils::Parse::get_sh_hostname ($file, $key);
  return &set_sh ($file, $key, "$hostname.$value");
}

# Join the array pointed by $value with the corresponding $re separator
# and assign that to the $key shell variable in $file.
sub set_sh_join
{
  my ($file, $key, $re, $value) = @_;

  return &set_sh ($file, $key,
                          join (&regexp_to_separator ($re), @$value));
}

# replace a regexp with $value
sub set_sh_re
{
  my ($file, $key, $re, $value) = @_;
  my ($val);

  $val = &Utils::Parse::get_sh ($file, $key);

  if ($val =~ /$re/)
  {
    $val =~ s/$re/$value/;
  }
  else
  {
    $val .= $value;
  }

  $val = '"' . $val . '"' if ($val !~ /^\".*\"$/);

  return &split ($file, $key, "[ \t]*=[ \t]*", $val)
}

# Quick trick to set a keyword $key in $file. (think /etc/lilo.conf keywords).
sub set_kw
{
  my ($file, $key, $value) = @_;
  my $ret;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_kw", $key, $file);
  $ret = &split ($file, $key, "\$", ($value)? "\n" : "");
  &Utils::Report::leave ();
  return $ret;
}

# The kind of $file whose $value is its first line contents.
# (/etc/hostname)
sub set_first_line
{
  my ($file, $value) = @_;
  my $fd;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_line_first", $file);
  $fd = &Utils::File::open_write_from_names ($file);
  &Utils::Report::leave ();
  return -1 if !$fd;

  print $fd "$value\n";
  &Utils::File::close_file ($fd);
  
  return 0;
}

# For every key in %$value, replace/append the corresponding key/value pair.
# The separator for $re1 
sub join_hash
{
  my ($file, $re1, $re2, $value) = @_;
  my ($i, $res, $tmp, $val);
  my ($oldhash, %merge);

  $oldhash = &Utils::Parse::split_hash ($file, $re1, $re2);
  foreach $i (keys (%$value), keys (%$oldhash))
  {
    $merge{$i} = 1;
  }

  $res = 0;
  
  foreach $i (keys (%merge))
  {
    if (exists $$value{$i})
    {
      $val = join (&regexp_to_separator ($re2), @{$$value{$i}});
      $tmp = &split ($file, $i, $re1, $val);
    }
    else
    {
      # This deletes the entry.
      $tmp = &split ($file, $i, $re1);
    }
    $res = $tmp if !$res;
  }

  return $res;
}

# Find $re matching send string and replace parenthesyzed
# part of $re with $value. FIXME: apply meeks' more general impl.
sub set_chat
{
  my ($file, $re, $value) = @_;
  my ($buff, $i, $bak, $found, $substr, $ret);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_chat", $file);
  $buff = &Utils::File::load_buffer ($file);

  SCAN: foreach $i (@$buff)
  {
    $bak = "";
    $found = "";
    my ($quoted);
    chomp $i;

    while ($i ne "")
    {
	 $i =~ s/^\s*//;

	 # If it uses quotes. FIXME: Assuming they surround the whole string.
	 if ($i =~ /^\'/)
	 {
	   $i =~ s/\'([^\']*)\' ?//;
	   $found = $1;
	   $quoted = 1;
	 }
	 else
	 {
	   $i =~ s/([^ \t]*) ?//;
	   $found = $1;
	   $quoted = 0;
	 }

	 # If it looks like what we're looking for,
	 # substitute what is in parens with value.
	 if ($found =~ /$re/i)
	 {
	   $substr = $1;
	   $substr =~ s/\*/\\\*/g;
	   $found =~ s/$substr/$value/i;

	   if ($quoted == 1)
	   {
	     $i = $bak . "\'$found\' " . $i . "\n";
	   }
	   else
	   {
	     $i = $bak . "$found " . $i . "\n";
	   }

	   last SCAN;
	 }

	 if ($quoted == 1)
	 {
	   $bak .= "\'$found\'";
	 }
	 else
	 {
	   $bak .= "$found";
	 }

	 $bak .= " " if $bak ne "";
    }
    
    $i = $bak . "\n";
  }

  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

# Find/append $section in ini $file and replace/append
# $var = $value pair. FIXME: should reimplement with
# interfaces style. This is too large.
sub set_ini
{
  my ($file, $section, $var, $value) = @_;
  my ($buff, $i, $found_flag, $ret);
  my ($pre_space, $post_comment, $sec_save);
  my ($escaped_section);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_ini", $var, $section, $file);

  $buff = &Utils::File::load_buffer ($file);

  &Utils::File::join_buffer_lines ($buff);
  $found_flag = 0;
  $escaped_section = Utils::Parse::escape ($section);
  
  foreach $i (@$buff)
  {
    $pre_space = $post_comment = "";
    
    chomp $i;
    $pre_space = $1 if $i =~ s/^([ \t]+)//;
    $post_comment = $1 if $i =~ s/([ \t]*[\#;].*)//;
    
    if ($i ne "")
    {
      if ($i =~ /\[$escaped_section\]/i)
      {
        $i =~ s/(\[$escaped_section\][ \t]*)//i;
        $sec_save = $1;
        $found_flag = 1;
      }

      if ($found_flag)
      {
        if ($i =~ /\[[^\]]+\]/)
        {
          $i = "$var = $value\n$i" if ($value ne "");
          $found_flag = 2;
        }

        if ($i =~ /^$var[ \t]*=/i)
        {
          if ($value ne "")
          {
            $i =~ s/^($var[ \t]*=[ \t]*).*/$1$value/i;
          }
          else
          {
            $i = "";
          }
          $found_flag = 2;
        }
      }
    }
    
    if ($found_flag && $sec_save ne "")
    {
      $i = $sec_save . $i;
      $sec_save = "";
    }
    
    $i = $pre_space . $i . $post_comment . "\n";
    last if $found_flag == 2;
  }

  push @$buff, "\n[$section]\n" if (!$found_flag);
  push @$buff, "$var = $value\n" if ($found_flag < 2 && $value ne "");

  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

# Well, removes a $section from an ini type $file.
sub remove_ini_section
{
  my ($file, $section) = @_;
  my ($buff, $i, $found_flag, $ret);
  my ($pre_space, $post_comment, $sec_save);
  my ($escaped_section);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_del_ini_sect", $section, $file);

  $buff = &Utils::File::load_buffer ($file);
  $escaped_section = &Utils::Parse::escape ($section);

  &Utils::File::join_buffer_lines ($buff);
  $found_flag = 0;

  foreach $i (@$buff)
  {
    $pre_space = $post_comment = "";

    chomp $i;
    $pre_space = $1 if $i =~ s/^([ \t]+)//;
    $post_comment = $1 if $i =~ s/([ \t]*[\#;].*)//;
    
    if ($i ne "")
    {
      if ($i =~ /\[$escaped_section\]/i)
      {
        $i =~ s/(\[$escaped_section\][ \t]*)//i;
        $found_flag = 1;
      }
      elsif ($found_flag && $i =~ /\[.+\]/i)
      {
        $i = $pre_space . $i . $post_comment . "\n";
        last;
      }
    }

    if ($found_flag)
    {
      if ($post_comment =~ /^[ \t]*$/)
      {
        $i = "";
      }
      else
      {
        $i = $post_comment . "\n";
      }
    }
    else
    {
      $i = $pre_space . $i . $post_comment . "\n";
    }
  }

  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

# Removes a $var in $section of a ini type $file.
sub remove_ini_var
{
  my ($file, $section, $var) = @_;
  &set_ini ($file, $section, $var, "");
}

# Replace using boolean $value with a yes/no representation,
# ini style.
sub set_ini_bool
{
  my ($file, $section, $var, $value) = @_;

  $value = ($value == 0)? "no": "yes";

  return &set_ini ($file, $section, $var, $value);
}


# Debian /etc/network/interfaces in-line replacing methods.

# From loaded buffer, starting at $line_no, find next debian
# interfaces format stanza. Return array ref with all stanza args.
# -1 if not found.
# NOTE: $line_no is a scalar ref. and gives the position of next stanza.
sub interfaces_get_next_stanza
{
  my ($buff, $line_no, $stanza_type) = @_;
  my ($i, $line);

  while ($$line_no < (scalar @$buff))
  {
    $_ = $$buff[$$line_no];
    $_ = &Utils::Parse::interfaces_line_clean ($_);

    if (/^$stanza_type[ \t]+[^ \t]/)
    {
      s/^$stanza_type[ \t]+//;
      return [ split ("[ \t]+", $_) ];
    }
    $$line_no ++;
  }

  return -1;
}

sub interfaces_line_is_stanza
{
  my ($line) = @_;

  return 1 if $line =~ /^(iface|auto|mapping)[ \t]+[^ \t]/;
  return 0;
}

# Scan for next option. An option is something that is
# not a stanza. Return key/value tuple ref, -1 if not found.
# $$line_no will contain position.
sub interfaces_get_next_option
{
  my ($buff, $line_no) = @_;
  my ($i, $line, $empty_lines);

  $empty_lines = 0;
  
  while ($$line_no < (scalar @$buff))
  {
    $_ = $$buff[$$line_no];
    $_ = &Utils::Parse::interfaces_line_clean ($_);

    if (!/^$/)
    {
      return [ split ("[ \t]+", $_, 2) ] if (! &interfaces_line_is_stanza ($_));
      $$line_no -= $empty_lines;
      return -1;
    }
    else
    {
      $empty_lines ++;
    }
    
    $$line_no ++;
  }

  $$line_no -= $empty_lines;
  return -1;
}

# Search buffer for option with key $key, starting
# at $$line_no position. Return 1/0 found result.
# $$line_no will show position.
sub interfaces_option_locate
{
  my ($buff, $line_no, $key) = @_;
  my $option;

  while (($option = &interfaces_get_next_option ($buff, $line_no)) != -1)
  {
    return 1 if ($$option[0] eq $key);
    $$line_no ++;
  }
  
  return 0;
}

# Locate stanza line for $iface in $buff, starting at $$line_no.
sub interfaces_next_stanza_locate
{
  my ($buff, $line_no) = @_;

  return &interfaces_get_next_stanza ($buff, \$$line_no, "(iface|auto|mapping)");
}

sub interfaces_iface_stanza_locate
{
  my ($buff, $line_no, $iface) = @_;

  return &interfaces_generic_stanza_locate ($buff, \$$line_no, $iface, "iface");
}

sub interfaces_auto_stanza_locate
{
  my ($buff, $line_no, $iface) = @_;

  return &interfaces_generic_stanza_locate ($buff, \$$line_no, $iface, "auto");
}

sub interfaces_generic_stanza_locate
{
  my ($buff, $line_no, $iface, $stanza_name) = @_;
  my $stanza;

  while (($stanza = &interfaces_get_next_stanza ($buff, \$$line_no, $stanza_name)) != -1)
  {
    return 1 if ($$stanza[0] eq $iface);
    $$line_no++;
  }

  return 0;
}

# Create a Debian Woody stanza, type auto, with the requested
# @ifaces as values.
sub interfaces_auto_stanza_create
{
  my ($buff, @ifaces) = @_;
  my ($count);
  
  push @$buff, "\n" if ($$buff[$count] ne "");
  push @$buff, "auto " . join (" ", @ifaces) . "\n";
}

# Append a stanza for $iface to buffer.
sub interfaces_iface_stanza_create
{
  my ($buff, $iface) = @_;
  my ($count);

  $count = $#$buff;
  push @$buff, "\n" if ($$buff[$count] ne "");
  push @$buff, "iface $iface inet static\n";
}

# Delete $iface stanza and all its option lines.
sub interfaces_iface_stanza_delete
{
  my ($file, $iface) = @_;
  my ($buff, $line_no, $line_end, $stanza);

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $line_no = 0;

  return -1 if (!&interfaces_iface_stanza_locate ($buff, \$line_no, $iface));
  $line_end = $line_no + 1;
  &interfaces_next_stanza_locate ($buff, \$line_end);

  while ($line_no < $line_end)
  {
    delete $$buff[$line_no];
    $line_no++;
  }
  
  $line_no = 0;
  if (&interfaces_auto_stanza_locate ($buff, \$line_no, $iface))
  {
    $line_end = $line_no + 1;
    &interfaces_next_stanza_locate ($buff, \$line_end);

    while ($line_no < $line_end)
    {
      delete $$buff[$line_no];
      $line_no++;
    }
  }
  
  &Utils::File::clean_buffer ($buff);
  return &Utils::File::save_buffer ($buff, $file);
}

# Find $iface stanza line and replace $pos value (ie the method).
sub set_interfaces_stanza_value
{
  my ($file, $iface, $pos, $value) = @_;
  my ($buff, $line_no, $stanza);
  my ($pre_space, $line, $line_arr);

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $line_no = 0;

  if (!&interfaces_iface_stanza_locate ($buff, \$line_no, $iface))
  {
    $line_no = 0;
    &interfaces_iface_stanza_create ($buff, $iface);
    &interfaces_iface_stanza_locate ($buff, \$line_no, $iface);
  }

  $line = $$buff[$line_no];
  chomp $line;
  $pre_space = $1 if $line =~ s/^([ \t]+)//;
  $line =~ s/^iface[ \t]+//;
  @line_arr = split ("[ \t]+", $line);
  $line_arr[$pos] = $value;
  $$buff[$line_no] = $pre_space . "iface " . join (' ', @line_arr) . "\n";

  &Utils::File::clean_buffer ($buff);
  return &Utils::File::save_buffer ($buff, $file);
}

# Find/append $key option in $iface stanza and set $value.
sub set_interfaces_option_str
{
  my ($file, $iface, $key, $value) = @_;
  my ($buff, $line_no, $stanza, $ret);
  my ($pre_space, $line, $line_arr);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("replace_ifaces_str", $key, $iface);
  
  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $line_no = 0;

  if (!&interfaces_iface_stanza_locate ($buff, \$line_no, $iface))
  {
    $line_no = 0;
    &interfaces_iface_stanza_create ($buff, $iface);
    &interfaces_iface_stanza_locate ($buff, \$line_no, $iface);
  }

  $line_no++;

  if (&interfaces_option_locate ($buff, \$line_no, $key))
  {
    if ($value eq "") # Delete option if value is empty.
    {
      $$buff[$line_no] = "";
    }
    else
    {
      chomp $$buff[$line_no];
      $$buff[$line_no] =~ s/^([ \t]*$key[ \t]).*/$1/;
    }
  }
  elsif ($value ne "")
  {
    $line_no --;
    chomp $$buff[$line_no];
    $$buff[$line_no] =~ s/^([ \t]*)(.*)/$1$2\n$1$key /;
  }

  $$buff[$line_no] .= $value . "\n" if $value ne "";
  
  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

# $key option is keyword. $value says if it should exist or not.
sub set_interfaces_option_kw
{
  my ($file, $iface, $key, $value) = @_;

  return &set_interfaces_option_str ($file, $iface, $key, $value? " ": "");
}

# !$value says if keyword should exist or not (ie noauto).
sub set_interfaces_option_kw_not
{
  my ($file, $iface, $key, $value) = @_;

  return &set_interfaces_option_kw ($file, $iface, $key, !$value);
}


# Implementing pump(8) pump.conf file format replacer.
# May be useful for dhcpd too.

# Try to find the next option, returning an array ref
# with the found key and the rest of the options in
# two items, or -1 if not found.
sub pump_get_next_option
{
  my ($buff, $line_no) = @_;

  while ($$line_no < (scalar @$buff))
  {
    $_ = $$buff[$$line_no];
    $_ = &Utils::Parse::interfaces_line_clean ($_);
    if ($_ ne "")
    {
      return [ split ("[ \t]+", $_, 2) ];
    }
    
    $$line_no ++;
  }

  return -1;
}

# Iterate with get_next_option, starting at $line_no
# until the option with $key is found, or eof.
# Return 0/1 as found.
sub pump_option_locate
{
  my ($buff, $line_no, $key) = @_;
  my ($opt);
  
  while (($opt = &pump_get_next_option ($buff, $line_no)) != -1)
  {
    return 1 if $$opt[0] eq $key;
    return 0 if $$opt[0] eq "}";

    $$line_no ++;
  }
  
  return 0;
}

# Try to find a "device" option whose interface is $iface,
# starting at $$line_no. Return 0/1 as found.
sub pump_get_device
{
  my ($buff, $line_no, $iface) = @_;
  my ($opt);

  while (($opt = &pump_get_next_option ($buff, $line_no)) != -1)
  {
    if ($$opt[0] eq "device")
    {
      $$opt[1] =~ s/[ \t]*\{//;
      return 1 if $$opt[1] eq $iface;
    }

    $$line_no ++;
  }

  return 0;
}

# Add a device entry for $iface at the end of $buff.
sub pump_add_device
{
  my ($buff, $iface) = @_;

  push @$buff, "\n";
  push @$buff, "device $iface {\n";
  push @$buff, "\t\n";
  push @$buff, "}\n";
}

# Find a "device" section for $iface and
# replace/add/delete the $key option inside the section.
sub set_pump_iface_option_str
{
  my ($file, $iface, $key, $value) = @_;
  my ($line_no, $ret);

  $buff = &Utils::File::load_buffer ($file);
  $line_no = 0;

  if (!&pump_get_device ($buff, \$line_no, $iface))
  {
    $line_no = 0;
    &pump_add_device ($buff, $iface);
    &pump_get_device ($buff, \$line_no, $iface);
  }

  $line_no ++;

  if (&pump_option_locate ($buff, \$line_no, $key))
  {
    if ($value eq "")
    {
      $$buff[$line_no] = "";
    }
    else
    {
      chomp $$buff[$line_no];
      $$buff[$line_no] =~ s/^([ \t]*$key[ \t]).*/$1/;
    }
  }
  elsif ($value ne "")
  {
    $line_no --;
    chomp $$buff[$line_no];
    $$buff[$line_no] =~ s/^([ \t]*)(.*)/$1$2\n$1$key /;
  }

  if ($value ne "")
  {
    $value =~ s/^[ \t]+//;
    $value =~ s/[ \t]+$//;
    $$buff[$line_no] .= &Utils::Parse::escape ($value) . "\n";
  }

  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

# Same as function above, except $key is a keyword.
sub set_pump_iface_kw
{
  my ($file, $iface, $key, $value) = @_;

  return &set_pump_iface_option_str ($file, $iface, $key, $value? " ": "");
}

# Same, but use the negative of $value (i.e. nodns)
sub set_pump_iface_kw_not
{
  my ($file, $iface, $key, $value) = @_;

  return &set_pump_iface_kw ($file, $iface, $key, !$value);
}

sub set_xml_pcdata
{
  my ($file, $varpath, $data) = @_;
  my ($model, $branch, $fd, $compressed);

  ($model, $compressed) = &Utils::XML::model_scan ($file);
  $branch = &Utils::XML::model_ensure ($model, $varpath);

  &Utils::XML::model_set_pcdata ($branch, $data);

  return &Utils::XML::model_save ($model, $file, $compressed);
}

sub set_xml_attribute
{
  my ($file, $varpath, $attr, $value) = @_;
  my ($model, $branch, $fd, $compressed);

  ($model, $compressed) = &Utils::XML::model_scan ($file);
  $branch = &Utils::XML::model_ensure ($model, $varpath);

  &Utils::XML::model_set_attribute ($branch, $attr, $value);

  return &Utils::XML::model_save ($model, $file, $compressed);
}

sub set_xml_pcdata_with_type
{
  my ($file, $varpath, $type, $data) = @_;
  my ($model, $branch, $fd, $compressed);

  ($model, $compressed) = &Utils::XML::model_scan ($file);
  $branch = &Utils::XML::model_ensure ($model, $varpath);

  &Utils::XML::model_set_pcdata ($branch, $data);
  &Utils::XML::model_set_attribute ($branch, "TYPE", $type);

  return &Utils::XML::model_save ($model, $file, $compressed);
}

sub set_xml_attribute_with_type
{
  my ($file, $varpath, $attr, $type, $value) = @_;
  my ($model, $branch, $fd, $compressed);

  ($model, $compressed) = &Utils::XML::model_scan ($file);
  $branch = &Utils::XML::model_ensure ($model, $varpath);

  &Utils::XML::model_set_attribute ($branch, $attr, $value);
  &Utils::XML::model_set_attribute ($branch, "TYPE", $type);

  return &Utils::XML::model_save ($model, $file, $compressed);
}

sub set_fq_hostname
{
  my ($file, $hostname, $domain) = @_;

  if ($domain eq undef)
  {
    return &set_first_line ($file, "$hostname");
  }
  else
  {
    return &set_first_line ($file, "$hostname.$domain");
  }
}

sub set_rcinet1conf
{
  my ($file, $iface, $kw, $val) = @_;
  my ($line);

  $iface =~ s/eth//;
  $line = "$kw\[$iface\]";

  $val = "\"$val\"";

  return &split ($file, $line, "[ \t]*=[ \t]*", $val);
}

sub set_rcinet1conf_global
{
  my ($file, $kw, $val) = @_;

  $val = "\"$val\"";

  return &split ($file, $kw, "[ \t]*=[ \t]*", $val)
}

# Functions for replacing in FreeBSD's /etc/ppp/ppp.conf
sub set_pppconf_common
{
  my ($pppconf, $section, $key, $string) = @_;
  my ($buff, $line_no, $end_line_no, $i, $found);

  $buff = &Utils::File::load_buffer ($pppconf);

  $line_no = &Utils::Parse::pppconf_find_stanza ($buff, $section);

  if ($line_no ne -1)
  {
    # The stanza exists
    $line_no++;

    $end_line_no = &Utils::Parse::pppconf_find_next_stanza ($buff, $line_no);
    $end_line_no = scalar @$buff + 1 if ($end_line_no == -1);
    $end_line_no--;

    for ($i = $line_no; $i <= $end_line_no; $i++)
    {
      if ($$buff[$i] =~ /[ \t]+$key/)
      {
        if ($string ne undef)
        {
          $$buff[$i] = " $string\n";
          $found = 1;
        }
        else
        {
          delete $$buff[$i];
        }
      }
    }

    if ($found != 1)
    {
      $$buff[$end_line_no] .= " $string\n" if ($string ne undef);
    }
  }
  else
  {
    if ($string ne undef)
    {
      push @$buff, "$section:\n";
      push @$buff, " $string\n";
    }
  }

  &Utils::File::clean_buffer ($buff);
  return &Utils::File::save_buffer ($buff, $pppconf);
}

sub set_pppconf
{
  my ($pppconf, $section, $key, $value) = @_;
  &set_pppconf_common ($pppconf, $section, $key, "set $key $value");
}

sub set_pppconf_bool
{
  my ($pppconf, $section, $key, $value) = @_;
  &set_pppconf_common ($pppconf, $section, $key,
                       ($value == 1)? "enable $key" : "disable $key");
}

sub set_ppp_options_re
{
  my ($file, $re, $value) = @_;
  my ($buff, $line, $replaced, $ret);
  my ($pre_space, $post_comment);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_set_ppp_option", &Utils::Replace::regexp_to_separator ($re), $file);

  $buff = &Utils::File::load_buffer ($file);

  foreach $line (@$buff)
  {
    $pre_space = $post_comment = "";
    chomp $line;
    $pre_space = $1 if $line =~ s/^([ \t]+)//;
    $post_comment = $1 if $line =~ s/([ \t]*\#.*)//;
    
    if ($line =~ /$re/)
    {
      $line = "$value\n";
      $replaced = 1;
      last;
    }

    $line = $pre_space . $line . $post_comment . "\n";
  }

  push @$buff, "$value\n" if !$replaced;
  
  &Utils::File::clean_buffer ($buff);
  $ret = &Utils::File::save_buffer ($buff, $file);
  &Utils::Report::leave ();
  return $ret;
}

sub set_ppp_options_connect
{
  my ($file, $value) = @_;
  my $ret;

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_set_ppp_connect", $file);
  $ret = &set_ppp_options_re ($file, "^connect", "connect \"/usr/sbin/chat -v -f /etc/chatscripts/$value\"");
  &Utils::Report::leave ();
  return $ret;
}

sub set_confd_net_re
{
  my ($file, $key, $re, $value) = @_;
  my ($str, $contents, $i, $found, $done);

  $found = $done = 0;
  $contents = &Utils::File::load_buffer ($file);

  for ($i = 0; $i <= scalar (@$contents); $i++)
  {
    # search for key
    if ($$contents[$i] =~ /^$key[ \t]*=[ \t]*\(/)
    {
      $found = 1;

      do {
        if ($$contents[$i] =~ /\"([^\"]*)\"/)
        {
          $str = $1;

          if ($str =~ /$re/)
          {
            $str =~ s/$re/$value/;
          }
          else
          {
            $str .= $value;
          }

          $$contents[$i] =~ s/\"([^\"]*)\"/\"$str\"/;
          $done = 1;
        }

        $i++;
      } while (!$done);
    }
  }

  if (!$found)
  {
    push @$contents, "$key=(\"$value\")\n";
  }

  return &Utils::File::save_buffer ($contents, $file);
}

sub set_confd_net
{
  my ($file, $key, $value) = @_;

  return &set_confd_net_re ($file, $key, ".*", $value);
}


1;
