#!/usr/bin/env bash

echo ">> Ensure Elasticsearch is not running."

if (( $(ps -ef | grep bootstrap | grep -v grep | wc -l) > 0 )); then 
  ps -ef | grep bootstrap | grep -v grep | awk '{print $2}' | xargs kill
fi

COUNT=1

while [ "$COUNT" -gt "0" ]
do
  if (( $(ps -ef | grep bootstrap | grep -v grep | wc -l) > 0 )); then 
    ps -ef | grep bootstrap | grep -v grep | awk '{print $2}' | xargs kill
  fi

  echo "Waiting for Elasticsearch to shut down..."
  sleep 5
  COUNT=$(ps -ef | grep bootstrap | grep -v grep | wc -l)
done

echo "Elasticsearch shut down"
