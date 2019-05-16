#!/bin/bash -x
if [ "$1" == "" ]; then
  echo Usage: backup-stationeers.sh [save]
  exit
fi
source /etc/stationeers/stationeers.conf
srcon notice "Saving world..."
srcon save "$1"
sleep $SAVE_DELAY
SAVE=$1
BASE=/efs/stationeers/saves
BACKUP_DIR2="$BACKUP_DIR/$SAVE"
DTE=`date +"%Y%m%d-%H%M"`
BACKUP_NAME="$SAVE-$DTE.zip"
mkdir -p "$BACKUP_DIR2"
nice -n 19 7za a "$BACKUP_DIR2/$BACKUP_NAME" "$SAVE_DIR/$SAVE/*" -x'!Backup'
