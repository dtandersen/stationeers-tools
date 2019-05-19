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
stop-stationeers.sh
stationeers-map-trimmer -m /efs/stationeers/saves/$SAVE/world.bin -x=0 -y=0 --radius=250
rm -f /efs/stationeers/saves/$SAVE/world.bin
mv /efs/stationeers/saves/$SAVE/world.bin.trimmed /efs/stationeers/saves/$SAVE/world.bin
java -cp /opt/saxon/saxon9he.jar net.sf.saxon.Transform -s:/efs/stationeers/saves/$SAVE/world.xml -xsl:/opt/stationeers-xslt-filter/server-clean2.xslt -o:/efs/stationeers/saves/$SAVE/world.new.xml
rm -f /efs/stationeers/saves/$SAVE/world.xml
mv /efs/stationeers/saves/$SAVE/world.new.xml /efs/stationeers/saves/$SAVE/world.xml
start-stationeers.sh
