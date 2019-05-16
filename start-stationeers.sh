#!/bin/bash
source /etc/stationeers/stationeers.conf
WORLD=$SAVE
docker stop stationeers
docker rm stationeers
LOGFILE=/efs/stationeers/logs/stationeers-${WORLD}.log
touch "$LOGFILE"
docker run -d \
  -v $SAVE_DIR:/home/steam/stationeers/saves \
  -v /var/lib/stationeers:/home/steam/stationeers \
  -v /efs/stationeers/default.ini:/home/steam/stationeers/default.ini \
  -v /efs/stationeers/blocked.txt:/home/steam/stationeers/blocked.txt \
  -v "${LOGFILE}:/home/steam/stationeers/stationeers.log" \
  -p 27500:27500/udp -p 27500:27500 -p 27015:27015/udp \
  -e BRANCH=$BRANCH \
  --restart unless-stopped \
  --name stationeers \
  dtandersen/stationeers \
  rocketstation_DedicatedServer.x86_64 \
  -worldtype=$WORLDTYPE \
  -loadworld=$SAVE \
  -worldname=$SAVE \
  -clearallinterval=$CLEARALL \
  -autosaveinterval=$AUTOSAVE
