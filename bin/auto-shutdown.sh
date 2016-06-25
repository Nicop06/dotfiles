#!/bin/sh

# 0 = EXIT_SUCCESS
# 1 = EXIT_FAILURE
TRUE=0
FALSE=1

# Default values for global variables
SHUTDOWNTIME=600
BTRFS_VOLUMES=
SAMBANETWORK=
STATUS_FILE=/var/run/auto-shutdown
DISABLE_FILE=/var/run/auto-shutdown.disable
CONF_FILE=/etc/auto-shutdown.conf


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


isBusy()
{
  # Disable auto-shutdown if this file is present
  if [ -f "$DISABLE_FILE" ] ; then
    return $TRUE
  fi

  # Check active connections
  if [ $(ss -tu -o state established | wc -l) -gt 0 ] ; then
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
}


checkTimeout()
{
  local oldtime, curtime
  curtime=$1

  if [ -f $STATUS_FILE ] ; then
    oldtime=$(cat $STATUS_FILE)
    if [ $(($curtime - $oldtime)) -ge $shutdowntime ] ; then
      return $TRUE
    fi
  fi

  return $FALSE
}


doAutoShutdown()
{
  local curtime
  curtime=$(date +%s)

  if (!isBusy) ; then
    # The system is not busy
    if (checkTimeout) ; then
      # Timeout is reached, do the shutdown
      [ -f $STATUS_FILE ] && rm $STATUS_FILE
      shutdown -P now
    fi
  else
    # The system is busy, record the current time
    echo $curtime > $STATUS_FILE
  fi
}



doAutoShutdown()
