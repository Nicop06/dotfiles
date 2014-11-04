#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb .Xresources
xcompmgr -c &
xscreensaver -nosplash &
mpd &
pgrep -x urxvtd > /dev/null || urxvtd &
pgrep -x lightsOn.sh > /dev/null || $HOME/bin/lightsOn.sh 120 &
numlockx &
gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info"
exec awesome
