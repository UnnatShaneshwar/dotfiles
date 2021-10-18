#!/bin/bash

bspc desktop next -f && while grep -Fxq "$(bspc query -D -d)" ~/.config/bspwm/dontCycle; do bspc desktop next -f; done
