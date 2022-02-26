#!/usr/bin/env bash

echo ">> Start Elasticsearch."

NORMAL_SLEEP=60

#COUNT_HTTP=$(curl -sL -w "%{http_code}" 10.132.57.64:9200 -o /dev/null | grep 000  | wc -l)
#COUNT_HTTPS=$(curl -sL -w "%{http_code}" https://10.132.57.64:9200 -k -o /dev/null | grep 000  | wc -l)

echo "Elasticsearch's checking.."

while [ 1 ]
do
        DATE=`date +%Y%m%d-%H%M%S`
        CNT=`jps -v | grep Elasticsearch|wc -l`
        
        #if [ $CNT -le 1 ]
        if [ $CNT -eq 0 ]
        then
							echo "$DATE >> Elasticsearch's checking..[OK]"
					    export LD_LIBRARY_PATH=/usr/local/lib; /ES/elasticsearch-5.4.1/bin/elasticsearch -d
					
					    # Wait for it to start up and the HTTP interface to be available
					    #while [ $CNT -le 1 ]
					    while [ $CNT -eq 0 ]
					    do
					        echo "$DATE >> Waiting for Elasticsearch to start up..."
					        sleep 5
					        #COUNT_HTTP=$(curl -sL -w "%{http_code}" 10.132.57.64:9200 -o /dev/null | grep 000  | wc -l)
					        #COUNT_HTTPS=$(curl -sL -w "%{http_code}" https://10.132.57.64:9200 -k -o /dev/null | grep 000  | wc -l)
					        CNT=`jps -v | grep Elasticsearch|wc -l`
					    done
    					echo "$DATE >> Elasticsearch started"
				else
							echo "$DATE >> Elasticsearch's already running.."
        fi
        sleep $NORMAL_SLEEP

done




