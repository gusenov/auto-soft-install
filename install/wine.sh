#!/bin/bash
set -x  # echo on

# Wine is a free and open-source compatibility layer that aims to allow computer programs developed for Microsoft Windows to run on Unix-like operating systems.
# Winetricks is a script to install some basic components (typically Microsoft DLLs and fonts) and tweak settings required for some applications to run correctly under Wine.

sudo apt-get install wine

sudo apt-get install winetricks

winetricks comctl32
winetricks mfc42 
winetricks vcrun6
