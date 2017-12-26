#!/bin/bash
set -x # echo on

# XPaint is suitable for producing simple graphics.
# It does offer some advanced features such as image processing functions and gradient fill.
# In the C Script Editor of XPaint, the External editor in the File menu will invoke x-terminal-emulator -e sensible-editor.
# The gv package will be needed for PDF/PS reading, netpbm will be needed for external conversion, lpr for printing.

sudo apt-get -qq install xpaint
