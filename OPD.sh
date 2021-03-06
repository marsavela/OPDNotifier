#!/bin/bash

source token

FILE='SAVED_EVENTS'

SAVED=$(cat $FILE)

EVENTS=$(curl -s 'http://www.oneplayerdown.com/api/events' | jq '.[].id')

for event in $EVENTS
do
  if test "${SAVED#*$event}" = "$SAVED"
  then
    date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"
    ENDPOINT="https://api.telegram.org/bot"$TOKEN"/sendMessage?chat_id=@oneplayerdown&text=Nuevo%20evento:%0Ahttp://www.oneplayerdown.com/events/"$event
    curl -s -X POST $ENDPOINT
    echo ''
  fi
done

echo $EVENTS > $FILE
