#!/bin/sh

# 0 = EXIT_SUCCESS
# 1 = EXIT_FAILURE
TRUE=0
FALSE=1

# Default values for global variables
INACTIVITY_TIMEOUT=3600
INITIAL_TIMEOUT=3600
INTERVAL=60
BTRFS_VOLUMES=
SAMBANETWORK=
STATUS_FILE=/var/run/auto-shutdown
DISABLE_SHUTDOWN_FILES=/var/run/auto-shutdown.disable
CONF_FILE=/etc/auto-shutdown.conf
CRON_MODE=false

usage()
{
  echo "Usage: $(basename $0) [-f filename] [-i interval] [-c]"
}


checkScrub()
{
  local volume
  for volume in $BTRFS_VOLUMES ; do
    if (btrfs scrub status $volume | grep running > /dev/null 2>&1) ; then
      return $TRUE
    fi
  done
  return $FALSE
}


checkDisableFiles()
{
  local file
  for file in $DISABLE_SHUTDOWN_FILES ; do
    if [ -f $file ] ; then
      return $TRUE
    fi
  done

  return $FALSE
}


isBusy()
{
  # Disable auto-shutdown if this file is present
  if (checkDisableFiles) ; then
    return $TRUE
  fi

  # Check active connections
  if [ $(ss -tu -o state established | wc -l) -gt 1 ] ; then
    return $TRUE
  fi

  # Check connected users
  if [ $(who | wc -l) -gt 0 ] ; then
    return $TRUE
  fi

  # Check for btrfs scrub
  if (checkScrub) ; then
    return $TRUE
  fi

  # Check samba connections
  if [ "$SAMBANETWORK" ] ; then
    if (smbstatus | grep $SAMBANETWORK > /dev/null 2>&1) ; then
      return $TRUE
    fi
  fi

  return $FALSE
}


checkTimeout()
{
  local last_activity_time
  local inactivity_duration
  local curtime
  local uptime
  local timeout

  uptime=$(cat /proc/uptime | cut -f1 -d' ' | cut -f1 -d'.')
  curtime=$(date +%s)

  if [ -f $STATUS_FILE ] ; then
    # Get the last activity time stamp
    last_activity_time=$(cat $STATUS_FILE)

    # Sanity check in case the time in the status file is invalid,
    # use uptime
    if [ $(($curtime - $last_activity_time)) -lt $uptime ] ; then
      inactivity_duration=$(($curtime - $last_activity_time))
      timeout=$INACTIVITY_TIMEOUT
    else
      inactivity_duration=$uptime
      timeout=$INITIAL_TIMEOUT
    fi
  else
    # In case the status file is not set (no activity since system boot),
    # use the uptime as an activity time stamp
    inactivity_duration=$uptime
    timeout=$INITIAL_TIMEOUT
  fi

  # Check if the difference between last activity time stamp
  # and current time stamp is greater than the timeout
  if [ $inactivity_duration -ge $timeout ] ; then
    return $TRUE
  fi

  return $FALSE
}


doAutoShutdown()
{
  if (isBusy) ; then
    # The system is busy, record the current time
    date +%s > $STATUS_FILE
  else
    # The system is not busy
    if (checkTimeout) ; then
      # Timeout is reached, do the shutdown
      [ -f $STATUS_FILE ] && rm $STATUS_FILE
      shutdown -P now
    fi
  fi
}

while getopts ":f:i:c" opt; do
  case $opt in
    f) CONF_FILE=$OPTARG ;;
    i) INTERVAL=$OPTARG ;;
    c) CRON_MODE=true ;;
    *) usage; exit 1 ;;
  esac
done

# Source conf file if exists
[ -f $CONF_FILE ] && source $CONF_FILE

if $CRON_MODE ; then
  # Cron mode: check idle status and exit
  doAutoShutdown
else
  # Regular mode: check idle status forever and every INTERVAL seconds
  while true
  do
    doAutoShutdown
    sleep $INTERVAL
  done
fi

exit 0
