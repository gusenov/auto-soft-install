#!/bin/bash
set -x # echo on

# youtube-dl is a command-line program to download videos from YouTube.com and a few more sites.
# It requires the Python interpreter (2.6, 2.7, or 3.2+), and it is not platform specific.

sudo apt-get -qq install python-pip
sudo -H pip install --upgrade youtube-dl
