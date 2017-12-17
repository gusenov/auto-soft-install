#!/bin/bash
set -x # echo on

# XnView MP is the enhanced version of XnView Classic.
# It is a powerful cross-platform media browser, viewer and converter.
# Compatible with more than 500 formats.

# Usage:
#  $ ./xnviewmp.sh
#  $ ./xnviewmp.sh --architecture="x64"

architecture="x64"

for i in "$@"
do
case $i in
    -a=*|--architecture=*)
    architecture="${i#*=}"
    shift # past argument=value
    ;;
esac
done

if [ "$architecture" == "x64" ]; then
    url="http://download.xnview.com/XnViewMP-linux-x64.deb"
else
    url="http://download.xnview.com/XnViewMP-linux.deb"
fi

wget "$url" -P /tmp
cd /tmp
filename="${url##*/}"
sudo dpkg -i "/tmp/$filename"
rm "/tmp/$filename"
