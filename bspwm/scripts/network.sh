#!/bin/bash

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
  echo " Connected</fc>"
else
  echo " No-connection</fc>"
fi

