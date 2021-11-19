#!/bin/csh
# KDE additions:
if ( ! $?KDEDIRS ) then
    setenv KDEDIRS /usr
endif
setenv PATH ${PATH}:/usr/lib64/kf5:/usr/lib64/kde4/libexec

if ( $?XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS ${XDG_CONFIG_DIRS}:/etc/kde/xdg
else
    setenv XDG_CONFIG_DIRS /etc/xdg:/etc/kde/xdg
endif

if ( ! $?XDG_RUNTIME_DIR ) then
    setenv XDG_RUNTIME_DIR /tmp/xdg-runtime-$USER
    mkdir -p $XDG_RUNTIME_DIR
    chown $USER $XDG_RUNTIME_DIR
    chmod 700 $XDG_RUNTIME_DIR
endif
