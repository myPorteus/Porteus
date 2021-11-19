if [ "$XDG_RUNTIME_DIR" = "" ]; then
  XDG_RUNTIME_DIR=/tmp/xdg-runtime-$USER
  mkdir -p $XDG_RUNTIME_DIR
  chown $USER $XDG_RUNTIME_DIR
  chmod 700 $XDG_RUNTIME_DIR
fi
export XDG_RUNTIME_DIR