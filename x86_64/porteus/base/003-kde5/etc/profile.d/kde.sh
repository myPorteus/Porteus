#!/bin/sh
# KDE additions:
KDEDIRS=/usr
export KDEDIRS
PATH="$PATH:/usr/lib64/kf5:/usr/lib64/kde4/libexec"
export PATH
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/kde/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/kde/xdg
fi
if [ "$XDG_RUNTIME_DIR" = "" ]; then
  XDG_RUNTIME_DIR=/tmp/xdg-runtime-$USER
  mkdir -p $XDG_RUNTIME_DIR
  chown $USER $XDG_RUNTIME_DIR
  chmod 700 $XDG_RUNTIME_DIR
fi
export XDG_CONFIG_DIRS XDG_RUNTIME_DIR

