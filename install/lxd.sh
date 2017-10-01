#!/bin/bash
set -x # echo on

# LXD is a next generation system container manager.
# It offers a user experience similar to virtual machines but using Linux containers instead.

sudo apt-get -qq install lxd

# Adding system user `lxd' (UID 120) ...
# Adding new user `lxd' (UID 120) with group `nogroup' ...
# Creating home directory `/var/lib/lxd/' ...
# Adding group `lxd' (GID 128) ...

# The default LXD bridge, lxdbr0, comes unconfigured by default.
# Only limited HTTP connectivity through a PROXY will be available.
# To go through the initial LXD configuration, run: lxd init

id
newgrp lxd
id

sudo lxd init

# Name of the storage backend to use (dir or zfs) [default=dir]: 
# Would you like LXD to be available over the network (yes/no) [default=no]? 
# Do you want to configure the LXD bridge (yes/no) [default=yes]? 

# Containers need a bridge to connect them together and to the host for outside network connectivity.
# Choosing this option will let you configure the default LXD bridge to your liking.
# If you would rather not have LXD do this for you, then you will be asked whether you want to use an existing bridge or just do everything manually.
# Would you like to setup a network bridge for LXD containers now? Yes

# A valid network interface name (e.g. lxdbr0).
# Bridge interface name: lxdbr0


# This is needed to provide IPv4 connectivity for your containers.
# Do you want to setup an IPv4 subnet? Yes

# A random subnet was selected for you
# This subnet was selected for your convenience and the next questions have been pre-answered accordingly.
# Please make sure this subnet isn't already in use somewhere on your network, if it is, change it to one which isn't.
# If you later notice network connectivity issues, re-configure lxd and pick a different subnet.

# A valid IPv4 address. (e.g. 10.0.8.1)
# IPv4 address: 10.119.36.1

# A valid CIDR mask. (e.g. 24)
# IPv4 CIDR mask: 24

# The first address to be handed out over DHCP (e.g. 10.0.8.2)
# First DHCP address: 10.119.36.2

# The last address to be handed out over DHCP (e.g. 10.0.8.254)
# Last DHCP address: 10.119.36.254

# The maximum number of DHCP leases that can be obtained. (e.g. 250)
# Max number of DHCP clients: 252

# This is needed unless you are using a routed IPv4 subnet.
# Do you want to NAT the IPv4 traffic? Yes


# This is needed to provide IPv6 connectivity for your containers.
# Do you want to setup an IPv6 subnet? Yes

# A random subnet was selected for you
# This subnet was selected for your convenience and the next questions have been pre-answered accordingly.
# Please make sure this subnet isn't already in use somewhere on your network, if it is, change it to one which isn't.
# If you later notice network connectivity issues, re-configure lxd and pick a different subnet.

# A valid IPv6 address (e.g. fd98:9e0:3744::1)
# IPv6 address: fd15:9399:b91b:6eb1::1

# A valid IPv6 netmask (e.g. 64)
# IPv6 CIDR mask: 64

# This is needed unless you are using a routed IPv6 subnet.
# Do you want to NAT the IPv6 traffic? Yes
