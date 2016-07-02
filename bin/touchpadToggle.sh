#! /bin/sh

NOTIFY=false
[ "$1" = "-n" ] && NOTIFY=true

pointer_status=$(synclient -l | grep TouchpadOff)
	
if [ -z `echo $pointer_status | grep -o 1` ]; then
	synclient TouchpadOff=1
  $NOTIFY && notify-send 'Touchpad' 'Disabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
else
	synclient TouchpadOff=0
  $NOTIFY && notify-send 'Touchpad' 'Enabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
fi
