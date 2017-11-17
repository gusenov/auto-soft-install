#!/bin/bash
set -x # echo on

# Brackets is an open-source editor written in HTML, CSS, and JavaScript with a primary focus on web development.

# Usage:
#  $ ./brackets.sh
#  $ ./brackets.sh --version="1.9"
#  $ ./brackets.sh -v="1.11"

version="1.11"

for i in "$@"
do
case $i in
    -v=*|--version=*)
    version="${i#*=}"
    shift # past argument=value
    ;;
esac
done

if [ "$version" == "1.9" ]; then
    #libgcrypt11="libgcrypt11_1.5.3-2ubuntu4.4_amd64.deb"
    libgcrypt11="libgcrypt11_1.5.3-2ubuntu4.5_amd64.deb"
    wget "http://security.ubuntu.com/ubuntu/pool/main/libg/libgcrypt11/$libgcrypt11" -P /tmp
    sudo dpkg -i "/tmp/$libgcrypt11"
    rm "/tmp/$libgcrypt11"
fi

url="https://github.com/adobe/brackets/releases/download/release-$version/Brackets.Release.$version.64-bit.deb"
filename="${url##*/}"
wget "$url" -P /tmp
sudo dpkg -i "/tmp/$filename"
rm "/tmp/$filename"
