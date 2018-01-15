#!/bin/bash
set -x # echo on

# KDiff3 compares two or three input files and shows the differences line by line and character by character.

if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    # The package "kdiff3" contains the full-featured version of the program.
    sudo apt-get -qq install kdiff3
else
    # This version of KDiff3 is stripped-down so that it doesn't depend on the KDE libraries.
    sudo apt-get -qq install kdiff3-qt
fi
