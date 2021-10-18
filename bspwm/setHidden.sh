#!/bin/bash

hid=$(bspc query -D -d);\

file=~/.config/bspwm/dontCycle;\

if grep -Fxq "$hid" "$file"; then sed -i /"$hid"/d "$file"; else echo "$hid" >> "$file"; fi
