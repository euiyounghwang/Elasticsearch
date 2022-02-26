#!/usr/bin/env bash

echo ">> Ensure logstash is not running."

if (( $(ps -ef | grep logstash | grep -v grep | wc -l) > 0 )); then 
  ps -ef | grep logstash | grep -v grep | awk '{print $2}' | xargs kill
fi

COUNT=1

while [ "$COUNT" -gt "0" ]
do
  if (( $(ps -ef | grep bootstrap | grep -v grep | wc -l) > 0 )); then 
    ps -ef | grep bootstrap | grep -v grep | awk '{print $2}' | xargs kill
  fi

  echo "Waiting for logstash to shut down..."
  sleep 5
  COUNT=$(ps -ef | grep logstash | grep -v grep | wc -l)
done

echo "Elasticsearch shut down"
