#!/bin/bash

# Usage:
#  $ ./install_android-studio-ide.sh
#  $ ./install_android-studio-ide.sh --url="https://dl.google.com/dl/android/studio/ide-zips/3.1.0.16/android-studio-ide-173.4670197-linux.zip"
#  $ ./install_android-studio-ide.sh --url="https://dl.google.com/dl/android/studio/ide-zips/2.3.0.8/android-studio-ide-162.3764568-linux.zip"
#  $ ./install_android-studio-ide.sh --url="https://dl.google.com/dl/android/studio/ide-zips/2.2.2.0/android-studio-ide-145.3360264-linux.zip"

url="https://dl.google.com/dl/android/studio/ide-zips/3.1.0.16/android-studio-ide-173.4670197-linux.zip"

for i in "$@"
do
case $i in
    -u=*|--url=*)
    url="${i#*=}"
    shift # past argument=value
    ;;
esac
done

filename="${url##*/}"
foldername="${filename%.*}"

wget "$url" -P /tmp

# Unpack the .zip file you downloaded to an appropriate location for your applications, 
# such as within /usr/local/ for your user profile, or /opt/ for shared users.
sudo unzip -qq "/tmp/$filename" -d /opt/google/
sudo mv /opt/google/android-studio/ "/opt/google/$foldername"

# Required libraries for 64-bit machines:
# If you are running a 64-bit version of Ubuntu, you need to install some 32-bit libraries with the following command:
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
# If you are running 64-bit Fedora, the command is:
# sudo yum install zlib.i686 ncurses-libs.i686 bzip2-libs.i686

rm "/tmp/$filename"

# To launch Android Studio, open a terminal, 
# navigate to the android-studio/bin/ directory, and execute studio.sh.
echo "nohup /opt/google/$foldername/bin/studio.sh </dev/null >/dev/null 2>&1 &"

# Tip: To make Android Studio available in your list of applications, 
# select Tools > Create Desktop Entry from the Android Studio menu bar.


# Android SDK Location:
sudo mkdir -p "/opt/google/Android/Sdk"
sudo chmod a+rw -R "/opt/google/Android"
