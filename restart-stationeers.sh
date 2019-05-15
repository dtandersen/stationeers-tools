if [ "$2" == "" ]; then
  echo Usage: restart-stationeers.sh [time] [save]
  exit
fi
TIME=$1
SAVE=$2
SAVEDELAY=30
TOTAL=$((TIME + SAVEDELAY))
srcon -c /home/centos/.srcon notice "The world will restart in $TOTAL seconds"
srcon -c /home/centos/.srcon shutdown -t $TOTAL
sleep $TIME
srcon -c /home/centos/.srcon notice "Saving world..."
srcon -c /home/centos/.srcon save $SAVE
srcon -c /home/centos/.srcon notice "The world will restart in $SAVEDELAY seconds"
sleep $SAVEDELAY
/usr/local/bin/start-stationeers.sh
