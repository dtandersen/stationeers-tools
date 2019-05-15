#!/bin/bash -x
if [ "$2" == "" ]; then
  echo Usage: backup-stationeers.sh [save] [zip]
  exit
fi
source /etc/stationeers/stationeers.conf
#srcon notice "Restoring world..."
SAVE=$1
BACKUP=$2
SAVE_PATH=$SAVE_DIR/$SAVE
BACKUP_PATH=$2
echo SAVE: $SAVE_PATH
echo BACKUP: $BACKUP_PATH
if [ ! -f "$BACKUP_PATH" ]; then
  echo ERROR: $BACKUP_PATH doesn\'t exist!
  exit
fi
mv $SAVE_PATH $SAVE_PATH.$RANDOM
7za e "$BACKUP_PATH" -o"$SAVE_PATH"
chmod 775 "$SAVE_PATH"
