#!/bin/bash

_volume_pipe=/tmp/.volume-pipe
rm $_volume_pipe
mkfifo $_volume_pipe
~/.config/xmobar/scripts/volume.sh

