#-*- Mode: perl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
# Network Interfaces Configuration handling
#
# Copyright (C) 2000-2001 Ximian, Inc.
#
# Authors: Hans Petter Jansson <hpj@ximian.com>
#          Arturo Espinosa <arturo@ximian.com>
#          Michael Vogt <mvo@debian.org> - Debian 2.[2|3] support.
#          David Lee Ludwig <davidl@wpi.edu> - Debian 2.[2|3] support.
#          Grzegorz Golawski <grzegol@pld-linux.org> - PLD support
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

package Network::Ifaces;

use Utils::Util;
use Utils::Parse;
use Init::Services;

# FIXME: this function isn't IPv6-aware
# it checks if a IP address is in the same network than another
sub is_ip_in_same_network
{
  my ($address1, $address2, $netmask) = @_;
  my (@add1, @add2, @mask);
  my ($i);

  return 0 if (!$address1 || !$address2 || !$netmask);

  @add1 = split (/\./, $address1);
  @add2 = split (/\./, $address2);
  @mask = split (/\./, $netmask);

  for ($i = 0; $i < 4; $i++)
  {
    $add1[$i] += 0;
    $add2[$i] += 0;
    $mask[$i] += 0;

    return 0 if (($add1[$i] & $mask[$i]) != ($add2[$i] & $mask[$i]));
  }

  return 1;
}

sub ensure_iface_broadcast_and_network
{
  my ($iface) = @_;
    
  if (exists $$iface{"netmask"} &&
      exists $$iface{"address"})
  {
    if (! exists $$iface{"broadcast"})
    {
      $$iface{"broadcast"} = &Utils::Util::ip_calc_broadcast ($$iface{"address"}, $$iface{"netmask"});
    }

    if (! exists $$iface{"network"})
    {
      $$iface{"network"} = &Utils::Util::ip_calc_network ($$iface{"address"}, $$iface{"netmask"});
    }
  }
}

sub check_pppd_plugin
{
  my ($plugin) = @_;
  my ($version, $output);

  $version = &Utils::File::run_backtick ("pppd --version", 1);
  $version =~ s/.*version[ \t]+//;
  chomp $version;

  return 0 if !version;
  return &Utils::File::exists ("/usr/lib/pppd/$version/$plugin.so");
}

sub check_capi
{
  my ($line, $i);

  if ($Utils::Backend::tool{"system"} ne "Linux")
  {
    return &check_pppd_plugin("capiplugin");
  }

  $i=0;
  $fd = &Utils::File::open_read_from_names ("proc/capi/controller");
  return 0 if !$fd;

  while (($line = &Utils::Parse::chomp_line_hash_comment ($fd)) != -1)
  {
    $i++;
  }

  return ($i > 0) ? &check_pppd_plugin("capiplugin") : 0;
}

sub get_ppp_type
{
  my ($ppp_options, $chatscript) = @_;
  my ($plugin);

  $plugin = &Utils::Parse::split_first_str ($ppp_options, "plugin", "[ \t]+");

  return "isdn" if ($plugin =~ /^capiplugin/);
  return "pppoe" if ($plugin =~ /^rp-pppoe/);
  return "gprs" if (&Utils::Parse::get_from_chatfile ($chatscript, "(CGDCONT)"));
  return "modem";
}

sub get_linux_wireless_ifaces
{
  my ($fd, $line);
  my (@ifaces, $command);

  $fd = &Utils::File::run_pipe_read ("iwconfig");
  return @ifaces if $fd eq undef;

  while (<$fd>)
  {
    if (/^([a-zA-Z0-9]+)[\t ].*$/)
    {
      push @ifaces, $1;
    }
  }

  &Utils::File::close_file ($fd);

  &Utils::Report::leave ();
  return \@ifaces;
}

sub get_freebsd_wireless_ifaces
{
  my ($fd, $line, $iface);
  my (@ifaces, $command);

  $command = &Utils::File::get_cmd_path ("ifconfig");
  open $fd, "$command |";
  return @ifaces if $fd eq undef;

  while (<$fd>)
  {
    if (/^([a-zA-Z]+[0-9]+):/)
    {
      $iface = $1;
    }

    if (/media:.*wireless.*/i)
    {
      push @ifaces, $iface;
    }
  }

  &Utils::File::close_file ($fd);
  &Utils::Report::leave ();

  return \@ifaces;
}

# Returns an array with the wireless devices found
sub get_wireless_ifaces
{
  my ($plat) = $Utils::Backend::tool{"system"};
    
  return &get_linux_wireless_ifaces   if ($plat eq "Linux");
  return &get_freebsd_wireless_ifaces if ($plat eq "FreeBSD");
}

# returns interface type depending on it's interface name
# types_cache is a global var for caching interface types
sub get_interface_type
{
  my ($dev) = @_;
  my (@wireless_ifaces, $wi, $type);

  return $types_cache{$dev} if (exists $types_cache{$dev});

  #check whether interface is wireless
  $wireless_ifaces = &get_wireless_ifaces ();
  foreach $wi (@$wireless_ifaces)
  {
    if ($dev eq $wi)
    {
      $types_cache{$dev} = "wireless";
      return $types_cache{$dev};
    }
  }

  if ($dev =~ /^(ppp|tun)/)
  {
    $types_cache{$dev} = "modem";
  }
  elsif ($dev =~ /(eth|dc|ed|bfe|em|fxp|bge|de|xl|ixgb|txp|vx|lge|nge|pcn|re|rl|sf|sis|sk|ste|ti|tl|tx|vge|vr|wb|cs|ex|ep|fe|ie|lnc|sn|xe|le|an|awi|wi|ndis|wl|aue|axe|cue|kue|rue|fwe|nve|hme|ath|iwi|ipw|ral|ural|my)[0-9]/)
  {
    $types_cache{$dev} = "ethernet";
  }
  elsif ($dev =~ /irlan[0-9]/)
  {
    $types_cache{$dev} = "irlan";
  }
  elsif ($dev =~ /plip[0-9]/)
  {
    $types_cache{$dev} = "plip";
  }
  elsif ($dev =~ /lo[0-9]?/)
  {
    $types_cache{$dev} = "loopback";
  }

  return $types_cache{$dev};
}

sub get_sunos_freebsd_interfaces_info
{
  my ($command) = @_;
  my ($dev, %ifaces, $fd);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_iface_active_get");

  $fd = &Utils::File::run_pipe_read ($command);
  return {} if $fd eq undef;
  
  while (<$fd>)
  {
    chomp;
    if (/^([^ \t:]+):.*(<.*>)/)
    {
      $dev = $1;
      $ifaces{$dev}{"dev"}    = $dev;
      $ifaces{$dev}{"enabled"} = 1 if ($2 =~ /[<,]UP[,>]/);
    }
    
    s/^[ \t]+//;
    if ($dev)
    {
      $ifaces{$dev}{"hwaddr"}  = $1 if /ether[ \t]+([^ \t]+)/i;
      $ifaces{$dev}{"addr"}    = $1 if /inet[ \t]+([^ \t]+)/i;
      $ifaces{$dev}{"mask"}    = $1 if /netmask[ \t]+([^ \t]+)/i;
      $ifaces{$dev}{"bcast"}   = $1 if /broadcast[ \t]+([^ \t]+)/i;
    }
  }
  
  &Utils::File::close_file ($fd);
  &Utils::Report::leave ();
  return %ifaces;
}

sub get_freebsd_interfaces_info
{
  return &get_sunos_freebsd_interfaces_info ("ifconfig");
}

sub get_sunos_interfaces_info
{
  return &get_sunos_freebsd_interfaces_info ("ifconfig -a");
}

sub get_linux_interfaces_info
{
  my ($dev, %ifaces, $fd);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_iface_active_get");

  $fd = &Utils::File::run_pipe_read ("ifconfig -a");
  return {} if $fd eq undef;
  
  while (<$fd>)
  {
    chomp;
    if (/^([^ \t:]+)/)
    {
      $dev = $1;
      $ifaces{$dev}{"enabled"} = 0;
      $ifaces{$dev}{"dev"}    = $dev;
    }
    
    s/^[ \t]+//;
    if ($dev)
    {
      $ifaces{$dev}{"hwaddr"}  = $1 if /HWaddr[ \t]+([^ \t]+)/i;
      $ifaces{$dev}{"addr"}    = $1 if /addr:([^ \t]+)/i;
      $ifaces{$dev}{"mask"}    = $1 if /mask:([^ \t]+)/i;
      $ifaces{$dev}{"bcast"}   = $1 if /bcast:([^ \t]+)/i;
      $ifaces{$dev}{"enabled"} = 1  if /^UP[ \t]/i;
    }
  }
  
  &Utils::File::close_file ($fd);
  &Utils::Report::leave ();
  return %ifaces;
}

sub get_interfaces_info
{
  my (%ifaces, $type);

  return &get_linux_interfaces_info if ($Utils::Backend::tool{"system"} eq "Linux");
  return &get_freebsd_interfaces_info if ($Utils::Backend::tool{"system"} eq "FreeBSD");
  return &get_sunos_interfaces_info if ($Utils::Backend::tool{"system"} eq "SunOS");
  return undef;
}

# boot method parsing/replacing
sub get_rh_bootproto
{
  my ($file, $key) = @_;
  my %rh_to_proto_name =
	 (
	  "bootp"  => "bootp",
	  "dhcp"   => "dhcp",
    "pump"   => "pump",
	  "none"   => "static",
    "static" => "static"
	  );
  my $ret;

  $ret = &Utils::Parse::get_sh ($file, $key);
  
  if (!exists $rh_to_proto_name{$ret})
  {
    &Utils::Report::do_report ("network_bootproto_unsup", $file, $ret);
    $ret = "none";
  }
  return $rh_to_proto_name{$ret};
}

sub set_rh_bootproto
{
  my ($file, $key, $value) = @_;
  my %proto_name_to_rh =
	 (
	  "bootp"    => "bootp",
	  "dhcp"     => "dhcp",
    "pump"     => "pump",
	  "none"     => "none",
    "static"   => "static"
	  );

  return &Utils::Replace::set_sh ($file, $key, $proto_name_to_rh{$value});
}

sub get_debian_bootproto
{
  my ($file, $iface) = @_;
  my (@stanzas, $stanza, $method, $bootproto);
  my %debian_to_proto_name =
      (
       "bootp"    => "bootp",
       "dhcp"     => "dhcp",
       "loopback" => "none",
       "ppp"      => "none",
       "static"   => "static",
       "ipv4ll"   => "ipv4ll",
       );

  &Utils::Report::enter ();
  @stanzas = &Utils::Parse::get_interfaces_stanzas ($file, "iface");

  foreach $stanza (@stanzas)
  {
    if (($$stanza[0] eq $iface) && ($$stanza[1] eq "inet"))
    {
      $method = $$stanza[2];
      last;
    }
  }

  if (exists $debian_to_proto_name {$method})
  {
    $bootproto = $debian_to_proto_name {$method};
  }
  else
  {
    $bootproto = "none";
    &Utils::Report::do_report ("network_bootproto_unsup", $method, $iface);
  }

  &Utils::Report::leave ();
  return $bootproto;
}

sub set_debian_bootproto
{
  my ($file, $iface, $value) = @_;
  my (@stanzas, $stanza, $method, $bootproto);
  my %proto_name_to_debian =
      (
       "bootp"    => "bootp",
       "dhcp"     => "dhcp",
       "loopback" => "loopback",
       "ppp"      => "ppp",
       "none"     => "static",
       "ipv4ll"   => "ipv4ll",
       "static"   => "static",
       );

  my %dev_to_method = 
      (
       "lo" => "loopback",
       "ppp" => "ppp",
       "ippp" => "ppp"
       );

  foreach $i (keys %dev_to_method)
  {
    $value = $dev_to_method{$i} if $iface =~ /^$i/;
  }

  return &Utils::Replace::set_interfaces_stanza_value ($file, $iface, 2, $proto_name_to_debian{$value});
}

sub get_slackware_bootproto
{
  my ($file, $iface) = @_;

  if (&Utils::Parse::get_rcinet1conf_bool ($file, $iface, USE_DHCP))
  {
    return "dhcp"
  }
  else
  {
    return "static";
  }
}

sub set_slackware_bootproto
{
    my ($file, $iface, $value) = @_;

    if ($value eq "dhcp")
    {
      &Utils::Replace::set_rcinet1conf ($file, $iface, USE_DHCP, "yes");
    }
    else
    {
      &Utils::Replace::set_rcinet1conf ($file, $iface, USE_DHCP);
    }
}

sub get_bootproto
{
  my ($file, $key) = @_;
  my ($str);

  $str = &Utils::Parse::get_sh ($file, $key);

  return "dhcp"  if ($key =~ /dhcp/i);
  return "bootp" if ($key =~ /bootp/i);
  return "static";
}

sub set_suse_bootproto
{
  my ($file, $key, $value) = @_;
  my %proto_name_to_suse90 =
     (
      "dhcp"     => "dhcp",
      "bootp"    => "bootp",
      "static"   => "static",
     );

  return &Utils::Replace::set_sh ($file, $key, $proto_name_to_suse90{$value});
}

sub get_gentoo_bootproto
{
  my ($file, $dev) = @_;

  return "dhcp" if (&Utils::Parse::get_confd_net ($file, "config_$dev") =~ /dhcp/i);
  return "static";
}

sub set_gentoo_bootproto
{
  my ($file, $dev, $value) = @_;

  return if ($dev =~ /^ppp/);

  return &Utils::Replace::set_confd_net ($file, "config_$dev", "dhcp") if ($value eq "dhcp");

  # replace with a fake IP address, it will be replaced
  # later with the correct one, I know it's a hack
  return &Utils::Replace::set_confd_net ($file, "config_$dev", "0.0.0.0");
}

sub set_freebsd_bootproto
{
  my ($file, $dev, $value) = @_;

  return &Utils::Replace::set_sh ($file, "ifconfig_$dev", "dhcp") if ($value eq "dhcp");
  return &Utils::Replace::set_sh ($file, "ifconfig_$dev", "");
}

sub get_sunos_bootproto
{
  my ($dhcp_file, $dev) = @_;
  return (&Utils::File::exists ($dhcp_file)) ? "dhcp" : "static";
}

sub set_sunos_bootproto
{
  my ($dhcp_file, $file, $iface, $value) = @_;

  if ($value eq "dhcp")
  {
    &Utils::File::save_buffer ("", $file);
    &Utils::File::run ("touch $dhcp_file");
  }
  else
  {
    &Utils::File::remove ($dhcp_file);
  }
}

# Functions to get the system interfaces, these are distro dependent
sub sysconfig_dir_get_existing_ifaces
{
  my ($dir) = @_;
  my (@ret, $i, $name);
  local *IFACE_DIR;
  
  if (opendir IFACE_DIR, "$gst_prefix/$dir")
  {
    foreach $i (readdir (IFACE_DIR))
    {
      push @ret, $1 if ($i =~ /^ifcfg-(.+)$/);
    }

    closedir (IFACE_DIR);
  }

  return \@ret;
}

sub get_existing_rh62_ifaces
{
  return @{&sysconfig_dir_get_existing_ifaces ("/etc/sysconfig/network-scripts")};
}

sub get_existing_rh72_ifaces
{
  my ($ret, $arr);
  
  # This syncs /etc/sysconfig/network-scripts and /etc/sysconfig/networking
  &Utils::File::run ("redhat-config-network-cmd");
  
  $ret = &sysconfig_dir_get_existing_ifaces
      ("/etc/sysconfig/networking/profiles/default");
  $arr = &sysconfig_dir_get_existing_ifaces
      ("/etc/sysconfig/networking/devices");

  &Utils::Util::arr_merge ($ret, $arr); 
  return @$ret;
}

sub get_existing_suse_ifaces
{
  return @{&sysconfig_dir_get_existing_ifaces ("/etc/sysconfig/network")};
}

sub get_existing_pld_ifaces
{
  return @{&sysconfig_dir_get_existing_ifaces ("/etc/sysconfig/interfaces")};
}

sub get_pap_passwd
{
  my ($file, $login) = @_;
  my (@arr, $passwd);

  $login = '"?' . $login . '"?';
  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_get_pap_passwd", $login, $file);
  $arr = &Utils::Parse::split_first_array ($file, $login, "[ \t]+", "[ \t]+");

  $passwd = $$arr[1];
  &Utils::Report::leave ();

  $passwd =~ s/^\"([^\"]*)\"$/$1/;

  return $passwd;
}

sub set_pap_passwd
{
  my ($file, $login, $passwd) = @_;
  my ($line);

  $login = '"' . $login . '"';
  $passwd = '"'. $passwd . '"';
  $line = "* $passwd";

  return &Utils::Replace::split ($file, $login, "[ \t]+", $line);
}

sub get_wep_key_type
{
  my ($func) = shift @_;
  my ($val);

  $val = &$func (@_);

  return "wep-ascii" if ($val =~ /^s\:/);
  return "wep-hex";
}

sub get_debian_key_type
{
  my ($file, $iface) = @_;
  my ($val);

  $val = &Utils::Parse::get_interfaces_option_str ($file, $iface, "wireless[_-]key1?");

  if ($val)
  {
    return "wep-ascii" if ($val =~ /^s\:/);
    return "wep-hex";
  }

  $val = &Utils::Parse::get_interfaces_option_str ($file, $iface, "wpa-psk");
  return "wpa-psk";
}

sub get_wep_key
{
  my ($func) = shift @_;
  my ($val);

  $val = &$func (@_);
  $val =~ s/^s\://;

  return $val;
}

sub set_wep_key_full
{
  my ($key, $key_type, $func);

  # seems kind of hackish, but we want to use distro
  # specific saving functions, so we need to leave
  # the args as variable as possible
  $func = shift @_;
  $key_type = pop @_;
  $key = pop @_;

  if ($key_type eq "wep-ascii")
  {
    $key = "s:" . $key;
  }

  push @_, $key;
  &$func (@_);
}

sub get_encrypted_wpa_psk
{
  my ($key, $essid) = @_;
  my ($output);

  # FIXME: not good to pass directly keys to processes,
  # probably the network one won't be so important
  # to keep secret to other users.
  $output = &Utils::File::run_backtick ("wpa_passphrase $essid $key");

  if ($output =~ /\tpsk=(.*)\n/)
  {
    return $1;
  }

  return undef;
}

sub set_debian_key
{
  my ($file, $iface, $key, $essid, $key_type) = @_;
  my ($psk);

  #remove undesired options, due to syntax duality
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless-key", "");
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless-key1", "");
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless_key", "");
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless_key1", "");

  #remove all wpa related keys
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-psk", "");
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-driver", "");
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-key-mgmt", "");
  &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-proto", "");

  if ($key_type =~ /^wep/)
  {
    &Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless-key",
                                                ($key && $key_type eq "wep-ascii") ? "s:" . $key : $key);
  }
  elsif ($key_type =~ /^wpa/)
  {
    if ($key)
    {
      $psk = &get_encrypted_wpa_psk ($key, $essid);
      &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-psk", $psk);
      &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-driver", "wext");
      &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-key-mgmt", "WPA-PSK");

      if ($key_type =~ /^wpa2/)
      {
        &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-proto", "WPA2");
      }
      else
      {
        &Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-proto", "WPA");
      }
    }
  }
}

sub set_debian_essid
{
  my ($file, $iface, $key_type, $key, $essid) = @_;

  Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless-essid", "");
  Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-ssid", "");

  if (!$key || $key_type =~ /^wep/)
  {
    Utils::Replace::set_interfaces_option_str ($file, $iface, "wireless-essid", $essid);
  }
  elsif ($key_type =~ /^wpa/)
  {
    Utils::Replace::set_interfaces_option_str ($file, $iface, "wpa-ssid", $essid);
  }
}

sub get_modem_volume
{
  my ($file) = @_;
  my ($volume);

  $volume = &Utils::Parse::get_from_chatfile ($file, "AT.*(M0|L[1-3])");

  return 0 if ($volume eq undef);

  $volume =~ s/^[ml]//i;
  return $volume;
}

sub check_type
{
  my ($type) = shift @_;
  my ($expected_type) =  shift @_;
  my ($func) =  shift @_;

  if ($type =~ "^$expected_type")
  {
    &$func (@_);
  }
}

# Distro specific helper functions
sub get_debian_auto_by_stanza
{
  my ($file, $iface) = @_;
  my (@stanzas, $stanza, $i);

  @stanzas = &Utils::Parse::get_interfaces_stanzas ($file, "auto");

  foreach $stanza (@stanzas)
  {
    foreach $i (@$stanza)
    {
      return $stanza if $i eq $iface;
    }
  }

  return undef;
}

sub get_debian_auto
{
  my ($file, $iface) = @_;

  return (&get_debian_auto_by_stanza ($file, $iface) ne undef)? 1 : 0;
}

sub set_debian_auto
{
  my ($file, $iface, $value) = @_;
  my ($buff, $line_no, $found);

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $line_no = 0;

  while (($found = &Utils::Replace::interfaces_get_next_stanza ($buff, \$line_no, "auto")) >= 0)
  {
    if ($value)
    {
      if ($$buff[$line_no] =~ /[ \t]$iface([\# \t\n])/)
      {
        return &Utils::File::save_buffer ($buff, $file);
      }
    }
    else
    {
      # I'm including the hash here, although the man page says it's not supported.
      last if $$buff[$line_no] =~ s/[ \t]$iface([\# \t\n])/$1/;
    }
		
		$line_no ++;
  }

  if ($found < 0 && $value)
  {
    &Utils::Replace::interfaces_auto_stanza_create ($buff, $iface);
  }
  else
  {
    if ($value)
    {
      chomp $$buff[$line_no];
      $$buff[$line_no] .= " $iface\n";
    }
    $$buff[$line_no] =~ s/auto[ \t]*$//;
  }
  
  return &Utils::File::save_buffer ($buff, $file);
}

sub get_debian_remote_address
{
  my ($file, $iface) = @_;
  my ($str, @tuples, $tuple, @res);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_get_remote", $iface);
  
  @tuples = &Utils::Parse::get_interfaces_option_tuple ($file, $iface, "up", 1);

  &Utils::Report::leave ();
  
  foreach $tuple (@tuples)
  {
    @res = $$tuple[1] =~ /[ \t]+pointopoint[ \t]+([^ \t]+)/;
    return $res[0] if $res[0];
  }

  return undef;
}

sub set_debian_remote_address
{
  my ($file, $iface, $value) = @_;
  my ($ifconfig, $ret);
  
  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_set_remote", $iface);
  
  $ifconfig = &Utils::File::locate_tool ("ifconfig");

  $ret = &Utils::Replace::set_interfaces_option_str ($file, $iface, "up",
                                                     "$ifconfig $iface pointopoint $value");
  &Utils::Report::leave ();
  return $ret;
}

sub get_suse_dev_name
{
  my ($iface) = @_;
  my ($ifaces, $dev, $hwaddr);
  my ($dev);

  $dev = &Utils::Parse::get_sh ("/var/run/sysconfig/if-$iface", "interface");

  if ($dev eq undef)
  {
    $dev = &Utils::File::run_backtick ("getcfg-interface $iface");
  }

  # FIXME: is all this necessary? getcfg-interface should give us what we want
  if ($dev eq undef)
  {
    # Those are the last cases, we make rough guesses
    if ($iface =~ /-pcmcia-/)
    {
      # it's something like wlan-pcmcia-0
      $dev =~ s/-pcmcia-//;
    }
    elsif ($iface =~ /-id-([a-fA-F0-9\:]*)/)
    {
      # it's something like eth-id-xx:xx:xx:xx:xx:xx, which is the NIC MAC
      $hwaddr = $1;
      $ifaces = &get_interfaces_info ();

      foreach $d (keys %$ifaces)
      {
        if ($hwaddr eq $$ifaces{$d}{"hwaddr"})
        {
          $dev = $d;
          last;
        }
      }
    }
  }

  if ($dev eq undef)
  {
    # We give up, take $iface as $dev
    $dev = $iface;
  }

  return $dev;
}

sub get_suse_auto
{
  my ($file, $key) = @_;
  my ($ret);

  $ret = &Utils::Parse::get_sh ($file, $key);

  return 1 if ($ret =~ /^onboot$/i);
  return 0;
}

sub set_suse_auto
{
  my ($file, $key, $enabled) = @_;
  my ($ret);

  return &Utils::Replace::set_sh($file, $key,
                                 ($enabled) ? "onboot" : "manual");
}

sub get_suse_gateway
{
  my ($file, $address, $netmask) = @_;
  my ($gateway) = &Utils::Parse::split_first_array_pos ($file, "default", 0, "[ \t]+", "[ \t]+");

  return $gateway if &is_ip_in_same_network ($address, $gateway, $netmask);
  return undef;
}

# Return IP address or netmask, depending on $what
# FIXME: This function could be used in other places than PLD,
# calculates netmask given format 1.1.1.1/128
sub get_pld_ipaddr
{
  my ($file, $key, $what) = @_;
  my ($ipaddr, $netmask, $ret, $i);
	my @netmask_prefixes = (0, 128, 192, 224, 240, 248, 252, 254, 255);
  
  $ipaddr = &Utils::Parse::get_sh($file, $key);
  return undef if $ipaddr eq "";
  
  if($ipaddr =~ /([^\/]*)\/([[:digit:]]*)/)
  {
    $netmask = $2;
    return undef if $netmask eq "";

    if($what eq "address")
    {
      return $1;
    }

    for($i = 0; $i < int($netmask/8); $i++)
    {
      $ret .= "255.";
    }

    $ret .= "$netmask_prefixes[$b%8]." if $netmask < 32;

    for($i = int($netmask/8) + 1; $i < 4; $i++)
    {
      $ret .= "0.";
    }

    chop($ret);
    return $ret;
  }
  return undef;
}

sub set_pld_ipaddr
{
  my ($file, $key, $what, $value) = @_;
  my %prefixes =
  (
    "0"   => 0,
    "128" => 1,
    "192" => 2,
    "224" => 3,
    "240" => 4,
    "248" => 5,
    "252" => 6,
    "254" => 7,
    "255" => 8
  );
  my ($ipaddr, $netmask);

  $ipaddr = &Utils::Parse::get_sh($file, $key);
  return undef if $ipaddr eq "";

  if($what eq "address")
  {
    $ipaddr =~ s/.*\//$value\//;
  }
	else
  {
    if($value =~ /([[:digit:]]*).([[:digit:]]*).([[:digit:]]*).([[:digit:]]*)/)
    {
      $netmask = $prefixes{$1} + $prefixes{$2} + $prefixes{$3} + $prefixes{$4};
      $ipaddr =~ s/\/[[:digit:]]*/\/$netmask/;
    }
  }

  return &Utils::Replace::set_sh($file, $key, $ipaddr);
}

sub get_gateway
{
  my ($file, $key, $address, $netmask) = @_;
  my ($gateway);

  return undef if ($address eq undef);

  $gateway = &Utils::Parse::get_sh ($file, $key);

  return $gateway if &is_ip_in_same_network ($address, $gateway, $netmask);
  return undef;
}

sub get_sunos_auto
{
  my ($file, $iface) = @_;
  return &Utils::File::exists ($file);
}

sub lookup_host
{
  my ($file) = @_;
  my ($arr, $h);

  $arr = &Network::Hosts::get_hosts ();

  foreach $h (@$arr)
  {
    my ($ip, $aliases) = @$h;
    my ($alias);

    foreach $alias (@$aliases)
    {
      return $ip if ($alias eq $host)
    }
  }
}

sub lookup_ip
{
  my ($ip) = @_;
  my ($hosts);

  $hosts = &Utils::Parse::split_hash ("/etc/hosts", "[ \t]+", "[ \t]+");
  return @{$$hosts{$ip}}[0] if (exists $$hosts{$ip});

  if ($Utils::Backend::tool {"system"} eq "SunOS")
  {
    $hosts = &Utils::Parse::split_hash ("/etc/inet/ipnodes", "[ \t]+", "[ \t]+");
    return @{$$hosts{$ip}}[0] if (exists $$hosts{$ip});
  }
}

sub get_sunos_hostname_iface_value
{
  my ($file, $re) = @_;
  my (@buff, $i);

  $buff = &Utils::File::load_buffer ($file);
  &Utils::File::join_buffer_lines ($buff);
  $i = 0;

  while ($$buff[$i])
  {
    return $1 if ($$buff[$i] =~ "$re");
    $i++;
  }
}

sub get_sunos_address
{
  my ($file, $dev) = @_;
  my ($address);

  $address = &get_sunos_hostname_iface_value ($file, "^\s*([0-9.]+)\s*");
  return $address if ($address);

  $address = &get_sunos_hostname_iface_value ($file, "^\s*([0-9a-zA-Z-_]+)\s*");
  return &lookup_host ($address);
}

sub set_sunos_address
{
  my ($file, $dev, $addr) = @_;
  my ($buf, $host);

  if (&Utils::File::exists ($file))
  {
    $buf = &Utils::File::read_joined_lines ($file);
    $host = &lookup_ip ($addr);

    if ($buf =~ /^(\s*[0-9\.]+)\s+/ ||
        $buf =~ /^(\s*[0-9a-zA-Z\-_]+)\s/)
    {
      $buf =~ s/$1/$addr/;
      &Utils::File::save_buffer ($buf, $file);
      return;
    }
  }

  # save address from scratch
  &Utils::File::save_buffer ($addr, $file);
}

sub get_sunos_netmask
{
  my ($file, $dev, $use_dhcp) = @_;
  my ($buf);

  $buf = &Utils::File::read_joined_lines ($file);

  if ($buf =~ /\s+netmask\s+([0-9.]+)\s*/)
  {
    return $1;
  }

  return "255.0.0.0" if ($use_dhcp ne "dhcp");
}

sub set_sunos_netmask
{
  my ($file, $masks_file, $dev, $addr, $mask) = @_;
  my ($buff, $i, $network, $found);

  # modify /etc/netmasks
  $network = &Utils::Util::ip_calc_network ($addr, $mask);
  $buff = &Utils::File::load_buffer ($masks_file);
  $found = 0;
  $i = 0;

  while ($$buff[$i])
  {
    if ($$buff[$i] =~ /\s*$network\s+.+/)
    {
      $$buff[$i] = "$network\t$mask";
      $found = 1;
    }

    $i++;
  }

  push @$buff, "$network\t$mask" if (!$found);
  &Utils::File::save_buffer ($buff, $masks_file);

  # modify hostname.$dev
  $buff = &Utils::File::read_joined_lines ($file);

  if ($buff =~ /\s*(netmask [0-9\.]+)/)
  {
    $buff =~ s/$1/netmask $mask/;
  }
  else
  {
    $buff .= " netmask $mask";
  }

  &Utils::File::save_buffer ($buff, $file);
}

sub get_sunos_gateway
{
  my ($file, $dev) = @_;
  my ($line);

  my $line = &Utils::Parse::get_first_line ($file);

  if ($line =~ /^\s*([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\s*/)
  {
    return $1;
  }
  elsif ($buf =~ /^\s*([0-9a-zA-Z-_]+)\s*/)
  {
    return &lookup_host ($1);
  }
}

sub set_sunos_gateway
{
  my ($file, $dev, $gateway) = @_;
  &Utils::File::save_buffer ("$gateway\n", $file);
}

sub get_sunos_wireless
{
  my ($dev, $opt) = @_;
  my ($fd, $essid, $key_type);
  
  $fd = &Utils::File::run_pipe_read ("wificonfig -i $dev");
  return if (!$fd);

  while (<$fd>)
  {
    if (/$opt:\s+(.*)/)
    {
      return $1;
    }
  }

  &Utils::File::close_file ($fd);
  return;
}

sub set_sunos_wireless
{
  my ($dev, $opt, $essid, $value) = @_;
  my ($profile);

  my $profile = &get_sunos_profile_from_essid ($essid);

  if ($opt eq "essid")
  {
    &Utils::File::run ("wificonfig setprofileparam $profile essid='$value'");
  }
  elsif ($opt eq "key_type")
  {
    $value = "wep" if ($value ne "none");
    &Utils::File::run ("wificonfig setprofileparam $profile encryption=$value");
  }
  elsif ($opt eq "key")
  {
    &Utils::File::run ("wificonfig setprofileparam $profile wepkey1=$value");
    &Utils::File::run ("wificonfig setprofileparam $profile wepkeyindex=1");
  }
}

sub get_sunos_real_wep_key
{
  my ($secret, $profile, $index) = @_;

  $index--; 
  $index = 0 if ($index < 0);

  my @wificonfig_profiles = &Utils::Parse::get_ini_sections ($secret);
  return undef unless (grep (/^$profile$/, @wificonfig_profiles));

  return &Utils::Parse::get_ini ($secret, $profile, "wepkey$index");
}

sub get_sunos_profile_from_essid
{
  my ($essid) = @_;
  my ($profilename);

  $profilename = $essid;
  $profilename =~ s/\W/_/g;

  $profilename = "gst-default" unless ( $profilename );
  return $profilename
}

sub get_sunos_wireless_key
{
  my ($secret, $dev) = @_;
  my ($essid, $index, $profile);

  $essid = &get_sunos_wireless ($dev, "essid");
  $index = &get_sunos_wireless ($dev, "wepkeyindex");
  $profile = &get_sunos_profile_from_essid ($essid);
  
  return &get_sunos_real_wep_key ($secret, $profile, $index);
}

sub get_freebsd_auto
{
  my ($file, $defaults_file, $iface) = @_;
  my ($val);

  $val = &Utils::Parse::get_sh ($file, "network_interfaces");
  $val = &Utils::Parse::get_sh ($defaults_file, "network_interfaces") if ($val eq undef);

  return 1 if ($val eq "auto");
  return 1 if ($val =~ /$iface/);
  return 0;
}

sub set_freebsd_auto
{
  my ($file, $iface, $active) = @_;
  my ($val);

  $val = &Utils::Parse::get_sh ($file, "network_interfaces");
  $val = &Utils::File::run_backtick ("ifconfig -l") if ($val =~ /auto/);
  $val .= " ";

  if ($active && ($val !~ /$iface /))
  {
    $val .= $iface;
  }
  elsif (!$active && ($val =~ /$iface /))
  {
    $val =~ s/$iface //;
  }

  # Trim the string
  $val =~ s/^[ \t]*//;
  $val =~ s/[ \t]*$//;

  &Utils::Replace::set_sh ($file, "network_interfaces", $val);
}

sub get_freebsd_ppp_persist
{
  my ($startif, $iface) = @_;
  my ($val);

  if ($iface =~ /^tun[0-9]+/)
  {
    $val = &Utils::Parse::get_startif ($startif, "ppp[ \t]+\-(auto|ddial)[ \t]+");

    return 1 if ($val eq "ddial");
    return 0;
  }

  return undef;
}

# we need this function because essid can be
# multiword, and thus it can't be in rc.conf
sub set_freebsd_essid
{
  my ($file, $startif, $iface, $essid) = @_;

  if ($essid =~ /[ \t]/)
  {
    # It's multiword
    &Utils::File::save_buffer ("ifconfig $iface ssid \"$essid\"", $startif);
    &Utils::Replace::set_sh_re ($file, "ifconfig_$iface", "ssid[ \t]+([^ \t]*)", "");
  }
  else
  {
    &Utils::Replace::set_sh_re ($file, "ifconfig_$iface", "ssid[ \t]+([^ \t]*)", " ssid $essid");
  }
}

sub interface_changed
{
  my ($iface, $old_iface) = @_;
  my ($key);

  foreach $key (keys %$iface)
  {
    next if ($key eq "enabled");
    return 1 if ($$iface{$key} ne $$old_iface{$key});
  }

  return 0;
}

sub activate_interface_by_dev
{
  my ($dev, $enabled) = @_;

  &Utils::Report::enter ();

  if ($enabled)
  {
    &Utils::Report::do_report ("network_iface_activate", $dev);
    return -1 if &Utils::File::run ("ifup $dev");
  }
  else
  {
    &Utils::Report::do_report ("network_iface_deactivate", $dev);
    return -1 if &Utils::File::run ("ifdown $dev");
  }
  
  &Utils::Report::leave ();

  return 0;
}

# This works for all systems that have ifup/ifdown scripts.
sub activate_interface
{
  my ($hash, $old_hash, $enabled, $force) = @_;
  my ($dev);

  if ($force || &interface_changed ($hash, $old_hash))
  {
    $dev = ($$hash{"file"}) ? $$hash{"file"} : $$hash{"dev"};
    &activate_interface_by_dev ($dev, $enabled);
  }
}

# FIXME: can this function be mixed with the above?
sub activate_suse_interface
{
  my ($hash, $old_hash, $enabled, $force) = @_;
  my ($iface, $dev);

  if ($force || &interface_changed ($hash, $old_hash))
  {
    $dev = ($$hash{"file"}) ? &get_suse_dev_name ($$hash{"file"}) : $$hash{"dev"};
    &activate_interface_by_dev ($dev, $enabled);
  }
}

sub activate_slackware_interface_by_dev
{
  my ($dev, $enabled) = @_;
  my ($command, $ret);

  &Utils::Report::enter ();

  $command = "/etc/rc.d/rc.inet1 ";
  $command .= $dev;

  if ($enabled)
  {
    &Utils::Report::do_report ("network_iface_activate", $dev);
    $command .= "_start";
  }
  else
  {
    &Utils::Report::do_report ("network_iface_deactivate", $dev);
    $command .= "_stop";
  }

  $ret = &Utils::File::run ($command);

  &Utils::Report::leave ();
  return -1 if ($ret != 0);
  return 0;
}

sub activate_slackware_interface
{
  my ($hash, $old_hash, $enabled, $force) = @_;
  my $dev = $$hash{"file"};

  if ($force || &interface_changed ($hash, $old_hash))
  {
    &activate_slackware_interface_by_dev ($dev, $enabled);
  }
}

sub activate_gentoo_interface_by_dev
{
  my ($dev, $enabled) = @_;
  my $file = "/etc/init.d/net.$dev";
  my $action = ($enabled == 1)? "start" : "stop";

  return &Utils::File::run ("$file $action");
}

sub activate_gentoo_interface
{
  my ($hash, $old_hash, $enabled, $force) = @_;
  my $dev = $$hash{"file"};

  if ($force || &interface_changed ($hash, $old_hash))
  {
    &activate_gentoo_interface_by_dev ($dev, $enabled);
  }
}

sub activate_freebsd_interface_by_dev
{
  my ($hash, $enabled) = @_;
  my ($dev)     = $$hash{"file"};
  my ($startif) = "/etc/start_if.$dev";
  my ($file)    = "/etc/rc.conf";
  my ($command, $dhcp_flags, $defaultroute, $fd);

  if ($enabled)
  {
    # Run the /etc/start_if.$dev commands
    $fd = &Utils::File::open_read_from_names ($startif);

    while (<$fd>)
    {
      `$_`;
    }

    &Utils::File::close_file ($fd);
    $command = &Utils::Parse::get_sh ($file, "ifconfig_$dev");

    # Bring up the interface
    if ($command =~ /DHCP/i)
    {
      $dhcp_flags = &Utils::Parse::get_sh ($file, "dhcp_flags");
      &Utils::File::run ("dhclient $dhcp_flags $dev");
    }
    else
    {
      &Utils::File::run ("ifconfig $dev $command");
    }

    # Add the default route
    $default_route = &Utils::Parse::get_sh ($file, "defaultrouter");
    &Utils::File::run ("route add default $default_route") if ($default_route !~ /^no$/i);
  }
  else
  {
    &Utils::File::run ("ifconfig $dev down");
  }
}

sub activate_freebsd_interface
{
  my ($hash, $old_hash, $enabled, $force) =@_;

  if ($force || &interface_changed ($hash, $old_hash))
  {
    &activate_freebsd_interface_by_dev ($hash, $enabled);
  }
}

sub activate_sunos_interface
{
  my ($hash, $old_hash, $enabled, $force) =@_;
  my ($dev) = $$hash{"dev"};

  if ($force || &interface_changed ($hash, $old_hash))
  {
    if ($enabled)
    {
      &Utils::File::run ("svcadm restart svc:/network/physical"); # Restart physical network interfaces 
      &Utils::File::run ("svcadm restart svc:/network/service"); # Restart name services
    }
    else 
    {
      #&Utils::File::run ("ifconfig $dev unplumb");
      &Utils::File::run ("svcadm restart svc:/network/physical"); # Restart physical network interfaces 
      &Utils::File::run ("svcadm restart svc:/network/service"); # Restart name services
    }
  }
}

sub remove_pap_entry
{
  my ($file, $login) = @_;
  my ($i, $buff);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_remove_pap", $file, $login);
  
  $buff = &Utils::File::load_buffer ($file);

  foreach $i (@$buff)
  {
    $i = "" if ($i =~ /^[ \t]*$login[ \t]/);
  }

  &Utils::File::clean_buffer ($buff);
  &Utils::Report::leave ();
  return &Utils::File::save_buffer ($buff, $file);
}

sub delete_rh62_interface
{
  my ($old_hash) = @_;
  my ($dev, $login);

  $dev = $$old_hash{"file"};
  $login = $old_hash{"login"};
  &activate_interface_by_dev ($dev, 0);

  if ($login)
  {
    &remove_pap_entry ("/etc/ppp/pap-secrets", $login);
    &remove_pap_entry ("/etc/ppp/chap-secrets", $login);
  }

  &Utils::File::remove ("/etc/sysconfig/network-scripts/ifcfg-$dev");
}

sub delete_rh72_interface
{
  my ($old_hash) = @_;
  my ($filedev, $dev, $login);

  $filedev = $$old_hash{"file"};
  $dev     = $$old_hash{"dev"};
  $login   = $$old_hash{"login"};
  
  &activate_interface_by_dev ($filedev, 0);

  if ($login)
  {
    &remove_pap_entry ("/etc/ppp/pap-secrets", $login);
    &remove_pap_entry ("/etc/ppp/chap-secrets", $login);
  }

  &Utils::File::remove ("/etc/sysconfig/networking/devices/ifcfg-$filedev");
  &Utils::File::remove ("/etc/sysconfig/networking/profiles/default/ifcfg-$filedev");
  &Utils::File::remove ("/etc/sysconfig/network-scripts/ifcfg-$dev");
 
  &Utils::File::run ("redhat-config-network-cmd");
}

sub delete_debian_interface
{
  my ($old_hash) = @_;
  my ($dev, $ppp_type);

  $dev = $$old_hash{"dev"};
  $ppp_type = $old_hash{"ppp_type"};

  &activate_interface_by_dev ($dev, 0);
  &Utils::Replace::interfaces_iface_stanza_delete ("/etc/network/interfaces", $dev);

  if ($ppp_type)
  {
    &remove_pap_entry ("/etc/ppp/pap-secrets", $login);
    &remove_pap_entry ("/etc/ppp/chap-secrets", $login);
  }
}

sub delete_suse_interface
{
  my ($old_hash) = @_;
  my ($file, $provider, $dev);

  $file = $$old_hash{"file"};
  $dev = &get_suse_dev_name ($file);
  $provider = &Utils::Parse::get_sh ("/etc/sysconfig/network/ifcfg-$file", PROVIDER);

  activate_interface_by_dev ($dev, 0);

  &Utils::File::remove ("/etc/sysconfig/network/ifroute-$file");
  &Utils::File::remove ("/etc/sysconfig/network/ifcfg-$file");
  &Utils::File::remove ("/etc/sysconfig/network/providers/$provider");
}

sub delete_pld_interface
{
  my ($old_hash) = @_;
  my ($dev, $login);

  my $dev = $$old_hash{"file"};
  my $login = $$old_hash{"login"};
  &activate_interface_by_dev ($dev, 0);
                                                                                
  if ($login)
  {
    &remove_pap_entry ("/etc/ppp/pap-secrets", $login);
    &remove_pap_entry ("/etc/ppp/chap-secrets", $login);
  }
                                                                                
  &Utils::File::remove ("/etc/sysconfig/interfaces/ifcfg-$dev");
}

sub delete_slackware_interface
{
  my ($old_hash) = @_;
  my ($rcinetconf, $pppscript, $dev);
  my ($address, $netmask, $gateway);

  $rcinetconf = "/etc/rc.d/rc.inet1.conf";
  $pppscript = "/etc/ppp/pppscript";
  $dev = $$old_hash {"dev"};

  if ($dev =~ /^ppp/)
  {
    &Utils::File::remove ($pppscript);
  }
  else
  {
    $address = &Utils::Parse::get_rcinet1conf ($rcinetconf, $dev, "IPADDR");
    $netmask = &Utils::Parse::get_rcinet1conf ($rcinetconf, $dev, "NETMASK");
    $gateway = &Utils::Parse::get_sh ($rcinetconf, "GATEWAY");

    # empty the values
    &Utils::Replace::set_rcinet1conf ($rcinetconf, $dev, "IPADDR", "");
    &Utils::Replace::set_rcinet1conf ($rcinetconf, $dev, "NETMASK", "");
    &Utils::Replace::set_rcinet1conf ($rcinetconf, $dev, "USE_DHCP", "");
    &Utils::Replace::set_rcinet1conf ($rcinetconf, $dev, "DHCP_HOSTNAME", "");

    if (&is_ip_in_same_network ($address, $gateway, $netmask))
    {
      &Utils::Replace::set_rcinet1conf_global ($rcinetconf, "GATEWAY", "");
    }
  }
}

sub delete_gentoo_interface
{
  my ($old_hash) = @_;
  my ($dev, $gateway);

  $dev = $$old_hash {"dev"};
  $gateway = $$old_hash {"gateway"};

  # bring down the interface and remove from init
  &Init::Services::set_gentoo_service_status ("/etc/init.d/net.$dev", "default", "stop");

  if ($dev =~ /^ppp/)
  {
    &Utils::File::remove ("/etc/conf.d/net.$dev");
  }
  else
  {
    &Utils::Replace::set_sh ("/etc/conf.d/net", "config_$dev", "");
  }
}

sub delete_freebsd_interface
{
  my ($old_hash) = @_;
  my ($dev, $startif, $pppconf);
  my ($buff, $line_no, $end_line_no, $i);

  $dev = $$old_hash{"dev"};
  $startif = "/etc/start_if.$dev";
  $pppconf = "/etc/ppp/ppp.conf";

  &Utils::File::run ("ifconfig $dev down");

  if ($dev =~ /^tun[0-9]+/)
  {
    # Delete the ppp.conf section
    $section = &Utils::Parse::get_startif ($startif, "ppp[ \t]+\-[^ \t]+[ \t]+([^ \t]+)");
    $buff = &Utils::File::load_buffer ($pppconf);

    $line_no     = &Utils::Parse::pppconf_find_stanza      ($buff, $section);
    $end_line_no = &Utils::Parse::pppconf_find_next_stanza ($buff, $line_no + 1);
    $end_line_no = scalar @$buff + 1 if ($end_line_no == -1);
    $end_line_no--;

    for ($i = $line_no; $i <= $end_line_no; $i++)
    {
      delete $$buff[$i];
    }

    &Utils::File::clean_buffer ($buff);
    &Utils::File::save_buffer ($buff, $pppconf);
  }
  
  &Utils::Replace::set_sh  ("/etc/rc.conf", "ifconfig_$dev", "");
  &Utils::File::remove ($startif);
}

sub delete_sunos_interface
{
  my ($old_hash) = @_;
  my ($dev);

  $dev = $$old_hash{"dev"};
  &Utils::File::remove ("/etc/hostname.$dev");
  &Utils::File::remove ("/etc/dhcp.$dev");
}

# FIXME: should move to external file!!!
sub create_chatscript
{
  my ($pppscript) = @_;
  my ($contents);

  if (!&Utils::File::exists ($pppscript))
  {
    # create a template file from scratch
    $contents  = 'TIMEOUT 60' . "\n";
    $contents .= 'ABORT ERROR' . "\n";
    $contents .= 'ABORT BUSY' . "\n";
    $contents .= 'ABORT VOICE' . "\n";
    $contents .= 'ABORT "NO CARRIER"' . "\n";
    $contents .= 'ABORT "NO DIALTONE"' . "\n";
    $contents .= 'ABORT "NO DIAL TONE"' . "\n";
    $contents .= 'ABORT "NO ANSWER"' . "\n";
    $contents .= '"" "ATZ"' . "\n";
    $contents .= '"" "AT&FH0"' . "\n";
    $contents .= 'OK-AT-OK "ATDT000000000"' . "\n";
    $contents .= 'TIMEOUT 75' . "\n";
    $contents .= 'CONNECT' . "\n";

    &Utils::File::save_buffer ($contents, $pppscript);
  }
}

#FIXME: should move to external file!!!
sub create_pppgo
{
  my ($pppgo) = "/usr/sbin/ppp-go";
  my ($contents, $pppd, $chat);
  local *FILE;

  if (!&Utils::File::exists ($pppgo))
  {
    $pppd = &Utils::File::locate_tool ("pppd");
    $chat = &Utils::File::locate_tool ("chat");
    
    # create a simple ppp-go from scratch
    # this script is based on the one that's created by pppsetup
    $contents  = "killall -INT pppd 2>/dev/null \n";
    $contents .= "rm -f /var/lock/LCK* /var/run/ppp*.pid \n";
    $contents .= "( $pppd connect \"$chat -v -f /etc/ppp/pppscript\") || exit 1 \n";
    $contents .= "exit 0 \n";

    &Utils::File::save_buffer ($contents, $pppgo);
    chmod 0777, "$gst_prefix/$pppgo";
  }
}

# FIXME: should move to external file!!!
sub create_gentoo_files
{
  my ($dev) = @_;
  my ($init) = "/etc/init.d/net.$dev";
  my ($conf) = "/etc/conf.d/net.$dev";
  my ($backup) = "/etc/conf.d/net.ppp0.gstbackup";

  if ($dev =~ /ppp/)
  {
    &Utils::File::copy_file ("/etc/init.d/net.ppp0", $init) if (!&Utils::File::exists ($init));

    # backup the ppp config file
    &Utils::File::copy_file ("/etc/conf.d/net.ppp0", $backup) if (!&Utils::File::exists ($backup));
    &Utils::File::copy_file ($backup, $conf) if (!&Utils::File::exists ($conf));
  }
  else
  {
    &Utils::File::copy_file ("/etc/init.d/net.eth0", $init) if (!&Utils::File::exists ($init));
  }

  chmod 0755, "$gst_prefix/$init";
}

# FIXME: should move to external file!!!
sub create_ppp_startif
{
  my ($startif, $iface, $dev, $persist) = @_;
  my ($section);

  if ($dev =~ /^tun[0-9]+/)
  {
    $section = &Utils::Parse::get_startif ($startif, "ppp[ \t]+\-[^ \t]+[ \t]+([^ \t]+)");
    $section = $dev if ($section eq undef);

    return &Utils::File::save_buffer ("ppp -ddial $section", $startif) if ($persist eq 1);
    return &Utils::File::save_buffer ("ppp -auto  $section", $startif);
  }
}

sub create_ppp_configuration
{
  my ($options, $chatscript, $type) = @_;

  if ($type eq "modem")
  {
    &create_chatscript ($chatscript);
  }
  elsif ($type eq "isdn")
  {
    &Utils::File::copy_file_from_stock ("general_isdn_ppp_options", $options);
  }
  elsif ($type eq "pppoe")
  {
    &Utils::File::copy_file_from_stock ("general_pppoe_ppp_options", $options);
  }
  elsif ($type eq "gprs")
  {
    &Utils::File::copy_file_from_stock ("general_ppp_options", $options);
    &Utils::File::copy_file_from_stock ("general_gprs_chatscript", $chatscript);
  }
}

sub set_modem_volume_sh
{
  my ($file, $key, $volume) = @_;
  my ($vol);

  if    ($volume == 0) { $vol = "ATM0" }
  elsif ($volume == 1) { $vol = "ATL1" }
  elsif ($volume == 2) { $vol = "ATL2" }
  else                 { $vol = "ATL3" }

  return &Utils::Replace::set_sh ($file, $key, $vol);
}

sub set_modem_volume
{
  my ($file, $volume) = @_;
  my $line;

  $line = &Utils::Parse::get_from_chatfile ($file, "AT([^DZ][a-z0-9&]+)");
  $line =~ s/(M0|L[1-3])//g;

  if    ($volume == 0) { $line .= "M0"; }
  elsif ($volume == 1) { $line .= "L1"; }
  elsif ($volume == 2) { $line .= "L2"; }
  else                 { $line .= "L3"; }

  return &Utils::Replace::set_chat ($file, "AT([^DZ][a-z0-9&]+)", $line);
}

sub set_pppconf_route
{
  my ($pppconf, $startif, $iface, $key, $val) = @_;
  my ($section);

  if ($iface =~ /^tun[0-9]+/)
  {
    $section = &Utils::Parse::get_startif ($startif, "ppp[ \t]+\-[^ \t]+[ \t]+([^ \t]+)");
    &Utils::Replace::set_pppconf_common ($pppconf, $section, $key,
                                 ($val == 1)? "add default HISADDR" : undef);
  }
}

sub set_pppconf_dial_command
{
  my ($pppconf, $startif, $iface, $val) = @_;
  my ($section, $dial);

  if ($iface =~ /^tun[0-9]+/)
  {
    $section = &Utils::Parse::get_startif ($startif, "ppp[ \t]+\-[^ \t]+[ \t]+([^ \t]+)");
    $dial = &Utils::Parse::get_pppconf ($pppconf, $section, "dial");
    $dial =~ s/ATD[TP]/$val/;

    &Utils::Replace::set_pppconf ($pppconf, $section, "dial", $dial);
  }
}

sub set_pppconf_volume
{
  my ($pppconf, $startif, $iface, $val) = @_;
  my ($section, $dial, $vol, $pre, $post);

  if ($iface =~ /^tun[0-9]+/)
  {
    $section = &Utils::Parse::get_startif ($startif, "ppp[ \t]+\-[^ \t]+[ \t]+([^ \t]+)");
    $dial = &Utils::Parse::get_pppconf ($pppconf, $section, "dial");

    if ($dial =~ /(.*AT[^ \t]*)([ML][0-3])(.* OK .*)/i)
    {
      $pre  = $1;
      $post = $3;
    }
    elsif ($dial =~ /(.*AT[^ \t]*)( OK .*)/i)
    {
      $pre  = $1;
      $post = $2;
    }

    if ($val == 0)
    {
      $vol = "M0";
    }
    else
    {
      $vol = "L$val";
    }

    $dial = $pre . $vol . $post;
    &Utils::Replace::set_pppconf ($pppconf, $section, "dial", $dial);
  }
}

sub get_interface_dist
{
  my %dist_map =
	 (
    "debian"          => "debian",
    "redhat-6.2"      => "redhat-6.2",
    "redhat-7.0"      => "redhat-6.2",
    "redhat-7.1"      => "redhat-6.2",
    "redhat-7.2"      => "redhat-7.2",
    "redhat-8.0"      => "redhat-8.0",
    "mandrake-9.0"    => "mandrake-9.0",
    "yoper-2.2"       => "redhat-6.2",
    "conectiva-9"     => "conectiva-9",
    "suse-9.0"        => "suse-9.0",
    "pld-1.0"         => "pld-1.0",
    "vine-3.0"        => "vine-3.0",
    "ark"             => "vine-3.0",
    "slackware-9.1.0" => "slackware-9.1.0",
    "slackware-14.0"  => "slackware-9.1.0",
    "slackware-14.1"  => "slackware-9.1.0",
    "gentoo"          => "gentoo",
    "freebsd-5"       => "freebsd-5",
    "solaris-2.11"    => "solaris-2.11",
   );

  return $dist_map{$Utils::Backend::tool{"platform"}};
}

sub get_interface_parse_table
{
  my %dist_tables =
    (
     "redhat-6.2" =>
     {
       ifaces_get => \&get_existing_rh62_ifaces,
       fn =>
       {
         IFCFG   => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
         CHAT    => "/etc/sysconfig/network-scripts/chat-#iface#",
         IFACE   => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE    => "%ppp_type%",
         PAP     => "/etc/ppp/pap-secrets",
         CHAP    => "/etc/ppp/chap-secrets",
         PUMP    => "/etc/pump.conf",
         WVDIAL  => "/etc/wvdial.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,          IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh,      IFCFG, DEVICE ],
        [ "address",            \&Utils::Parse::get_sh,      IFCFG, IPADDR ],
        [ "netmask",            \&Utils::Parse::get_sh,      IFCFG, NETMASK ],
        [ "broadcast",          \&Utils::Parse::get_sh,      IFCFG, BROADCAST ],
        [ "network",            \&Utils::Parse::get_sh,      IFCFG, NETWORK ],
        [ "gateway",            \&Utils::Parse::get_sh,      IFCFG, GATEWAY ],
        [ "remote_address",     \&Utils::Parse::get_sh,      IFCFG, REMIP ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "section",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,       IFCFG, WVDIALSECT ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool,  IFCFG, PEERDNS ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,       IFCFG, MTU ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,       IFCFG, MRU ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,       IFCFG, PAPNAME ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP,  "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,       IFCFG, MODEMPORT ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,       IFCFG, LINESPEED ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool,  IFCFG, DEFROUTE ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool,  IFCFG, PERSIST ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool,  IFCFG, ESCAPECHARS ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool,  IFCFG, HARDFLOWCTL ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Phone" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Username" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Password" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Modem" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Baud" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "ppp_options",        \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ],
       ]
     },

     "redhat-7.2" =>
     {
       fn =>
       {
         IFCFG => ["/etc/sysconfig/networking/profiles/default/ifcfg-#iface#",
                   "/etc/sysconfig/networking/devices/ifcfg-#iface#",
                   "/etc/sysconfig/network-scripts/ifcfg-#iface#"],
         CHAT  => "/etc/sysconfig/network-scripts/chat-#iface#",
         IFACE => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE  => "%ppp_type%",
         PAP   => "/etc/ppp/pap-secrets",
         CHAP  => "/etc/ppp/chap-secrets",
         PUMP  => "/etc/pump.conf",
         WVDIAL => "/etc/wvdial.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,   IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh, IFCFG, DEVICE ],
        [ "address",            \&Utils::Parse::get_sh, IFCFG, IPADDR ],
        [ "netmask",            \&Utils::Parse::get_sh, IFCFG, NETMASK ],
        [ "broadcast",          \&Utils::Parse::get_sh, IFCFG, BROADCAST ],
        [ "network",            \&Utils::Parse::get_sh, IFCFG, NETWORK ],
        [ "gateway",            \&Utils::Parse::get_sh, IFCFG, GATEWAY ],
        [ "essid",              \&Utils::Parse::get_sh, IFCFG, ESSID ],
        [ "key_type",           \&get_wep_key_type, [ \&Utils::Parse::get_sh, IFCFG, KEY ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_sh, IFCFG, KEY ]],
        [ "remote_address",     \&Utils::Parse::get_sh,      IFCFG, REMIP ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "section",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, WVDIALSECT ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PEERDNS ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MTU ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MRU ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, PAPNAME ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP,  "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MODEMPORT ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, LINESPEED ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, DEFROUTE ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PERSIST ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, ESCAPECHARS ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, HARDFLOWCTL ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ]],
#        [ "name",               \&Utils::Parse::get_sh,      IFCFG, NAME ],
#        [ "name",               \&Utils::Parse::get_trivial, IFACE ],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "ppp_options",        \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ],
#        [ "debug",              \&Utils::Parse::get_sh_bool, IFCFG, DEBUG ],
        # wvdial settings
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Phone" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Username" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Password" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Modem" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Baud" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
       ]
     },

     "redhat-8.0" =>
     {
       ifaces_get => \&get_existing_rh72_ifaces,
       fn =>
       {
         IFCFG   => ["/etc/sysconfig/networking/profiles/default/ifcfg-#iface#",
                     "/etc/sysconfig/networking/devices/ifcfg-#iface#",
                     "/etc/sysconfig/network-scripts/ifcfg-#iface#"],
         CHAT    => "/etc/sysconfig/network-scripts/chat-#iface#",
         IFACE   => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE    => "%ppp_type%",
         PAP     => "/etc/ppp/pap-secrets",
         CHAP    => "/etc/ppp/chap-secrets",
         PUMP    => "/etc/pump.conf",
         WVDIAL  => "/etc/wvdial.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,     IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh, IFCFG, DEVICE ],
        [ "address",            \&Utils::Parse::get_sh, IFCFG, IPADDR ],
        [ "netmask",            \&Utils::Parse::get_sh, IFCFG, NETMASK ],
        [ "broadcast",          \&Utils::Parse::get_sh, IFCFG, BROADCAST ],
        [ "network",            \&Utils::Parse::get_sh, IFCFG, NETWORK ],
        [ "gateway",            \&Utils::Parse::get_sh, IFCFG, GATEWAY ],
        [ "essid",              \&Utils::Parse::get_sh, IFCFG, WIRELESS_ESSID ],
        [ "key_type",           \&get_wep_key_type, [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "remote_address",     \&Utils::Parse::get_sh,      IFCFG, REMIP ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "section",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, WVDIALSECT ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PEERDNS ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MTU ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MRU ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, PAPNAME ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP,  "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MODEMPORT ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, LINESPEED ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, DEFROUTE ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PERSIST ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, ESCAPECHARS ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, HARDFLOWCTL ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ]],
#        [ "name",               \&Utils::Parse::get_sh,      IFCFG, NAME ],
#        [ "name",               \&Utils::Parse::get_trivial, IFACE ],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "ppp_options",        \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ],
#        [ "debug",              \&Utils::Parse::get_sh_bool, IFCFG, DEBUG ],
        # wvdial settings
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Phone" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Username" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Password" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Modem" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Baud" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
       ]
     },

     "vine-3.0" =>
     {
       ifaces_get => \&get_existing_rh62_ifaces,
       fn =>
       {
         IFCFG   => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
         CHAT    => "/etc/sysconfig/network-scripts/chat-#iface#",
         IFACE   => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE    => "%ppp_type%",
         PAP     => "/etc/ppp/pap-secrets",
         CHAP    => "/etc/ppp/chap-secrets",
         PUMP    => "/etc/pump.conf",
         WVDIAL  => "/etc/wvdial.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,     IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh, IFCFG, DEVICE ],
        [ "address",            \&Utils::Parse::get_sh, IFCFG, IPADDR ],
        [ "netmask",            \&Utils::Parse::get_sh, IFCFG, NETMASK ],
        [ "broadcast",          \&Utils::Parse::get_sh, IFCFG, BROADCAST ],
        [ "network",            \&Utils::Parse::get_sh, IFCFG, NETWORK ],
        [ "gateway",            \&Utils::Parse::get_sh, IFCFG, GATEWAY ],
        [ "essid",              \&Utils::Parse::get_sh, IFCFG, ESSID ],
        [ "key_type",           \&get_wep_key_type, [ \&Utils::Parse::get_sh, IFCFG, KEY ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_sh, IFCFG, KEY ]],
        [ "remote_address",     \&Utils::Parse::get_sh, IFCFG, REMIP ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "section",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, WVDIALSECT ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PEERDNS ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MTU ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MRU ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, PAPNAME ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP,  "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MODEMPORT ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, LINESPEED ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, DEFROUTE ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PERSIST ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, ESCAPECHARS ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, HARDFLOWCTL ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ]],
#        [ "name",               \&Utils::Parse::get_sh,      IFCFG, NAME ],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "ppp_options",        \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ],
#        [ "debug",              \&Utils::Parse::get_sh_bool, IFCFG, DEBUG ],
        # wvdial settings
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Phone" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Username" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Password" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Modem" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Baud" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
       ]
     },

     "mandrake-9.0" =>
     {
       ifaces_get => \&get_existing_rh62_ifaces,
       fn =>
       {
         IFCFG   => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
         CHAT    => "/etc/sysconfig/network-scripts/chat-#iface#",
         IFACE   => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE    => "%ppp_type%",
         PAP     => "/etc/ppp/pap-secrets",
         CHAP    => "/etc/ppp/chap-secrets",
         PUMP    => "/etc/pump.conf",
         WVDIAL  => "/etc/wvdial.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,     IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh, IFCFG, DEVICE ],
        [ "address",            \&Utils::Parse::get_sh, IFCFG, IPADDR ],
        [ "netmask",            \&Utils::Parse::get_sh, IFCFG, NETMASK ],
        [ "broadcast",          \&Utils::Parse::get_sh, IFCFG, BROADCAST ],
        [ "network",            \&Utils::Parse::get_sh, IFCFG, NETWORK ],
        [ "gateway",            \&Utils::Parse::get_sh, IFCFG, GATEWAY ],
        [ "essid",              \&Utils::Parse::get_sh, IFCFG, WIRELESS_ESSID ],
        [ "key_type",           \&get_wep_key_type, [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "remote_address",     \&Utils::Parse::get_sh, IFCFG, REMIP ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "section",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, WVDIALSECT ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PEERDNS ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MTU ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MRU ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, PAPNAME ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP,  "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MODEMPORT ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, LINESPEED ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, DEFROUTE ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PERSIST ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, ESCAPECHARS ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, HARDFLOWCTL ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ]],
#        [ "name",               \&Utils::Parse::get_sh,      IFCFG, NAME ],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "ppp_options",        \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ],
#        [ "debug",              \&Utils::Parse::get_sh_bool, IFCFG, DEBUG ],
        # wvdial settings
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Phone" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Username" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Password" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Modem" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Baud" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
       ]
     },

     "conectiva-9" =>
     {
       ifaces_get => \&get_existing_rh62_ifaces,
       fn =>
       {
         IFCFG   => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
         CHAT    => "/etc/sysconfig/network-scripts/chat-#iface#",
         IFACE   => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE    => "%ppp_type%",
         PAP     => "/etc/ppp/pap-secrets",
         CHAP    => "/etc/ppp/chap-secrets",
         PUMP    => "/etc/pump.conf",
         WVDIAL  => "/etc/wvdial.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,     IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh, IFCFG, DEVICE ],
        [ "address",            \&Utils::Parse::get_sh, IFCFG, IPADDR ],
        [ "netmask",            \&Utils::Parse::get_sh, IFCFG, NETMASK ],
        [ "broadcast",          \&Utils::Parse::get_sh, IFCFG, BROADCAST ],
        [ "network",            \&Utils::Parse::get_sh, IFCFG, NETWORK ],
        [ "gateway",            \&Utils::Parse::get_sh, IFCFG, GATEWAY ],
        [ "essid",              \&Utils::Parse::get_sh, IFCFG, WIRELESS_ESSID ],
        [ "key_type",           \&get_wep_key_type, [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "remote_address",     \&Utils::Parse::get_sh, IFCFG, REMIP ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "section",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, WVDIALSECT ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PEERDNS ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MTU ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MRU ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, PAPNAME ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP,  "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, MODEMPORT ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, LINESPEED ]],
        [ "ppp_options",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, DEFROUTE ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, PERSIST ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, ESCAPECHARS ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_sh_bool, IFCFG, HARDFLOWCTL ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ]],
#        [ "name",               \&Utils::Parse::get_sh,      IFCFG, NAME ],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "debug",              \&Utils::Parse::get_sh_bool, IFCFG, DEBUG ],
        # wvdial settings
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Phone" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Username" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Password" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Modem" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Baud" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
       ]
     },

     "debian" =>
     {
       fn =>
       {
         INTERFACES  => "/etc/network/interfaces",
         IFACE       => "#iface#",
         IFACE_TYPE  => "#type#",
         TYPE        => "%ppp_type%",
         CHAT        => "/etc/chatscripts/%section%",
         PPP_OPTIONS => "/etc/ppp/peers/%section%",
         PAP         => "/etc/ppp/pap-secrets",
         CHAP        => "/etc/ppp/chap-secrets",
       },
       table =>
       [
        [ "dev",                \&Utils::Parse::get_trivial, IFACE ],
        [ "bootproto",          \&get_debian_bootproto,      [INTERFACES, IFACE]],
        [ "auto",               \&get_debian_auto,           [INTERFACES, IFACE]],
        [ "address",            \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "address" ],
        [ "netmask",            \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "netmask" ],
        [ "broadcast",          \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "broadcast" ],
        [ "network",            \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "network" ],
        [ "gateway",            \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "gateway" ],
        [ "essid",              \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "wireless[_-]essid" ],
        [ "essid",              \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "wpa-ssid" ],
        [ "key_type",           \&get_debian_key_type, [ INTERFACES, IFACE ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_interfaces_option_str, INTERFACES, IFACE, "wireless[_-]key1?" ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_interfaces_option_str, INTERFACES, IFACE, "wpa-psk" ]],
        [ "remote_address",     \&get_debian_remote_address, [INTERFACES, IFACE]],
        [ "section",            \&Utils::Parse::get_interfaces_option_str,    [INTERFACES, IFACE], "provider" ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&get_ppp_type, PPP_OPTIONS, CHAT ]],
        [ "update_dns",         \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "usepeerdns" ]],
        [ "noauth",             \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "noauth" ]],
        [ "mtu",                \&check_type, [TYPE, ".+", \&Utils::Parse::split_first_str, PPP_OPTIONS, "mtu", "[ \t]+" ]],
        [ "mru",                \&check_type, [TYPE, ".+", \&Utils::Parse::split_first_str, PPP_OPTIONS, "mru", "[ \t]+" ]],
        [ "serial_port",        \&check_type, [TYPE, "(modem|gprs)", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^(/dev/[^ \t]+)" ]],
        [ "serial_speed",       \&check_type, [TYPE, "(modem|gprs)", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^([0-9]+)" ]],
        [ "serial_port",        \&check_type, [TYPE, "pppoe", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^plugin[ \t]+rp-pppoe.so[ \t]+(.*)" ]],
        [ "login",              \&check_type, [TYPE, ".+", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^user \"?([^\"]*)\"?" ]],
        [ "password",           \&check_type, [TYPE, ".+", \&get_pap_passwd, PAP, "%login%" ]],
        [ "password",           \&check_type, [TYPE, ".+", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "set_default_gw",     \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "defaultroute" ]],
        [ "debug",              \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "debug" ]],
        [ "persist",            \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "persist" ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::split_first_str, PPP_OPTIONS, "escape", "[ \t]+" ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "crtscts" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "atd[^0-9]([0-9*#]*)[wW]" ]],
        [ "external_line",      \&check_type, [TYPE, "isdn",  \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^number[ \t]+(.+)[wW]" ]],
        [ "phone_number",       \&check_type, [TYPE, "isdn",  \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^number.*[wW \t](.*)" ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "atd.*[ptwW]([#\*0-9, \-]+)" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "(atd[tp])[0-9, \-w]+" ]],
        [ "volume",             \&check_type, [TYPE, "modem", \&get_modem_volume, CHAT ]],
        [ "apn",                \&check_type, [TYPE, "gprs", \&Utils::Parse::get_from_chatfile, CHAT, "cgdcont.*\"([^\"]+)\"" ]],
#        [ "ppp_options",        \&check_type, [TYPE, "modem", \&gst_network_get_ppp_options_unsup, PPP_OPTIONS ]],
       ]
     },

     "suse-9.0" =>
     {
       ifaces_get => \&get_existing_suse_ifaces,
       fn =>
       {
         IFCFG      => "/etc/sysconfig/network/ifcfg-#iface#",
         ROUTES_CONF => "/etc/sysconfig/network/routes",
         PROVIDERS  => "/etc/sysconfig/network/providers/%section%",
         IFACE      => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE       => "%ppp_type%",
       },
       table =>
       [
        [ "dev",            \&get_suse_dev_name, IFACE ],
        [ "auto",           \&get_suse_auto,        IFCFG, STARTMODE ],
        [ "bootproto",      \&get_bootproto,        IFCFG, BOOTPROTO ],
        [ "address",        \&Utils::Parse::get_sh, IFCFG, IPADDR ],
        [ "netmask",        \&Utils::Parse::get_sh, IFCFG, NETMASK ],
        [ "remote_address", \&Utils::Parse::get_sh, IFCFG, REMOTE_IPADDR ],
        [ "essid",          \&Utils::Parse::get_sh, IFCFG, WIRELESS_ESSID ],
        [ "key_type",       \&get_wep_key_type,     [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "key",            \&get_wep_key,          [ \&Utils::Parse::get_sh, IFCFG, WIRELESS_KEY ]],
        [ "gateway",        \&get_suse_gateway,     ROUTES_CONF, "%address%", "%netmask%" ],
        [ "gateway",        \&get_suse_gateway,     ROUTES_CONF, "%remote_address%", "255.255.255.255" ],
        # Modem stuff goes here
        [ "ppp_type",       \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "serial_port",    \&Utils::Parse::get_sh, IFCFG, MODEM_DEVICE ],
        [ "serial_speed",   \&Utils::Parse::get_sh, IFCFG, SPEED ],
        [ "mtu",            \&Utils::Parse::get_sh, IFCFG, MTU ],
        [ "mru",            \&Utils::Parse::get_sh, IFCFG, MRU ],
        [ "dial_command",   \&Utils::Parse::get_sh, IFCFG, DIALCOMMAND ],
        [ "external_line",  \&Utils::Parse::get_sh, IFCFG, DIALPREFIX ],
        [ "section",        \&Utils::Parse::get_sh, IFCFG, PROVIDER ],
        [ "volume",         \&Utils::Parse::get_sh_re, IFCFG, INIT8, "AT.*[ml]([0-3])" ],
        [ "login",          \&Utils::Parse::get_sh, PROVIDERS, USERNAME ],
        [ "password",       \&Utils::Parse::get_sh, PROVIDERS, PASSWORD ],
        [ "phone_number",   \&Utils::Parse::get_sh, PROVIDERS, PHONE ],
        [ "dns1",           \&Utils::Parse::get_sh, PROVIDERS, DNS1 ],
        [ "dns2",           \&Utils::Parse::get_sh, PROVIDERS, DNS2 ],
        [ "update_dns",     \&Utils::Parse::get_sh_bool, PROVIDERS, MODIFYDNS ],
        [ "persist",        \&Utils::Parse::get_sh_bool, PROVIDERS, PERSIST ],
        [ "stupid",         \&Utils::Parse::get_sh_bool, PROVIDERS, STUPIDMODE ],
        [ "set_default_gw", \&Utils::Parse::get_sh_bool, PROVIDERS, DEFAULTROUTE ],
#        [ "ppp_options",    \&Utils::Parse::get_sh, IFCFG,   PPPD_OPTIONS ],
       ]
     },

     "pld-1.0" =>
     {
       ifaces_get => \&get_existing_pld_ifaces,
       fn =>
       {
         IFCFG => "/etc/sysconfig/interfaces/ifcfg-#iface#",
         CHAT  => "/etc/sysconfig/interfaces/data/chat-#iface#",
         IFACE => "#iface#",
         IFACE_TYPE => "#type#",
         TYPE  => "%ppp_type%",
         PAP   => "/etc/ppp/pap-secrets",
         CHAP  => "/etc/ppp/chap-secrets",
         PUMP  => "/etc/pump.conf"
       },
       table =>
       [
        [ "bootproto",          \&get_rh_bootproto,          IFCFG, BOOTPROTO ],
        [ "auto",               \&Utils::Parse::get_sh_bool, IFCFG, ONBOOT ],
        [ "dev",                \&Utils::Parse::get_sh,      IFCFG, DEVICE ],
        [ "address",            \&get_pld_ipaddr,            IFCFG, IPADDR, "address" ],
        [ "netmask",            \&get_pld_ipaddr,            IFCFG, IPADDR, "netmask" ],
        [ "gateway",            \&Utils::Parse::get_sh,      IFCFG, GATEWAY ],
        [ "remote_address",     \&Utils::Parse::get_sh,      IFCFG, REMIP ],
        [ "update_dns",         \&Utils::Parse::get_sh_bool, IFCFG, PEERDNS ],
        [ "mtu",                \&Utils::Parse::get_sh,      IFCFG, MTU ],
        [ "mru",                \&Utils::Parse::get_sh,      IFCFG, MRU ],
        [ "login",              \&Utils::Parse::get_sh,      IFCFG, PAPNAME ],
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "password",           \&get_pap_passwd,            PAP,  "%login%" ],
        [ "password",           \&get_pap_passwd,            CHAP, "%login%" ],
        [ "serial_port",        \&Utils::Parse::get_sh,      IFCFG, MODEMPORT ],
        [ "serial_speed",       \&Utils::Parse::get_sh,      IFCFG, LINESPEED ],
        [ "set_default_gw",     \&Utils::Parse::get_sh_bool, IFCFG, DEFROUTE ],
        [ "persist",            \&Utils::Parse::get_sh_bool, IFCFG, PERSIST ],
        [ "serial_escapechars", \&Utils::Parse::get_sh_bool, IFCFG, ESCAPECHARS ],
        [ "serial_hwctl",       \&Utils::Parse::get_sh_bool, IFCFG, HARDFLOWCTL ],
        [ "phone_number",       \&Utils::Parse::get_from_chatfile,    CHAT, "^atd[^0-9]*([#\*0-9, \-]+)" ],
#        [ "name",               \&Utils::Parse::get_sh,      IFCFG, DEVICE ],
#        [ "broadcast",          \&Utils::Parse::get_sh,      IFCFG, BROADCAST ],
#        [ "network",            \&Utils::Parse::get_sh,      IFCFG, NETWORK ],
#        [ "update_dns",         \&gst_network_pump_get_nodns, PUMP, "%dev%", "%bootproto%" ],
#        [ "dns1",               \&Utils::Parse::get_sh,      IFCFG, DNS1 ],
#        [ "dns2",               \&Utils::Parse::get_sh,      IFCFG, DNS2 ],
#        [ "ppp_options",        \&Utils::Parse::get_sh,      IFCFG, PPPOPTIONS ],
#        [ "section",            \&Utils::Parse::get_sh,      IFCFG, WVDIALSECT ],
#        [ "debug",              \&Utils::Parse::get_sh_bool, IFCFG, DEBUG ],
       ]
     },

     "slackware-9.1.0" =>
     {
       fn =>
       {
         RC_INET_CONF => "/etc/rc.d/rc.inet1.conf",
         RC_LOCAL     => "/etc/rc.d/rc.local",
         IFACE        => "#iface#",
         IFACE_TYPE   => "#type#",
         TYPE         => "%ppp_type%",
         WIRELESS     => "/etc/pcmcia/wireless.opts",
         PPP_OPTIONS  => "/etc/ppp/options",
         PAP          => "/etc/ppp/pap-secrets",
         CHAP         => "/etc/ppp/chap-secrets",
         CHAT         => "/etc/ppp/pppscript",
       },
       table =>
       [
        [ "dev",                \&Utils::Parse::get_trivial,     IFACE ],
        [ "address",            \&Utils::Parse::get_rcinet1conf, [RC_INET_CONF, IFACE], IPADDR ],
        [ "netmask",            \&Utils::Parse::get_rcinet1conf, [RC_INET_CONF, IFACE], NETMASK ],
        [ "gateway",            \&get_gateway,                   RC_INET_CONF, GATEWAY, "%address%", "%netmask%" ],
        [ "auto",               \&Utils::Parse::get_trivial,     1 ],
        [ "bootproto",          \&get_slackware_bootproto,       [RC_INET_CONF, IFACE]],
        [ "essid",              \&Utils::Parse::get_rcinet1conf, [RC_INET_CONF, IFACE], WLAN_ESSID ],
        [ "key_type",           \&get_wep_key_type, [ \&Utils::Parse::get_rcinet1conf, RC_INET_CONF, IFACE, WLAN_KEY ]],
        [ "key",                \&get_wep_key,      [ \&Utils::Parse::get_rcinet1conf, RC_INET_CONF, IFACE, WLAN_KEY ]],
        # Modem stuff
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "usepeerdns" ]],
        [ "noauth",             \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "noauth" ]],
        [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Parse::split_first_str, PPP_OPTIONS, "mtu", "[ \t]+" ]],
        [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Parse::split_first_str, PPP_OPTIONS, "mru", "[ \t]+" ]],
        [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^(/dev/[^ \t]+)" ]],
        [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^([0-9]+)" ]],
        [ "login",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^name \"?([^\"]*)\"?" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, PAP, "%login%" ]],
        [ "password",           \&check_type, [TYPE, "modem", \&get_pap_passwd, CHAP, "%login%" ]],
        [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "defaultroute" ]],
        [ "debug",              \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "debug" ]],
        [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "persist" ]],
        [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::split_first_str, PPP_OPTIONS, "escape", "[ \t]+" ]],
        [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "crtscts" ]],
        [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "atd[^0-9]*([0-9*#]*)[wW]" ]],
        [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "atd.*[ptw]([#\*0-9, \-]+)" ]],
        [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "(atd[tp])[0-9, \-w]+" ]],
        [ "volume",             \&check_type, [TYPE, "modem", \&get_modem_volume, CHAT ]],
#        [ "ppp_options",        \&check_type, [TYPE, "modem", \&gst_network_get_ppp_options_unsup, PPP_OPTIONS ]],
       ]
     },

     "gentoo" =>
     {
       fn =>
       {
         NET          => "/etc/conf.d/net",
         PPPNET       => "/etc/conf.d/net.#iface#",
         INIT         => "net.#iface#",
         IFACE_TYPE   => "#type#",
         TYPE         => "%ppp_type%",
         IFACE        => "#iface#",
         WIRELESS     => "/etc/conf.d/wireless",
       },
       table =>
       [
        [ "auto",               \&Init::Services::get_gentoo_service_status, INIT, "default" ],
        [ "dev",                \&Utils::Parse::get_trivial, IFACE ],
        [ "address",            \&Utils::Parse::get_confd_net_re, NET, "config_%dev%", "^[ \t]*([0-9\.]+)" ],
        [ "netmask",            \&Utils::Parse::get_confd_net_re, NET, "config_%dev%", "netmask[ \t]+([0-9\.]*)" ],
        [ "remote_address",     \&Utils::Parse::get_confd_net_re, NET, "config_%dev%", "dest_address[ \t]+([0-9\.]*)" ],
        # [ "gateway",            \&gst_network_gentoo_parse_gateway,   [ NET, IFACE ]],
        [ "bootproto",          \&get_gentoo_bootproto,  [ NET, IFACE ]],
        [ "essid",              \&Utils::Parse::get_sh,  WIRELESS, "essid_%dev%" ],
        [ "key_type",           \&get_wep_key_type,      [ \&Utils::Parse::get_sh, WIRELESS, "key_%essid%" ]],
        [ "key",                \&get_wep_key,           [ \&Utils::Parse::get_sh, WIRELESS, "key_%essid%" ]],
        # modem stuff
        [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "update_dns",         \&Utils::Parse::get_sh_bool, PPPNET, PEERDNS ],
        [ "mtu",                \&Utils::Parse::get_sh,      PPPNET, MTU ],
        [ "mru",                \&Utils::Parse::get_sh,      PPPNET, MRU ],
        [ "serial_port",        \&Utils::Parse::get_sh,      PPPNET, MODEMPORT ],
        [ "serial_speed",       \&Utils::Parse::get_sh,      PPPNET, LINESPEED ],
        [ "login",              \&Utils::Parse::get_sh,      PPPNET, USERNAME ],
        [ "password",           \&Utils::Parse::get_sh,      PPPNET, PASSWORD ],
        [ "ppp_options",        \&Utils::Parse::get_sh,      PPPNET, PPPOPTIONS ],
        [ "set_default_gw",     \&Utils::Parse::get_sh_bool, PPPNET, DEFROUTE ],
        [ "debug",              \&Utils::Parse::get_sh_bool, PPPNET, DEBUG ],
        [ "persist",            \&Utils::Parse::get_sh_bool, PPPNET, PERSIST ],
        [ "serial_escapechars", \&Utils::Parse::get_sh_bool, PPPNET, ESCAPECHARS ],
        [ "serial_hwctl",       \&Utils::Parse::get_sh_bool, PPPNET, HARDFLOWCTL ],
        [ "external_line",      \&Utils::Parse::get_sh_re,   PPPNET, NUMBER, "^([0-9*#]*)wW" ],
        [ "phone_number",       \&Utils::Parse::get_sh_re,   PPPNET, NUMBER, "w?([#\*0-9]*)\$" ],
        [ "volume",             \&Utils::Parse::get_sh_re,   PPPNET, INITSTRING, "^at.*[ml]([0-3])" ],
       ]
     },

     "freebsd-5" =>
     {
       fn =>
       {
         RC_CONF         => "/etc/rc.conf",
         RC_CONF_DEFAULT => "/etc/defaults/rc.conf",
         STARTIF         => "/etc/start_if.#iface#",
         PPPCONF         => "/etc/ppp/ppp.conf",
         IFACE           => "#iface#",
         IFACE_TYPE      => "#type#",
         TYPE            => "%ppp_type%",
       },
       table =>
       [
        [ "auto",           \&get_freebsd_auto,               [RC_CONF, RC_CONF_DEFAULT, IFACE ]],
        [ "dev",            \&Utils::Parse::get_trivial,      IFACE ],
        # we need to double check these values both in the start_if and in the rc.conf files, in this order
        [ "address",        \&Utils::Parse::get_startif,      STARTIF, "inet[ \t]+([0-9\.]+)" ],
        [ "address",        \&Utils::Parse::get_sh_re,        RC_CONF, "ifconfig_%dev%", "inet[ \t]+([0-9\.]+)" ],
        [ "netmask",        \&Utils::Parse::get_startif,      STARTIF, "netmask[ \t]+([0-9\.]+)" ],
        [ "netmask",        \&Utils::Parse::get_sh_re,        RC_CONF, "ifconfig_%dev%", "netmask[ \t]+([0-9\.]+)" ],
        [ "remote_address", \&Utils::Parse::get_startif,      STARTIF, "dest_address[ \t]+([0-9\.]+)" ],
        [ "remote_address", \&Utils::Parse::get_sh_re,        RC_CONF, "ifconfig_%dev%", "dest_address[ \t]+([0-9\.]+)" ],
        [ "essid",          \&Utils::Parse::get_startif,      STARTIF, "ssid[ \t]+(\".*\"|[^\"][^ ]+)" ],
        [ "essid",          \&Utils::Parse::get_sh_re,        RC_CONF, "ifconfig_%dev%", "ssid[ \t]+([^ ]*)" ],
        # this is for plip interfaces
        [ "gateway",        \&get_gateway,                    RC_CONF, "defaultrouter", "%remote_address%", "255.255.255.255" ],
        [ "gateway",        \&get_gateway,                    RC_CONF, "defaultrouter", "%address%", "%netmask%" ],
        [ "bootproto",      \&get_bootproto,                  RC_CONF, "ifconfig_%dev%" ],
        # Modem stuff
        [ "ppp_type",       \&check_type, [IFACE_TYPE, "modem", \&Utils::Parse::get_trivial, "modem" ]],
        [ "serial_port",    \&Utils::Parse::get_pppconf,      [ PPPCONF, STARTIF, IFACE ], "device"   ],
        [ "serial_speed",   \&Utils::Parse::get_pppconf,      [ PPPCONF, STARTIF, IFACE ], "speed"    ],
        [ "mtu",            \&Utils::Parse::get_pppconf,      [ PPPCONF, STARTIF, IFACE ], "mtu"      ],
        [ "mru",            \&Utils::Parse::get_pppconf,      [ PPPCONF, STARTIF, IFACE ], "mru"      ],
        [ "login",          \&Utils::Parse::get_pppconf,      [ PPPCONF, STARTIF, IFACE ], "authname" ],
        [ "password",       \&Utils::Parse::get_pppconf,      [ PPPCONF, STARTIF, IFACE ], "authkey"  ],
        [ "update_dns",     \&Utils::Parse::get_pppconf_bool, [ PPPCONF, STARTIF, IFACE ], "dns"      ],
        [ "set_default_gw", \&Utils::Parse::get_pppconf_bool, [ PPPCONF, STARTIF, IFACE ], "default HISADDR" ],
        [ "external_line",  \&Utils::Parse::get_pppconf_re,   [ PPPCONF, STARTIF, IFACE ], "phone", "[ \t]+([#*0-9]+)[wW]" ],
        [ "phone_number",   \&Utils::Parse::get_pppconf_re,   [ PPPCONF, STARTIF, IFACE ], "phone", "[wW]?([#\*0-9]+)[ \t]*\$" ],
        [ "dial_command",   \&Utils::Parse::get_pppconf_re,   [ PPPCONF, STARTIF, IFACE ], "dial",  "(ATD[TP])" ],
        [ "volume",         \&Utils::Parse::get_pppconf_re,   [ PPPCONF, STARTIF, IFACE ], "dial",  "AT.*[ml]([0-3]) OK " ],
        [ "persist",        \&get_freebsd_ppp_persist,        [ STARTIF, IFACE ]],
       ]
     },

     "solaris-2.11" =>
     {
       fn =>
       {
         INTERFACE   => "/etc/hostname.#iface#",
         DHCP_FILE   => "/etc/dhcp.#iface#",
         SECRET      => "/etc/inet/secret/wifiwepkey",
         DEFAULTROUTER => "/etc/defaultrouter",
         IFACE       => "#iface#",
         IFACE_TYPE  => "#type#",
         TYPE        => "%ppp_type%",
         CHAT        => "/etc/chatscripts/%section%",
         PPP_OPTIONS => "/etc/ppp/peers/%section%",
         PAP         => "/etc/ppp/pap-secrets",
         CHAP        => "/etc/ppp/chap-secrets",
     },
     table =>
     [
      [ "dev",                \&Utils::Parse::get_trivial, IFACE ],
      [ "bootproto",          \&get_sunos_bootproto, [ DHCP_FILE, IFACE ]],
      [ "auto",               \&get_sunos_auto,    [INTERFACE, IFACE]],
      [ "address",            \&get_sunos_address, [INTERFACE, IFACE]],
      [ "netmask",            \&get_sunos_netmask, [INTERFACE, IFACE], "%bootproto%" ],
      [ "gateway",            \&get_sunos_gateway, DEFAULTROUTER, IFACE ],
      # FIXME: no broadcast nor network
      [ "essid",              \&get_sunos_wireless, [IFACE, "essid" ]],
      [ "key_type",           \&get_sunos_wireless, [IFACE, "encryption" ]],
      [ "key",                \&get_sunos_wireless_key, [SECRET, IFACE ]],
      [ "ppp_type",           \&check_type, [IFACE_TYPE, "modem", get_ppp_type, PPP_OPTIONS, CHAT ]],
      [ "update_dns",         \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "usepeerdns" ]],
      [ "noauth",             \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "noauth" ]],
      [ "mtu",                \&check_type, [TYPE, ".+", \&Utils::Parse::split_first_str, PPP_OPTIONS, "mtu", "[ \t]+" ]],
      [ "mru",                \&check_type, [TYPE, ".+", \&Utils::Parse::split_first_str, PPP_OPTIONS, "mru", "[ \t]+" ]],
      [ "serial_port",        \&check_type, [TYPE, "(modem|gprs)", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^(/dev/[^ \t]+)" ]],
      [ "serial_speed",       \&check_type, [TYPE, "(modem|gprs)", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^([0-9]+)" ]],
      [ "serial_port",        \&check_type, [TYPE, "pppoe", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^plugin[ \t]+rp-pppoe.so[ \t]+(.*)" ]],
      [ "login",              \&check_type, [TYPE, ".+", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^user \"?([^\"]*)\"?" ]],
      [ "password",           \&check_type, [TYPE, ".+", \&get_pap_passwd, PAP, "%login%" ]],
      [ "password",           \&check_type, [TYPE, ".+", \&get_pap_passwd, CHAP, "%login%" ]],
      [ "set_default_gw",     \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "defaultroute" ]],
      [ "debug",              \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "debug" ]],
      [ "persist",            \&check_type, [TYPE, ".+", \&Utils::Parse::get_kw, PPP_OPTIONS, "persist" ]],
      [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Parse::split_first_str, PPP_OPTIONS, "escape", "[ \t]+" ]],
      [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_kw, PPP_OPTIONS, "crtscts" ]],
      [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "atd[^0-9]([0-9*#]*)[wW]" ]],
      [ "external_line",      \&check_type, [TYPE, "isdn", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^number[ \t]+(.+)[wW]" ]],
      [ "phone_number",       \&check_type, [TYPE, "isdn", \&Utils::Parse::get_ppp_options_re, PPP_OPTIONS, "^number.*[wW \t](.*)" ]],
      [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "atd.*[ptwW]([#\*0-9, \-]+)" ]],
      [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Parse::get_from_chatfile, CHAT, "(atd[tp])[0-9, -w]+" ]],
      [ "volume",             \&check_type, [TYPE, "modem", \&get_modem_volume, CHAT ]],
      [ "apn",                \&check_type, [TYPE, "gprs", \&Utils::Parse::get_from_chatfile, CHAT, "cgdcont.*\"([^\"]+)\"" ]],
     ]
     },
	  );
  
  my $dist = &get_interface_dist ();
  return %{$dist_tables{$dist}} if $dist;

  &Utils::Report::do_report ("platform_no_table", $Utils::Backend::tool{"platform"});
  return undef;
}

sub get_interface_replace_table
{
  my %dist_tables =
  (
   "redhat-6.2" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_rh62_interface,
     fn =>
     {
       IFCFG  => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
       CHAT   => "/etc/sysconfig/network-scripts/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, NAME ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&Utils::Replace::set_sh,      IFCFG, IPADDR ],
      [ "netmask",            \&Utils::Replace::set_sh,      IFCFG, NETMASK ],
      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],
      # wvdial settings
      [ "phone_number",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Phone" ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
      [ "login",              \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Username" ]],
      [ "password",           \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Password" ]],
      [ "serial_port",        \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Modem" ]],
      [ "serial_speed",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Baud" ]],
      [ "set_default_gw",     \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
      [ "persist",            \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
      [ "dial_command",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
      [ "external_line",      \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
     ]
   },

   "redhat-7.2" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_rh72_interface,
     fn =>
     {
       IFCFG => ["/etc/sysconfig/network-scripts/ifcfg-#iface#",
                 "/etc/sysconfig/networking/profiles/default/ifcfg-#iface#",
                 "/etc/sysconfig/networking/devices/ifcfg-#iface#"],
       CHAT   => "/etc/sysconfig/network-scripts/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, NAME ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&Utils::Replace::set_sh,      IFCFG, IPADDR ],
      [ "netmask",            \&Utils::Replace::set_sh,      IFCFG, NETMASK ],
      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "essid",              \&Utils::Replace::set_sh,      IFCFG, ESSID ],
      [ "key",                \&Utils::Replace::set_sh,      IFCFG, KEY ],
      [ "key_type",           \&set_wep_key_full, [ \&Utils::Replace::set_sh, IFCFG, KEY, "%key%" ]],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],
      # wvdial settings
      [ "phone_number",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Phone" ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
      [ "login",              \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Username" ]],
      [ "password",           \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Password" ]],
      [ "serial_port",        \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Modem" ]],
      [ "serial_speed",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Baud" ]],
      [ "set_default_gw",     \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
      [ "persist",            \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
      [ "dial_command",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
      [ "external_line",      \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
     ]
   },
   
   "redhat-8.0" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_rh72_interface,
     fn =>
     {
       IFCFG => ["/etc/sysconfig/network-scripts/ifcfg-#iface#",
                 "/etc/sysconfig/networking/profiles/default/ifcfg-#iface#",
                 "/etc/sysconfig/networking/devices/ifcfg-#iface#"],
       CHAT   => "/etc/sysconfig/network-scripts/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev" ,               \&Utils::Replace::set_sh,      IFCFG, NAME ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&Utils::Replace::set_sh,      IFCFG, IPADDR ],
      [ "netmask",            \&Utils::Replace::set_sh,      IFCFG, NETMASK ],
      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "essid",              \&Utils::Replace::set_sh,      IFCFG, WIRELESS_ESSID ],
      [ "key",                \&Utils::Replace::set_sh,      IFCFG, WIRELESS_KEY   ],
      [ "key_type",           \&set_wep_key_full, [ \&Utils::Replace::set_sh, IFCFG, WIRELESS_KEY, "%key%" ]],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
#      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],
      # wvdial settings
      [ "phone_number",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Phone" ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
      [ "login",              \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Username" ]],
      [ "password",           \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Password" ]],
      [ "serial_port",        \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Modem" ]],
      [ "serial_speed",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Baud" ]],
      [ "set_default_gw",     \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
      [ "persist",            \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
      [ "dial_command",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
      [ "external_line",      \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
     ]
   },
   
   "vine-3.0" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_rh62_interface,
     fn =>
     {
       IFCFG  => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
       CHAT   => "/etc/sysconfig/network-scripts/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, NAME ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&Utils::Replace::set_sh,      IFCFG, IPADDR ],
      [ "netmask",            \&Utils::Replace::set_sh,      IFCFG, NETMASK ],
      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "essid",              \&Utils::Replace::set_sh,      IFCFG, ESSID ],
      [ "key",                \&Utils::Replace::set_sh,      IFCFG, KEY   ],
      [ "key_type",           \&set_wep_key_full, [ \&Utils::Replace::set_sh, IFCFG, KEY, "%key%" ]],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],

      # wvdial settings
      [ "phone_number",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Phone" ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
      [ "login",              \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Username" ]],
      [ "password",           \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Password" ]],
      [ "serial_port",        \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Modem" ]],
      [ "serial_speed",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Baud" ]],
      [ "set_default_gw",     \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
      [ "persist",            \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
      [ "dial_command",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
      [ "external_line",      \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
     ]
   },

   "mandrake-9.0" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_rh62_interface,
     fn =>
     {
       IFCFG  => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
       CHAT   => "/etc/sysconfig/network-scripts/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, NAME ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&Utils::Replace::set_sh,      IFCFG, IPADDR ],
      [ "netmask",            \&Utils::Replace::set_sh,      IFCFG, NETMASK ],
      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "essid",              \&Utils::Replace::set_sh,      IFCFG, WIRELESS_ESSID ],
      [ "key",                \&Utils::Replace::set_sh,      IFCFG, WIRELESS_KEY   ],
      [ "key_type",           \&set_wep_key_full, [ \&Utils::Replace::set_sh, IFCFG, WIRELESS_KEY, "%key%" ]],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
#      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],
      # wvdial settings
      [ "phone_number",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Phone" ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
      [ "login",              \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Username" ]],
      [ "password",           \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Password" ]],
      [ "serial_port",        \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Modem" ]],
      [ "serial_speed",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Baud" ]],
      [ "set_default_gw",     \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
      [ "persist",            \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
      [ "dial_command",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
      [ "external_line",      \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
     ]
   },

   "conectiva-9" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_rh62_interface,
     fn =>
     {
       IFCFG  => "/etc/sysconfig/network-scripts/ifcfg-#iface#",
       CHAT   => "/etc/sysconfig/network-scripts/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev" ,               \&Utils::Replace::set_sh,      IFCFG, NAME ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&Utils::Replace::set_sh,      IFCFG, IPADDR ],
      [ "netmask",            \&Utils::Replace::set_sh,      IFCFG, NETMASK ],
      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "essid",              \&Utils::Replace::set_sh,      IFCFG, WIRELESS_ESSID ],
      [ "key",                \&Utils::Replace::set_sh,      IFCFG, WIRELESS_KEY ],
      [ "key_type",           \&set_wep_key_full, [ \&Utils::Replace::set_sh, IFCFG, WIRELESS_KEY, "%key%" ]],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
#      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],
      # wvdial settings
      [ "phone_number",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Phone" ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto DNS" ]],
      [ "login",              \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Username" ]],
      [ "password",           \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Password" ]],
      [ "serial_port",        \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Modem" ]],
      [ "serial_speed",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Baud" ]],
      [ "set_default_gw",     \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Check Def Route" ]],
      [ "persist",            \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Auto Reconnect" ]],
      [ "dial_command",       \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Command" ]],
      [ "external_line",      \&check_type, [ TYPE, "modem", \&Utils::Replace::set_ini, WVDIAL, "Dialer %section%", "Dial Prefix" ]],
     ]
   },

   "debian" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_debian_interface,
     fn =>
     {
       INTERFACES  => "/etc/network/interfaces",
       IFACE       => "#iface#",
       IFACE_TYPE  => "#type#",
       TYPE        => "%ppp_type%",
       CHAT        => "/etc/chatscripts/%section%",
       PPP_OPTIONS => "/etc/ppp/peers/%section%",
       PAP         => "/etc/ppp/pap-secrets",
       CHAP        => "/etc/ppp/chap-secrets",
     },
     table =>
     [
      [ "_always_",           \&set_debian_bootproto, [INTERFACES, IFACE]],
      [ "bootproto",          \&set_debian_bootproto, [INTERFACES, IFACE]],
      [ "auto",               \&set_debian_auto,      [INTERFACES, IFACE]],
      [ "address",            \&Utils::Replace::set_interfaces_option_str, [INTERFACES, IFACE], "address" ],
      [ "netmask",            \&Utils::Replace::set_interfaces_option_str, [INTERFACES, IFACE], "netmask" ],
      [ "gateway",            \&Utils::Replace::set_interfaces_option_str, [INTERFACES, IFACE], "gateway" ],
      [ "key_type",           \&set_debian_key, [ INTERFACES, IFACE, "%key%", "%essid%" ]],
      [ "essid",              \&set_debian_essid, [ INTERFACES, IFACE, "%key_type%", "%key%" ]],
      # ugly hack for deleting undesired options (due to syntax duality)
      [ "essid",              \&Utils::Replace::set_interfaces_option_str, [INTERFACES, IFACE], "wireless_essid", "" ],
      # End of hack
      [ "section",            \&Utils::Replace::set_interfaces_option_str, [INTERFACES, IFACE], "provider" ],
      [ "remote_address",     \&set_debian_remote_address, [INTERFACES, IFACE]],
      # Modem stuff
      [ "ppp_type",           \&create_ppp_configuration, [ PPP_OPTIONS, CHAT ]],
      [ "section",            \&check_type, [TYPE, "modem", \&Utils::Replace::set_ppp_options_connect, PPP_OPTIONS ]],
      [ "update_dns",         \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "usepeerdns" ]],
      [ "noauth",             \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "noauth" ]],
      [ "set_default_gw",     \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "defaultroute" ]],
      [ "persist",            \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "persist" ]],
      [ "serial_port",        \&check_type, [TYPE, "(modem|gprs)", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^(/dev/[^ \t]+)" ]],
      [ "serial_speed",       \&check_type, [TYPE, "(modem|gprs)", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^([0-9]+)" ]],
      [ "serial_port",        \&check_type, [TYPE, "pppoe", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^plugin[ \t]+rp-pppoe\.so[ \t]+(.*)", "plugin rp-pppoe.so %serial_port%" ]],
      [ "login",              \&check_type, [TYPE, ".+", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^user (.*)", "user \"%login%\"" ]],
      [ "password",           \&check_type, [TYPE, ".+", \&set_pap_passwd, PAP, "%login%" ]],
      [ "password",           \&check_type, [TYPE, ".+", \&set_pap_passwd, CHAP, "%login%" ]],
      [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "(atd[tp])[w#\*0-9, \-]+" ]],
      [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "atd[tp]([w#\*0-9, \-]+)" ]],
      [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "atd[tp]([w#\*0-9, \-]+)", "%external_line%W%phone_number%" ]],
      [ "phone_number",       \&check_type, [TYPE, "isdn", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^number (.*)", "number %phone_number%" ]],
      [ "external_line",      \&check_type, [TYPE, "isdn", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^number (.*)", "number %external_line%W%phone_number%" ]],
      [ "volume",             \&check_type, [TYPE, "modem", \&set_modem_volume, CHAT ]],
      [ "apn",                \&check_type, [TYPE, "gprs", \&Utils::Replace::set_chat, CHAT, "cgdcont.*\"([^\"]+)\"" ]],
#      [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Replace::join_first_str, PPP_OPTIONS, "escape", "[ \t]+" ]],
#      [ "debug",              \&check_type, [TYPE, "(modem|isdn)", \&Utils::Replace::set_kw, PPP_OPTIONS, "debug" ]],
#      [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "crtscts" ]],
#      [ "mtu",                \&check_type, [TYPE, "(modem|isdn)", \&Utils::Replace::join_first_str, PPP_OPTIONS, "mtu", "[ \t]+" ]],
#      [ "mru",                \&check_type, [TYPE, "(modem|isdn)", \&Utils::Replace::join_first_str, PPP_OPTIONS, "mru", "[ \t]+" ]],
     ]
   },

   "suse-9.0" =>
   {
     iface_set    => \&activate_suse_interface,
     iface_delete => \&delete_suse_interface,
     fn =>
     {
       IFCFG       => "/etc/sysconfig/network/ifcfg-#iface#",
       PROVIDERS   => "/etc/sysconfig/network/providers/%section%",
       ROUTE_CONF  => "/etc/sysconfig/network/routes",
       IFACE       => "#iface#",
       IFACE_TYPE  => "#type#",
       TYPE        => "%ppp_type%",
       PPP_OPTIONS => "/etc/ppp/options"
     },
     table =>
     [
      [ "auto",           \&set_suse_auto,          IFCFG, STARTMODE ],
      [ "bootproto",      \&set_suse_bootproto,     IFCFG, BOOTPROTO ],
      [ "address",        \&Utils::Replace::set_sh, IFCFG, IPADDR ], 
      [ "netmask",        \&Utils::Replace::set_sh, IFCFG, NETMASK ],
      [ "remote_address", \&Utils::Replace::set_sh, IFCFG, REMOTE_IPADDR ],
      [ "essid",          \&Utils::Replace::set_sh, IFCFG, WIRELESS_ESSID ],
      [ "key",            \&Utils::Replace::set_sh, IFCFG, WIRELESS_KEY ],
      [ "key_type",       \&set_wep_key_full, [ \&Utils::Replace::set_sh, IFCFG, WIRELESS_KEY, "%key%" ]],
      # Modem stuff goes here
      [ "serial_port",    \&Utils::Replace::set_sh, IFCFG, MODEM_DEVICE ],
      [ "ppp_options",    \&Utils::Replace::set_sh, IFCFG, PPPD_OPTIONS ],
      [ "dial_command",   \&Utils::Replace::set_sh, IFCFG, DIALCOMMAND],
      [ "external_line",  \&Utils::Replace::set_sh, IFCFG, DIALPREFIX],
      [ "provider",       \&Utils::Replace::set_sh, IFCFG, PROVIDER ],
      [ "volume",         \&check_type, [ IFACE, "modem", \&set_modem_volume_sh, IFCFG, INIT8 ]],
      [ "login",          \&Utils::Replace::set_sh, PROVIDERS, USERNAME ],
      [ "password",       \&Utils::Replace::set_sh, PROVIDERS, PASSWORD ],
      [ "phone_number",   \&Utils::Replace::set_sh, PROVIDERS, PHONE ],
      [ "update_dns",     \&Utils::Replace::set_sh_bool, PROVIDERS, MODIFYDNS ],
      [ "persist",        \&Utils::Replace::set_sh_bool, PROVIDERS, PERSIST ],
      [ "set_default_gw", \&Utils::Replace::set_sh_bool, PROVIDERS, DEFAULTROUTE ],
#      [ "serial_speed",       \&Utils::Replace::set_sh,                        IFCFG,    SPEED        ],
#      [ "mtu",                \&Utils::Replace::set_sh,                        IFCFG,    MTU          ],
#      [ "mru",                \&Utils::Replace::set_sh,                        IFCFG,    MRU          ],
#      [ "dns1",               \&Utils::Replace::set_sh,                        PROVIDER, DNS1         ],
#      [ "dns2",               \&Utils::Replace::set_sh,                        PROVIDER, DNS2         ],
#      [ "stupid",             \&Utils::Replace::set_sh_bool,                   PROVIDER, STUPIDMODE   ],
     ]
   },

   "pld-1.0" =>
   {
     iface_set    => \&activate_interface,
     iface_delete => \&delete_pld_interface,
     fn =>
     {
       IFCFG  => "/etc/sysconfig/interfaces/ifcfg-#iface#",
       CHAT   => "/etc/sysconfig/interfaces/data/chat-#iface#",
       IFACE  => "#iface#",
       IFACE_TYPE => "#type#",
       TYPE   => "%ppp_type%",
       WVDIAL => "/etc/wvdial.conf",
       PUMP   => "/etc/pump.conf"
     },
     table =>
     [
      [ "bootproto",          \&set_rh_bootproto, IFCFG, BOOTPROTO ],
      [ "auto",               \&Utils::Replace::set_sh_bool, IFCFG, ONBOOT ],
      [ "dev",                \&Utils::Replace::set_sh,      IFCFG, DEVICE ],
      [ "address",            \&set_pld_ipaddr, IFCFG, IPADDR, "address" ],
      [ "netmask",            \&set_pld_ipaddr, IFCFG, IPADDR, "netmask" ],
      [ "gateway",            \&Utils::Replace::set_sh,      IFCFG, GATEWAY ],
      [ "update_dns",         \&Utils::Replace::set_sh_bool, IFCFG, PEERDNS ],
      [ "remote_address",     \&Utils::Replace::set_sh,      IFCFG, REMIP ],
      [ "login",              \&Utils::Replace::set_sh,      IFCFG, PAPNAME ],
      [ "serial_port",        \&Utils::Replace::set_sh,      IFCFG, MODEMPORT ],
      [ "ppp_options",        \&Utils::Replace::set_sh,      IFCFG, PPPOPTIONS ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool, IFCFG, DEFROUTE ],
      [ "persist",            \&Utils::Replace::set_sh_bool, IFCFG, PERSIST ],
      [ "phone_number",       \&Utils::Replace::set_chat,    CHAT,  "^atd[^0-9]*([#\*0-9, \-]+)" ]
#      [ "name",               \&Utils::Replace::set_sh,      IFCFG, NAME ],
#      [ "broadcast",          \&Utils::Replace::set_sh,      IFCFG, BROADCAST ],
#      [ "network",            \&Utils::Replace::set_sh,      IFCFG, NETWORK ],
#      [ "update_dns",         \&gst_network_pump_set_nodns, PUMP, "%dev%", "%bootproto%" ],
#      [ "dns1",               \&Utils::Replace::set_sh,      IFCFG, DNS1 ],
#      [ "dns2",               \&Utils::Replace::set_sh,      IFCFG, DNS2 ],
#      [ "mtu",                \&Utils::Replace::set_sh,      IFCFG, MTU ],
#      [ "mru",                \&Utils::Replace::set_sh,      IFCFG, MRU ],
#      [ "serial_speed",       \&Utils::Replace::set_sh,      IFCFG, LINESPEED ],
#      [ "section",            \&Utils::Replace::set_sh,      IFCFG, WVDIALSECT ],
#      [ "debug",              \&Utils::Replace::set_sh_bool, IFCFG, DEBUG ],
#      [ "serial_escapechars", \&Utils::Replace::set_sh_bool, IFCFG, ESCAPECHARS ],
#      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool, IFCFG, HARDFLOWCTL ],
     ]
   },

   "slackware-9.1.0" =>
   {
     iface_set    => \&activate_slackware_interface,
     iface_delete => \&delete_slackware_interface,
     fn =>
     {
       RC_INET_CONF => "/etc/rc.d/rc.inet1.conf",
       RC_LOCAL     => "/etc/rc.d/rc.local",
       IFACE        => "#iface#",
       IFACE_TYPE   => "#type#",
       TYPE         => "%ppp_type%",
       WIRELESS     => "/etc/pcmcia/wireless.opts",
       PPP_OPTIONS  => "/etc/ppp/options",
       PAP          => "/etc/ppp/pap-secrets",
       CHAP         => "/etc/ppp/chap-secrets",
       CHAT         => "/etc/ppp/pppscript",
     },
     table =>
     [
      [ "address",            \&Utils::Replace::set_rcinet1conf,   [ RC_INET_CONF, IFACE ], IPADDR ],
      [ "netmask",            \&Utils::Replace::set_rcinet1conf,   [ RC_INET_CONF, IFACE ], NETMASK ],
      [ "gateway",            \&Utils::Replace::set_rcinet1conf_global, RC_INET_CONF, GATEWAY ],
      [ "bootproto",          \&set_slackware_bootproto, [ RC_INET_CONF, IFACE ] ],
      [ "essid",              \&Utils::Replace::set_rcinet1conf,   [ RC_INET_CONF, IFACE ], WLAN_ESSID ],
      [ "key",                \&Utils::Replace::set_rcinet1conf,   [ RC_INET_CONF, IFACE ], WLAN_KEY ],
      [ "key_type",           \&set_wep_key_full, [ \&Utils::Replace::set_rcinet1conf, RC_INET_CONF, IFACE, WLAN_KEY, "%key%" ]],
      # Modem stuff
      [ "phone_number",       \&check_type, [TYPE, "modem", \&create_chatscript, CHAT ]],
      [ "phone_number",       \&check_type, [TYPE, "modem", \&create_pppgo ]],
      [ "update_dns",         \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "usepeerdns" ]],
      [ "noauth",             \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "noauth" ]],
      [ "set_default_gw",     \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "defaultroute" ]],
      [ "debug",              \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "debug" ]],
      [ "persist",            \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "persist" ]],
      [ "serial_hwctl",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_kw, PPP_OPTIONS, "crtscts" ]],
      [ "mtu",                \&check_type, [TYPE, "modem", \&Utils::Replace::join_first_str, PPP_OPTIONS, "mtu", "[ \t]+" ]],
      [ "mru",                \&check_type, [TYPE, "modem", \&Utils::Replace::join_first_str, PPP_OPTIONS, "mru", "[ \t]+" ]],
      [ "serial_port",        \&check_type, [TYPE, "modem", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^(/dev/[^ \t]+)" ]],
      [ "serial_speed",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^([0-9]+)" ]],
      [ "login",              \&check_type, [TYPE, "modem", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^name \"(.*)\"", "name \"%login%\"" ]],
      [ "serial_escapechars", \&check_type, [TYPE, "modem", \&Utils::Replace::join_first_str, PPP_OPTIONS, "escape", "[ \t]+" ]],
      [ "password",           \&check_type, [TYPE, "modem", \&set_pap_passwd, PAP, "%login%" ]],
      [ "password",           \&check_type, [TYPE, "modem", \&set_pap_passwd, CHAP, "%login%" ]],
      [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "(atd[tp])[w#\*0-9, \-]+" ]],
      [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "atd[tp]([w#\*0-9, \-]+)" ]],
      [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "atd[tp]([w#\*0-9, \-]+)", "%external_line%W%phone_number%" ]],
      [ "volume",             \&check_type, [TYPE, "modem", \&set_modem_volume, CHAT ]],
      #[ "ppp_options",        \&check_type, [TYPE, "modem", \&gst_network_set_ppp_options_unsup, PPP_OPTIONS ]],
     ]
   },

   "gentoo" =>
   {
     iface_set    => \&activate_gentoo_interface,
     iface_delete => \&delete_gentoo_interface,
     fn =>
     {
       NET          => "/etc/conf.d/net",
       PPPNET       => "/etc/conf.d/net.#iface#",
       INIT         => "net.#iface#",
       IFACE        => "#iface#",
       IFACE_TYPE   => "#type#",
       TYPE         => "%ppp_type%",
       WIRELESS     => "/etc/conf.d/wireless",
     },
     table =>
     [
      [ "dev",                \&create_gentoo_files ],
      [ "auto",               \&set_gentoo_service_status, INIT, "default" ],
      [ "bootproto",          \&set_gentoo_bootproto, [ NET, IFACE ]],
      [ "address",            \&Utils::Replace::set_confd_net_re, NET, "config_%dev%", "^[ \t]*([0-9\.]+)" ],
      [ "netmask",            \&Utils::Replace::set_confd_net_re, NET, "config_%dev%", "[ \t]+netmask[ \t]+[0-9\.]*", " netmask %netmask%"],
      [ "broadcast",          \&Utils::Replace::set_confd_net_re, NET, "config_%dev%", "[ \t]+broadcast[ \t]+[0-9\.]*", " broadcast %broadcast%" ],
      [ "remote_address",     \&Utils::Replace::set_confd_net_re, NET, "config_%dev%", "[ \t]+dest_address[ \t]+[0-9\.]*", " dest_address %remote_address%" ],
      # [ "gateway",            \&Utils::Replace::set_confd_net_re, NET, "routes_%dev%", "[ \t]*default[ \t]+(via|gw)[ \t]+[0-9\.\:]*", "default via %gateway%" ],
      [ "essid",              \&Utils::Replace::set_sh,           WIRELESS, "essid_%dev%" ],
      [ "key",                \&Utils::Replace::set_sh,           WIRELESS, "key_%essid%" ],
      [ "key_type",           \&set_wep_key_type,                 [ \&Utils::Replace::set_sh, WIRELESS, "key_%essid%", "%key%" ]],
      # modem stuff
      [ "dev",                \&check_type, [ TYPE, "modem", \&Utils::Replace::set_sh, PPPNET, PEER ]],
      [ "update_dns",         \&check_type, [ TYPE, "modem", \&Utils::Replace::set_sh_bool, PPPNET, PEERDNS ]],
      [ "mtu",                \&Utils::Replace::set_sh,                       PPPNET, MTU ],
      [ "mru",                \&Utils::Replace::set_sh,                       PPPNET, MRU ],
      [ "serial_port",        \&Utils::Replace::set_sh,                       PPPNET, MODEMPORT ],
      [ "serial_speed",       \&Utils::Replace::set_sh,                       PPPNET, LINESPEED ],
      [ "login",              \&Utils::Replace::set_sh,                       PPPNET, USERNAME ],
      [ "password",           \&Utils::Replace::set_sh,                       PPPNET, PASSWORD ],
      [ "ppp_options",        \&Utils::Replace::set_sh,                       PPPNET, PPPOPTIONS ],
      [ "set_default_gw",     \&Utils::Replace::set_sh_bool,                  PPPNET, DEFROUTE ],
      [ "debug",              \&Utils::Replace::set_sh_bool,                  PPPNET, DEBUG ],
      [ "persist",            \&Utils::Replace::set_sh_bool,                  PPPNET, PERSIST ],
      [ "serial_escapechars", \&Utils::Replace::set_sh_bool,                  PPPNET, ESCAPECHARS ],
      [ "serial_hwctl",       \&Utils::Replace::set_sh_bool,                  PPPNET, HARDFLOWCTL ],
      [ "phone_number",       \&Utils::Replace::set_sh,                       PPPNET, NUMBER ],
      [ "external_line",      \&Utils::Replace::set_sh,                       PPPNET, NUMBER, "%external_line%W%phone_number%" ],
      [ "volume",             \&set_modem_volume_sh,  PPPNET, INITSTRING ],
     ]
    },

    "freebsd-5" =>
    {
      iface_set    => \&activate_freebsd_interface,
      iface_delete => \&delete_freebsd_interface,
      fn =>
      {
        RC_CONF => "/etc/rc.conf",
        STARTIF => "/etc/start_if.#iface#",
        PPPCONF => "/etc/ppp/ppp.conf",
        IFACE   => "#iface#",
        IFACE_TYPE => "#type#",
        TYPE    => "%ppp_type%",
      },
      table =>
      [
       [ "auto",           \&set_freebsd_auto,      [ RC_CONF, IFACE ]],
       [ "bootproto",      \&set_freebsd_bootproto, [ RC_CONF, IFACE ]],
       [ "address",        \&Utils::Replace::set_sh_re,    RC_CONF, "ifconfig_%dev%", "inet[ \t]+([0-9\.]+)", "inet %address%" ],
       [ "netmask",        \&Utils::Replace::set_sh_re,    RC_CONF, "ifconfig_%dev%", "netmask[ \t]+([0-9\.]+)", " netmask %netmask%" ],
       [ "remote_address", \&Utils::Replace::set_sh_re,    RC_CONF, "ifconfig_%dev%", "dest_address[ \t]+([0-9\.]+)", " dest_address %remote_address%" ],
       [ "essid",          \&set_freebsd_essid,     [ RC_CONF, STARTIF, IFACE ]],
       # Modem stuff
       # we need this for putting an empty ifconfig_tunX command in rc.conf
       [ "phone_number",   \&Utils::Replace::set_sh,                         RC_CONF, "ifconfig_%dev%", " " ],
       [ "file",           \&create_ppp_startif, [ STARTIF, IFACE ]],
       [ "persist",        \&create_ppp_startif, [ STARTIF, IFACE ], "%file%" ],
       [ "serial_port",    \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "device" ],
       [ "serial_speed",   \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "speed"    ],
       [ "mtu",            \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "mtu"      ],
       [ "mru",            \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "mru"      ],
       [ "login",          \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "authname" ],
       [ "password",       \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "authkey"  ],
       [ "update_dns",     \&Utils::Replace::set_pppconf_bool,       [ PPPCONF, STARTIF, IFACE ], "dns"      ],
       [ "set_default_gw", \&set_pppconf_route, [ PPPCONF, STARTIF, IFACE ], "default HISADDR" ],
       [ "phone_number",   \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "phone"    ],
       [ "external_line",  \&Utils::Replace::set_pppconf,            [ PPPCONF, STARTIF, IFACE ], "phone", "%external_line%W%phone_number%" ],
       [ "dial_command",   \&set_pppconf_dial_command, [ PPPCONF, STARTIF, IFACE ]],
       [ "volume",         \&set_pppconf_volume,       [ PPPCONF, STARTIF, IFACE ]],
      ]
    },

    "solaris-2.11" =>
    {
      iface_set    => \&activate_sunos_interface,
      iface_delete => \&delete_sunos_interface,
      fn =>
      {
        INTERFACE   => "/etc/hostname.#iface#",
        DHCP_FILE   => "/etc/dhcp.#iface#",
        MASKS_FILE  => "/etc/netmasks",
        IFACE       => "#iface#",
        IFACE_TYPE  => "#type#",
        TYPE        => "%ppp_type%",
        DEFAULTROUTER => "/etc/defaultrouter",
        CHAT        => "/etc/chatscripts/%section%",
        PPP_OPTIONS => "/etc/ppp/peers/%section%",
        PAP         => "/etc/ppp/pap-secrets",
        CHAP        => "/etc/ppp/chap-secrets",
      },
      table =>
      [
       [ "address",            \&set_sunos_address,  [ INTERFACE, IFACE ]],
       [ "netmask",            \&set_sunos_netmask,  [ INTERFACE, MASKS_FILE, IFACE ], "%address%" ],
       [ "gateway",            \&set_sunos_gateway,  [DEFAULTROUTER, IFACE]],
       [ "bootproto",          \&set_sunos_bootproto, [ DHCP_FILE, INTERFACE, IFACE ]],
       #FIXME: there seems to be no way of setting an interface as noauto without removing the config file
       #[ "auto",               \&set_sunos_auto, [IFACE]],
       [ "essid",              \&set_sunos_wireless, [IFACE], "essid" ],
       [ "key",                \&set_sunos_wireless, [IFACE], "key" ],
       [ "key_type",           \&set_sunos_wireless, [IFACE], "key_type" ],
       # Modem stuff
       [ "ppp_type",           \&create_ppp_configuration, [ PPP_OPTIONS, CHAT ]],
       [ "section",            \&check_type, [TYPE, "modem", \&Utils::Replace::set_ppp_options_connect,  PPP_OPTIONS ]],
       [ "update_dns",         \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "usepeerdns" ]],
       [ "noauth",             \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "noauth" ]],
       [ "set_default_gw",     \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "defaultroute" ]],
       [ "debug",              \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "debug" ]],
       [ "persist",            \&check_type, [TYPE, ".+", \&Utils::Replace::set_kw, PPP_OPTIONS, "persist" ]],
       [ "serial_port",        \&check_type, [TYPE, "(modem|gprs)", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^(/dev/[^ \t]+)" ]],
       [ "serial_speed",       \&check_type, [TYPE, "(modem|gprs)", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^([0-9]+)" ]],
       [ "serial_port",        \&check_type, [TYPE, "pppoe", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^plugin[ \t]+rp-pppoe\.so[ \t]+(.*)", "plugin rp-pppoe.so %serial_port%" ]],
       [ "login",              \&check_type, [TYPE, ".+", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^user (.*)", "user \"%login%\"" ]],
       [ "password",           \&check_type, [TYPE, ".+", \&set_pap_passwd, PAP, "%login%" ]],
       [ "password",           \&check_type, [TYPE, ".+", \&set_pap_passwd, CHAP, "%login%" ]],
       [ "dial_command",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "(atd[tp])[w#\*0-9, \-]+" ]],
       [ "phone_number",       \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "atd[tp]([w#\*0-9, \-]+)" ]],
       [ "external_line",      \&check_type, [TYPE, "modem", \&Utils::Replace::set_chat, CHAT, "atd[tp]([w#\*0-9, \-]+)", "%external_line%W%phone_number%" ]],
       [ "phone_number",       \&check_type, [TYPE, "isdn", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^number (.*)", "number %phone_number%" ]],
       [ "external_line",      \&check_type, [TYPE, "isdn", \&Utils::Replace::set_ppp_options_re, PPP_OPTIONS, "^number (.*)", "number %external_line%W%phone_number%" ]],
       [ "volume",             \&check_type, [TYPE, "modem", \&set_modem_volume, CHAT ]],
       [ "apn",                \&check_type, [TYPE, "gprs", \&Utils::Replace::set_chat, CHAT, "cgdcont.*\"([^\"]+)\"" ]],
      ]
    },
  );
  
  my $dist = &get_interface_dist ();
  return %{$dist_tables{$dist}} if $dist;

  &Utils::Report::do_report ("platform_no_table", $Utils::Backend::tool{"platform"});
  return undef;
}

sub add_dialup_iface
{
  my ($ifaces) = @_;
  my ($dev, $i);

  $dev = "ppp0" if ($Utils::Backend::tool{"system"} eq "Linux");
  $dev = "tun0" if ($Utils::Backend::tool{"system"} eq "FreeBSD");

  foreach $i (@$ifaces)
  {
    return if ($i eq $dev);
  }

  push @$ifaces, $dev if (&Utils::File::locate_tool ("pppd"));
}

sub get_interfaces_config
{
  my (%dist_attrib, %config_hash, %hash, %fn);
  my (@config_ifaces, @ifaces, $iface, $dev);
  my ($dist, $value, $file, $proc);
  my ($i, $j);
  my ($modem_settings);

  %hash = &get_interfaces_info ();
  %dist_attrib = &get_interface_parse_table ();
  %fn = %{$dist_attrib{"fn"}};
  $proc = $dist_attrib{"ifaces_get"};

  # FIXME: is proc necessary? why not using hash keys?
  if ($proc)
  {
    @ifaces = &$proc ();
  }
  else
  {
    @ifaces = keys %hash;
  }

  &add_dialup_iface (\@ifaces);

  # clear unneeded hash elements
  foreach $i (@ifaces)
  {
    foreach $j (keys (%fn))
    {
      ${$dist_attrib{"fn"}}{$j} = &Utils::Parse::expand ($fn{$j},
                                                         "iface", $i,
                                                         "type",  &get_interface_type ($i));
    }

    $iface = &Utils::Parse::get_from_table ($dist_attrib{"fn"},
                                            $dist_attrib{"table"});

    &ensure_iface_broadcast_and_network ($iface);
    $$iface{"file"} = $i if ($$iface{"file"} eq undef);

    if (exists $hash{$i})
    {
      foreach $k (keys %$iface)
      {
        $hash{$i}{$k} = $$iface{$k};
      }
    }
    elsif (($i eq "ppp0") || ($dev eq "tun0"))
    {
      $hash{$i}{"dev"} = $i;
      $hash{$i}{"enabled"} = 0;

      foreach $k (keys %$iface)
      {
        $hash{$i}{$k} = $$iface{$k};
      }
    }
  }

  return \%hash;
}

sub interface_configured
{
  my ($iface) = @_;
  my ($type);

  # FIXME: checking for "configuration" key is much better
  $type = &get_interface_type ($$iface{"dev"});

  if ($type eq "ethernet" || $type eq "irlan")
  {
    return 1 if (($$iface{"bootproto"} eq "static" && $$iface{"address"} && $$iface{"netmask"}) || $$iface{"bootproto"} ne "static");
  }
  elsif ($type eq "wireless")
  {
    return 1 if ((($$iface{"bootproto"} eq "static" && $$iface{"address"} && $$iface{"netmask"}) || $$iface{"bootproto"} ne "static") && $$iface{"essid"});
  }
  elsif ($type eq "plip")
  {
    return 1 if ($$iface{"address"} && $$iface{"remote_address"});
  }
  elsif ($type eq "modem")
  {
    return 1 if ($$iface{"ppp_type"});
  }

  return 0;  
}

sub set_interface_config
{
  my ($dev, $values_hash, $old_hash) = @_;
  my (%dist_attrib, %fn);
  my ($i, $res);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_iface_set", $dev);

  %dist_attrib = &get_interface_replace_table ();
  %fn = %{$dist_attrib{"fn"}};

  foreach $i (keys (%fn))
  {
    $ {$dist_attrib{"fn"}}{$i} = &Utils::Parse::expand ($fn{$i},
                                                        "iface", $dev,
                                                        "type",  &get_interface_type ($dev));
  }

  $res = &Utils::Replace::set_from_table ($dist_attrib{"fn"}, $dist_attrib{"table"},
                                  $values_hash, $old_hash);

  &Utils::Report::leave ();
  return $res;
}

sub set_interfaces_config
{
  my ($values_hash) = @_;
  my ($old_hash);
  my (%dist_attrib);
  my ($i);
  my ($delete_proc, $set_proc);
  my ($do_active);

  &Utils::Report::enter ();
  &Utils::Report::do_report ("network_ifaces_set");
  
  %dist_attrib = &get_interface_replace_table ();
  $old_hash = &get_interfaces_config ();

  $delete_proc = $dist_attrib{"iface_delete"};
  $set_proc    = $dist_attrib{"iface_set"};

  foreach $i (keys %$values_hash)
  {
    $do_active = $$values_hash{$i}{"enabled"};

    # delete it if it's no longer configured
    if (&interface_configured ($$old_hash{$i}) &&
        !&interface_configured ($$values_hash{$i}))
    {
      &$set_proc ($$values_hash{$i}, $$old_hash{$i}, 0, 1);
      &$delete_proc ($$old_hash{$i});
    }
    elsif (&interface_configured ($$values_hash{$i}) &&
           &interface_changed ($$values_hash{$i}, $$old_hash{$i}))
    {
      $$values_hash{$i}{"file"} = $$old_hash{$i}{"file"};

      &$set_proc ($$values_hash{$i}, $$old_hash{$i}, 0, 1);
      &set_interface_config ($i, $$values_hash{$i}, $$old_hash{$i});
      &$set_proc ($$values_hash{$i}, $$old_hash{$i}, 1, 1) if ($do_active);
    }
    elsif ($$values_hash{$i}{"enabled"} != $$old_hash{$i}{"enabled"})
    {
      # only state has changed
      &$set_proc ($$values_hash{$i}, $$old_hash{$i}, $do_active, 1);
    }
  }

  &Utils::Report::leave ();
}

sub bootproto_to_code
{
  my ($iface) = @_;

  return 0 if (!&interface_configured ($iface));
  return ($$iface{"bootproto"} eq "dhcp") ? 2 : 1;
}

sub get_available_configuration_methods
{
  my $dist = $Utils::Backend::tool{"platform"};
  my $default = [ "static", "dhcp" ];
  my %dist_map = ();

  push @$default, @{$dist_map{$dist}};
  return $default;
}

sub get_available_encryptions
{
  my $dist = $Utils::Backend::tool{"platform"};
  my $default = [ "wep-hex", "wep-ascii" ];
  my %dist_map = (
    "debian"  => [ "wpa-psk", "wpa2-psk" ],
  );

  push @$default, @{$dist_map{$dist}};
  return $default;
}

sub get_available_ppp_types
{
  my $options = [ "modem" ];

  push @$options, "isdn" if &check_capi ();
  push @$options, "pppoe" if &check_pppd_plugin ("rp-pppoe");
  push @$options, "gprs";

  return $options;
}

sub get
{
  my ($config, $iface, $type);
  my ($ethernet, $wireless, $irlan);
  my ($plip, $modem);
  my ($config_methods, $encryptions);

  $config = &get_interfaces_config ();
  $config_methods = &get_available_configuration_methods ();
  $encryptions = &get_available_encryptions ();

  foreach $i (keys %$config)
  {
    $iface = $$config{$i};
    $type = &get_interface_type ($i);

    if ($type eq "ethernet")
    {
      push @$ethernet, [ $$iface{"dev"}, $$iface{"enabled"}, $$iface{"auto"},
                         &bootproto_to_code ($iface),
                         $$iface{"address"}, $$iface{"netmask"},
                         $$iface{"network"}, $$iface{"broadcast"}, $$iface{"gateway"},
                         $$iface{"bootproto"} ];
    }
    elsif ($type eq "wireless")
    {
      push @$wireless, [ $$iface{"dev"}, $$iface{"enabled"}, $$iface{"auto"},
                         &bootproto_to_code ($iface),
                         $$iface{"address"}, $$iface{"netmask"},
                         $$iface{"network"}, $$iface{"broadcast"}, $$iface{"gateway"},
                         $$iface{"essid"},
                         ($$iface{"key_type"} eq "wep-ascii") ? 0 : 1,
                         $$iface{"key"},
                         $$iface{"key_type"}, $$iface{"bootproto"} ];
    }
    elsif ($type eq "irlan")
    {
      push @$irlan, [ $$iface{"dev"}, $$iface{"enabled"}, $$iface{"auto"},
                      &bootproto_to_code ($iface),
                      $$iface{"address"}, $$iface{"netmask"},
                      $$iface{"network"}, $$iface{"broadcast"}, $$iface{"gateway"},
                      $$iface{"bootproto"} ];
    }
    elsif ($type eq "plip")
    {
      push @$plip, [ $$iface{"dev"}, $$iface{"enabled"}, $$iface{"auto"},
                     $$iface{"address"}, $$iface{"remote_address"} ];
    }
    elsif ($type eq "modem")
    {
      push @$modem, [ $$iface{"dev"}, $$iface{"enabled"}, $$iface{"auto"},
                      $$iface{"ppp_type"},
                      $$iface{"phone_number"}, $$iface{"external_line"},
                      $$iface{"serial_port"}, $$iface{"volume"},
                      ($$iface{"dial_command"} eq "atdp") ? 1 : 0,
                      $$iface{"login"}, $$iface{"password"},
                      $$iface{"set_default_gw"}, $$iface{"update_dns"},
                      $$iface{"persist"}, $$iface{"noauth"}, $$iface{"apn"} ];
    }
  }

  return ($ethernet, $wireless, $irlan,
          $plip, $modem,
          $config_methods, $encryptions,
          &get_available_ppp_types ());
}

sub set
{
  my ($ethernet, $wireless, $irlan, $plip, $ppp) = @_;
  my (%hash, $iface, $bootproto, $key_type, $dial_command);

  foreach $iface (@$ethernet)
  {
    if (!$$iface[9])
    {
      $$iface[9] = ($$iface[3] == 2) ? "dhcp" : "static";
    }

    $hash{$$iface[0]} = { "dev" => $$iface[0], "enabled" => $$iface[1], "auto" => $$iface[2],
                          "bootproto" => $$iface[9],
                          "address" => $$iface[4], "netmask" => $$iface[5], "gateway" => $$iface[8] };
  }

  foreach $iface (@$wireless)
  {
    if (!$$iface[13])
    {
      $$iface[13] = ($$iface[3] == 2) ? "dhcp" : "static";
    }

    if (!$$iface[12])
    {
      $$iface[12] = ($$iface[10] == 1) ? "wep-hex" : "wep-ascii";
    }

    $hash{$$iface[0]} = { "dev" => $$iface[0], "enabled" => $$iface[1], "auto" => $$iface[2],
                          "bootproto" => $$iface[13],
                          "address" => $$iface[4], "netmask" => $$iface[5], "gateway" => $$iface[8],
                          "essid" => $$iface[9], "key_type" => $$iface[12], "key" => $$iface[11] };
  }

  foreach $iface (@$irlan)
  {
    if (!$$iface[9])
    {
      $$iface[9] = ($$iface[3] == 2) ? "dhcp" : "static";
    }

    $hash{$$iface[0]} = { "dev" => $$iface[0], "enabled" => $$iface[1], "auto" => $$iface[2],
                          "bootproto" => $$iface[9],
                          "address" => $$iface[4], "netmask" => $$iface[5], "gateway" => $$iface[8] };
  }

  foreach $iface (@$plip)
  {
    $hash{$$iface[0]} = { "dev" => $$iface[0], "enabled" => $$iface[1], "auto" => $$iface[2],
                          "address" => $$iface[3], "remote_address" => $$iface[4] };
  }

  foreach $iface (@$ppp)
  {
    $dial_command = ($$iface[8] == 0) ? "ATDT" : "ATDP";
    $hash{$$iface[0]} = { "dev" => $$iface[0], "section" => $$iface[0], "enabled" => $$iface[1], "auto" => $$iface[2],
                          "ppp_type" => $$iface[3],
                          "phone_number" => $$iface[4], "external_line" => $$iface[5],
                          "serial_port" => $$iface[6], "volume" => $$iface[7],
                          "dial_command" => $dial_command,
                          "login" => $$iface[9], "password" => $$iface[10],
                          "set_default_gw" => $$iface[11], "update_dns"=> $$iface[12],
                          "persist" => $$iface[13], "noauth" => $$iface[14], "apn" => $$iface[15],
                          # FIXME: hardcoded serial speed ATM
                          "serial_speed" => "115200"};
  }

  &set_interfaces_config (\%hash);
}

sub get_files
{
  my (%dist_attrib, %config_hash, %hash, %fn);
  my (@ifaces, @files);
  my ($file, $proc);
  my ($i, $j);

  %hash = &get_interfaces_info ();
  %dist_attrib = &get_interface_parse_table ();
  %fn = %{$dist_attrib{"fn"}};
  $proc = $dist_attrib{"ifaces_get"};

  # FIXME: is proc necessary? why not using hash keys?
  if ($proc)
  {
    @ifaces = &$proc ();
  }
  else
  {
    @ifaces = keys %hash;
  }

  &add_dialup_iface (\@ifaces);

  # FIXME: this doesn't work for entries with %entry_name%
  foreach $i (@ifaces)
  {
    foreach $j (keys (%fn))
    {
      ${$dist_attrib{"fn"}}{$j} = &Utils::Parse::expand ($fn{$j},
                                                         "iface", $i,
                                                         "type",  &get_interface_type ($i));

      $file = ${$dist_attrib{"fn"}}{$j};
      push @files, $file if ($file =~ /^\//);
    }
  }

  return \@files;
}

1;
