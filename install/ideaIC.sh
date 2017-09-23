#!/bin/bash
set -x # echo on

# IntelliJ IDEA is a Java integrated development environment (IDE) for developing computer software.
# It is developed by JetBrains (formerly known as IntelliJ), and is available as an Apache 2 Licensed community edition, and in a proprietary commercial edition.
# Both can be used for commercial development.

# Usage:
#  $ ./ideaIC.sh
#  $ ./ideaIC.sh --version="2017.2.4" --jdk=yes
#  $ ./ideaIC.sh --version="2017.2" --jdk=no

version="2017.2.4"
without_jdk=""

for i in "$@"
do
case $i in
    -v=*|--version=*)
    version="${i#*=}"
    shift # past argument=value
    ;;
    -j=*|--jdk=*)
    case "${i#*=}" in
        ("yes") without_jdk="" ;;
        ("no") without_jdk="-no-jdk" ;;
        (*) without_jdk="" ;;
    esac
    shift # past argument=value
    ;;
esac
done

read -p "Вы уверены, что хотите загрузить файл ideaIC-$version$without_jdk.tar.gz, который потом будет распакован в /opt/jetbrains/? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    
    cur_dir=$(pwd)
    
    # The first time pushd dir is called, pushd pushes the current directory onto the stack, then cds to dir and pushes it onto the stack.
    pushd "$cur_dir"
    
    wget "https://download.jetbrains.com/idea/ideaIC-$version$without_jdk.tar.gz" -P /tmp
    wget "https://download.jetbrains.com/idea/ideaIC-$version$without_jdk.tar.gz.sha256" -P /tmp

    cd /tmp

    sha256sum -c "ideaIC-$version$without_jdk.tar.gz.sha256" 2>&1 | grep OK

    cd /opt/
    sudo mkdir jetbrains
    cd /opt/jetbrains
    sudo tar xf "/tmp/ideaIC-$version$without_jdk.tar.gz"

    rm "/tmp/ideaIC-$version$without_jdk.tar.gz"
    rm "/tmp/ideaIC-$version$without_jdk.tar.gz.sha256"

    # echo "nohup /opt/jetbrains/idea-IC-172.4155.36/bin/idea.sh </dev/null >/dev/null 2>&1 &"

    # popd removes the top directory off the stack, revealing a new top. Then it cds to the new top directory.
    popd
fi

