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

# Read Xressources
xrdb .Xresources
xset r rate 200 40

# Launch X applications
compton &
#xscreensaver -nosplash &

# Launch desktop daemons
mpd
pgrep -x lightsOn.sh > /dev/null || $HOME/bin/lightsOn.sh 120 &
numlockx &

# Offlineimap
#pgrep -x offlineimap > /dev/null || offlineimap -l ~/.offlineimap/logs/offlineimap.log &

# Background
#./.fehbg

session=${1:-awesome}

case $session in
    awesome           ) session=awesome;;
    bspwm             ) session=bspwm;;
    catwm             ) session=catwm;;
    cinnamon          ) session=cinnamon-session;;
    dwm               ) session=dwm;;
    enlightenment     ) session=enlightenment_start;;
    ede               ) session=startede;;
    fluxbox           ) session=startfluxbox;;
    gnome             ) session=gnome-session;;
    gnome-classic     ) session="gnome-session --session=gnome-classic";;
    i3|i3wm           ) session=i3;;
    icewm             ) session=icewm-session;;
    jwm               ) session=jwm;;
    kde               ) session=startkde;;
    mate              ) session=mate-session;;
    monster|monsterwm ) session=monsterwm;;
    notion            ) session=notion;;
    openbox           ) session=openbox-session;;
    unity             ) session=unity;;
    xfce|xfce4        ) session=startxfce4;;
    xmonad            ) session=xmonad;;
esac

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session ${session}
