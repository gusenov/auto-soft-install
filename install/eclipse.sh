#!/bin/bash
#set -x # echo on

# Eclipse IDE is an integrated development environment (IDE) used in computer programming, and is the most widely used Java IDE.

# Usage:
#  $ ./eclipse.sh

url="http://ftp.jaist.ac.jp/pub/eclipse/oomph/epp/oxygen/R2/eclipse-inst-linux64.tar.gz"
filename="${url##*/}"

cd /tmp

function download {
    wget "$url" -P /tmp
}

function check {
    echo "53af5bf43caa5617078889db2b410fb0611cfdf13649aff0341856d4dc19f6d33f8f828f83655c755c97701fb808fbd698232fac3bc8e42ce027e3a7d4f1d7fc  $filename" > "$filename.sha512"
    sha512sum -c "$filename.sha512" 2>&1 | grep OK
}

function extract {
    tar xf "$filename"
}

function installation {
    Installation_Folder="/opt/eclipse/$1"
    sudo mkdir -p "$Installation_Folder"
    sudo chmod a+rw -R "$Installation_Folder"
    
    cd eclipse-installer
    ./eclipse-inst
}

function desktop {

distribution="$3"

Name="$1"
Icon="/opt/eclipse/$distribution/eclipse/icon.xpm"
Exec="/opt/eclipse/$distribution/eclipse/eclipse"
Comment="$2"
StartupWMClass="$distribution"

cat >~/.local/share/applications/$distribution.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=$Name
Icon=$Icon
Exec=$Exec
Comment=$Comment
Categories=Development;IDE;
Terminal=false
StartupWMClass=$StartupWMClass
Encoding=UTF-8
StartupNotify=true
EOL

}

function clean {
    rm "/tmp/$filename"
    rm "/tmp/$filename.sha512"
    sudo rm -rf "/tmp/eclipse-installer"
}

function begin {
    download
    check
    extract
    installation "jee-oxygen"
    desktop "Eclipse IDE for Java EE Developers" \
            "Tools for Java developers creating Java EE and Web applications, including a Java IDE, tools for Java EE, JPA, JSF, Mylyn, EGit and others." \
            "jee-oxygen"
}

function end {
    clean
}

begin
#end
