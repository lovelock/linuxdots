#!/bin/sh

#~/.xinitrc

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
fi
xrdb -merge $HOME/.Xresources
