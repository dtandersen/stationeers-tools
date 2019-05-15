#!/bin/bash -x
if [ "$1" == "" ]; then
  echo Specify save
  exit
fi
srcon notice "Saving world..."
srcon save "$1"
sleep 10
SAVE=$1
BASE=/efs/stationeers/saves
BACKUP_BASE=/efs/stationeers/backups
BACKUP_DIR="$BACKUP_BASE/$SAVE"
SAVE_DIR="$BASE/$SAVE"
DTE=`date +"%Y%m%d-%H%M"`
BACKUP_NAME="$SAVE-$DTE.zip"
mkdir -p "$BACKUP_DIR"
7za a "$BACKUP_DIR/$BACKUP_NAME" "$SAVE_DIR/*" -x'!Backup'
