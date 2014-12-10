#!/bin/sh

shutdowntime=600

tmp=/tmp/auto-shutdown.lock
nbusers=$(who | tail -n -2 | wc -l)
nbconnections=$(netstat | grep ESTABLISHED | grep -v localhost | wc -l)
time=$(date +%s)

update () {
	echo $time > $tmp
	exit 0
}

# Update time
if [ $nbusers -gt 0 -o $nbconnections -gt 0 -o ! -f $tmp ] ; then
	update
fi

for pool in $(zpool list -H -o name) ; do
	status="$(zpool status ${pool} | grep scrub)"
	case "${status}" in
		*"scrub in progress"*)
			update
			;;
	esac
done

oldtime=$(cat $tmp)
if [ "${oldtime:-x}" = "x" ] ; then 
	oldtime=$time
fi

if [ $(($time - $oldtime)) -ge $shutdowntime ] ; then
	rm $tmp
	poweroff
fi

exit 0
