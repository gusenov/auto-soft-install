#!/bin/bash
set -x # echo on

apt-cache search downloadhelper

sudo dpkg --remove net.downloadhelper.coapp

apt-cache search downloadhelper
