#!/bin/bash

# Atom is a free and open-source text and source code editor for macOS, Linux, and Microsoft Windows with support for plug-ins written in Node.js, and embedded Git Control, developed by GitHub.

# Usage:
#  $ ./atom.sh
#  $ ./atom.sh --version="1.16.0"

version="1.22.1"

for i in "$@"
do
case $i in
    -v=*|--version=*)
    version="${i#*=}"
    shift # past argument=value
    ;;
esac
done

url="https://atom-installer.github.com/v$version/atom-amd64.deb"
filename="${url##*/}"

sudo apt-get --assume-yes install gvfs-bin
sudo apt-get install -f

rm "/tmp/$filename"
wget "$url" -P /tmp
sudo dpkg -i "/tmp/$filename"
rm "/tmp/$filename"
