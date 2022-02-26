#!/usr/bin/env bash

echo ">> Start filebeat."

NORMAL_SLEEP=1800

#COUNT_HTTP=$(curl -sL -w "%{http_code}" 10.132.57.64:9200 -o /dev/null | grep 000  | wc -l)
#COUNT_HTTPS=$(curl -sL -w "%{http_code}" https://10.132.57.64:9200 -k -o /dev/null | grep 000  | wc -l)

echo "filebeat's checking.."

while [ 1 ]
do
        DATE=`date +%Y%m%d-%H%M%S`
        CNT=`jps -v | grep filebeat|wc -l`
        
        #if [ $CNT -le 1 ]
        if [ $CNT -eq 0 ]
        then
					    echo "$DATE >> filebeat's checking..[OK]"
					    export CLASSPATH=; export JAVA_HOME=/WAS/DATA/ES/jdk1.8.0_60/; nohup /WAS/DATA/ES/filebeat-5.2.0-linux-x86_64/filebeat -e /WAS/DATA/ES/filebeat-5.2.0-linux-x86_64/filebeat.yml 1> /dev/null 2>&1 &
					
					    # Wait for it to start up and the HTTP interface to be available
					    #while [ $CNT -le 1 ]
					    while [ $CNT -eq 0 ]
					    do
					        echo "$DATE >> Waiting for filebeat to start up..."
					        sleep 5
					        #COUNT_HTTP=$(curl -sL -w "%{http_code}" 10.132.57.64:9200 -o /dev/null | grep 000  | wc -l)
					        #COUNT_HTTPS=$(curl -sL -w "%{http_code}" https://10.132.57.64:9200 -k -o /dev/null | grep 000  | wc -l)
					        CNT=`jps -v | grep filebeat|wc -l`
					    done
    					echo "$DATE >> filebeat started"
				else
							echo "$DATE >> filebeat's already running.."
        fi
        sleep $NORMAL_SLEEP
        

done




