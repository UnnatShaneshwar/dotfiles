#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.config/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Important programs
picom --experimental-backend &
feh --bg-fill ~/Pictures/backgrounds/w_73.png
xsetroot -cursor_name arrow &

# i3
#export DESKTOP_SESSION="i3"
#exec i3

# XMonad
#export DESKTOP_SESSION="xmonad"
#exec xmonad

# BSPWM
export DESKTOP_SESSION="bspwm"
exec bspwm
