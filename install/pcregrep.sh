#!/bin/bash
set -x # echo on

# Perl-style regexps have many useful features that the standard POSIX ones
# don't; this is basically the same as grep but with the different
# regexp syntax.

sudo apt-get -qq install pcregrep
