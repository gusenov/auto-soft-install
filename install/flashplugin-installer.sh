#!/bin/bash
set -x # echo on

# Downloads and Installs the Adobe Flash Player plugin.
# The Adobe Flash Player plugin supports playing of media and other dynamic content online.

# The Adobe Flash Player plugin will work with a range of web-browsers including, limited to:
#  * Firefox
#  * Chromium
#  * SeaMonkey
#  * Iceweasel
#  * Iceape
#  * Galeon
#  * Epiphany
#  * Konqueror

# WARNING:
# Installing this Ubuntu package causes the Adobe Flash Player plugin to be downloaded from the Adobe web site.
# The distribution license of the Adobe Flash Player plugin is available at www.adobe.com.
# Installing this Ubuntu package implies that you have accepted the terms of that license.

sudo apt-get -qq install flashplugin-installer
