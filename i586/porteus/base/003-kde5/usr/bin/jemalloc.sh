#!/bin/sh

prefix=/usr
exec_prefix=/usr
libdir=/usr/lib

LD_PRELOAD=${libdir}/libjemalloc.so.1
export LD_PRELOAD
exec "$@"
