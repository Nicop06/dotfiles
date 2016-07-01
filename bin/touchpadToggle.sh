#! /bin/sh
pointer_status=$(synclient -l | grep TouchpadOff)
	
if [ -z `echo $pointer_status | grep -o 1` ]; then
	synclient TouchpadOff = 1
else
	synclient TouchpadOff = 0
fi
