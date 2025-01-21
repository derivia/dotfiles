#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# check if the interface is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <interface>"
  exit 1
fi

IF="$1"

# check if the interface is either tun0 or ppp0
if [[ "$IF" == "tun0" || "$IF" == "ppp0" ]]; then
  # check if tun0 or ppp0 exists in 'ip a'
  if ip a show $IF &>/dev/null; then
    echo "%{F#3AAE37}$IF%{F-}"
  else
    echo "%{F#C54242}$IF%{F-}"
  fi
else
  # for other interfaces, check their status using 'ip a'
  interface_status=$(ip a show $IF 2>/dev/null | grep -oP '(?<=state )\w+')

  case "$interface_status" in
    up)
      echo "%{F#3AAE37}$IF%{F-}"
      ;;
    down)
      echo "%{F#C54242}$IF%{F-}"
      ;;
  esac
fi
