#!/bin/bash
set -x # echo on

codename=`lsb_release --codename | cut -f2`
sudo sed -i "s|# deb http://archive.canonical.com/ubuntu $codename partner|deb http://archive.canonical.com/ubuntu $codename partner|g" "/etc/apt/sources.list"
sudo sed -i "s|# deb-src http://archive.canonical.com/ubuntu $codename partner|deb-src http://archive.canonical.com/ubuntu $codename partner|g" "/etc/apt/sources.list"
sudo apt-get update

sudo apt-get -qq install adobe-flashplugin
