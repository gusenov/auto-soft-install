#!/bin/bash
set -x # echo on

# Sencha Cmd is the cornerstone for building your Sencha Ext JS and Sencha Touch applications. 
# Sencha Cmd provides a full set of lifecycle management features such as scaffolding, code minification, production build generation, and more, to complement your Sencha projects. 

# Usage:
#  $ ./sencha-cmd.sh
#  $ ./sencha-cmd.sh --version="6.5.2" --architecture="amd64"
#  $ ./sencha-cmd.sh --version="6.5.2" --architecture="i386"

version="6.5.2"  # https://www.sencha.com/products/extjs/cmd-download/
architecture="amd64"

for i in "$@"
do
case $i in
    -v=*|--version=*)
    version="${i#*=}"
    shift # past argument=value
    ;;
    -a=*|--architecture=*)
    architecture="${i#*=}"
    shift # past argument=value
    ;;
esac
done

installer_zip="SenchaCmd-$version-linux-$architecture.sh.zip"
wget "http://cdn.sencha.com/cmd/$version/no-jre/$installer_zip" -P /tmp

cd /tmp
unzip -j "$installer_zip"  # extract all the files into the current directory

installer_sh=$(zipinfo -1 "$installer_zip")
#installer_sh="SenchaCmd-$version.15-linux-$architecture.sh"
version=$(echo "$installer_sh" | pcregrep --only-matching=1 "SenchaCmd-(.*)-linux-(amd64|i386)\.sh")

rm "/tmp/$installer_zip"

installation_path="/opt/sencha/cmd/$version"  # By default, the installation path is: ~/bin/Sencha/Cmd/{version}
sudo mkdir -p "$installation_path"
sudo chmod a+rw -R "/opt/sencha"

"./$installer_sh" -q -dir "$installation_path"  # https://docs.sencha.com/cmd/guides/intro_to_cmd.html#intro_to_cmd_-_installing_sencha_cmd_silently

rm "/tmp/$installer_sh"
