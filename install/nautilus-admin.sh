#!/bin/bash
set -x  # echo on

# Nautilus Admin is a simple Python extension for the Nautilus file manager that adds some administrative actions to the right-click menu:
#  * Open as Administrator: opens a folder in a new Nautilus window running with administrator (root) privileges.
#  * Edit as Administrator: opens a file in a Gedit window running with administrator (root) privileges.

sudo apt-get install nautilus-admin
nautilus -q
