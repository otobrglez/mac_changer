#!/usr/bin/env bash

if [ "$(id -u)" != "0" ]; then
  echo "ERROR: Run this script as root!"
fi

export NEW_MAC=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`

ifconfig en0 ether $NEW_MAC && \
  ifconfig en0 down && \
  ifconfig en0 up


echo "Mac changed to $NEW_MAC"
