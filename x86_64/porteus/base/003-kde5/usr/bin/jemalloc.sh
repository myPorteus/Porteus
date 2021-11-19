#!/bin/sh

prefix=/usr
exec_prefix=/usr
libdir=/usr/lib64

LD_PRELOAD=${libdir}/libjemalloc.so.1
export LD_PRELOAD
exec "$@"
