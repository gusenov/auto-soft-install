#!/bin/bash
set -x  # echo on

# pip is a package management system used to install and manage software packages written in Python.
# Many packages can be found in the Python Package Index (PyPI).

sudo apt-get -qq install python3-pip
pip3 --version
