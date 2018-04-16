#!/bin/bash
set -x # echo on

# Augeas is a configuration editing tool. 
# It parses configuration files in their native formats and transforms them into a tree. 
# Configuration changes are made by manipulating this tree and saving it back into native config files.

sudo apt-get -qq install augeas-tools augeas-lenses
