#!/bin/bash
set -x # echo on

# PyCharm is an Integrated Development Environment (IDE) used in computer programming, specifically for the Python language.

# Usage:
#  $ ./pycharm-community.sh
#  $ ./pycharm-community.sh --version="2017.2.3"
#  $ ./pycharm-community.sh -v="2017.1"
#  $ ./pycharm-community.sh -v="2016.2.3"

version="2017.2.3"

for i in "$@"
do
case $i in
    -v=*|--version=*)
    version="${i#*=}"
    shift # past argument=value
    ;;
esac
done

wget "https://download.jetbrains.com/python/pycharm-community-$version.tar.gz" -P /tmp
wget "https://download.jetbrains.com/python/pycharm-community-$version.tar.gz.sha256" -P /tmp
cd /tmp
sha256sum -c "pycharm-community-$version.tar.gz.sha256" 2>&1 | grep OK

cd /opt/
sudo mkdir jetbrains
cd /opt/jetbrains
sudo tar xf "/tmp/pycharm-community-$version.tar.gz"

rm "/tmp/pycharm-community-$version.tar.gz"
rm "/tmp/pycharm-community-$version.tar.gz.sha256"

echo "nohup /opt/jetbrains/pycharm-community-$version/bin/pycharm.sh </dev/null >/dev/null 2>&1 &"
