#!/bin/bash

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
  echo "<fc=#98c379><fn=1></fn> Connected</fc>"
else
  echo "<fc=#e06c75><fn=1></fn> No-connection</fc>"
fi

