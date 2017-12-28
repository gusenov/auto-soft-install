#!/bin/bash
set -x # echo on

# Some operations required by Video DownloadHelper cannot be performed form within the browser.
# In order to be able to still to the job, the add-on relies on an external application that is called transparently.

url="https://github.com/mi-g/vdhcoapp/releases/download/v1.1.1/net.downloadhelper.coapp-1.1.1-1_amd64.deb"
sha256="d2d3c744d0bc9b7a21ce5e3b602bd36323695e4a2c19add783122478cdb0c552"

wget "$url" -P /tmp

filename="${url##*/}"

hash=$(sha256sum "/tmp/$filename" | awk '{ print $1 }')

if [ "$hash" == "$sha256" ]; then
    sudo dpkg -i "/tmp/$filename"
fi

rm "/tmp/$filename"
