#!/usr/bin/env bash

if [ "$(id -u)" != "0" ]; then
  echo "ERROR: Run this script as root!"
fi

function valid_mac() {
	openssl rand -hex 1 | \
		tr '[:lower:]' '[:upper:]' | \
		xargs echo "obase=2;ibase=16;" | \
		bc | \
		cut -c1-6 | \
		sed 's/$/00/' | \
		xargs echo "obase=16;ibase=2;" | \
		bc | \
		sed "s/$/:$(openssl rand -hex 5 | \
		sed 's/\(..\)/\1:/g; s/.$//' | tr '[:lower:]' '[:upper:]')/"
}

NEW_MAC=$(valid_mac)

ifconfig en0 ether $NEW_MAC && ifconfig en0 down && ifconfig en0 up

echo "Mac changed to $NEW_MAC"
