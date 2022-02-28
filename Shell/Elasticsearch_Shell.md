

# Elasticsearch_Shell.md

```sh
########################################
########################################
########################################
# elasticsearch 7.9 Shell Script
# Update : 21.01.06
########################################
########################################
########################################

echo "#######################################"
	
if [ "$1" = "start" ] ; then
	echo "Start AuthorizationServer Process !!"
	nohup /WAS/DATA/ES/AuthorizationServer/execute.sh 8180 /dev/null 2>&1 &
	nohup /WAS/DATA/ES/AuthorizationServer/execute.sh 8182 /dev/null 2>&1 &
	nohup /WAS/DATA/ES/AuthorizationServer/execute.sh 8184 /dev/null 2>&1 &
	nohup /WAS/DATA/ES/AuthorizationServer/execute.sh 8186 /dev/null 2>&1 &
elif [ "$1" = "stop" ] ; then
	echo "Stop AuthorizationServer Process !!"
	kill -9 $(ps aux |awk '/AuthorizationServer/ {print $2}')

else
	echo "input excute parameter. (start or stop)"

echo "#######################################"

ps -ef | grep AuthorizationServer



########################################
########################################
########################################
# elasticsearch 7.9 Shell Script
# Update : 21.01.06
########################################
########################################
########################################

#!/bin/ksh
clear

echo "######################################"
echo "####                              ####"
echo "####  START  AuthorizationServer  ####"
echo "####                              ####"
echo "######################################"
echo "================================================"

export LANG=ko_KR.UTF-8
export JAVA_HOME=/usr/local/jdk1.6.0_33/bin
export RUN_JAR=/TOM/AuthorizationServer/AuthorizationServer.jar

echo "> LANG : $LANG"
echo "> JAVA_HOME : $JAVA_HOME"
echo "> RUN_JAR : $RUN_JAR"


$JAVA_HOME/java -classpath $RUN_JAR -jar $RUN_JAR 8186




########################################
########################################
########################################
# elasticsearch 7.9 Shell Script
# Update : 21.01.06
########################################
########################################
########################################

#######################
#######################
#######################
# logstash_start.sh
#######################
#######################
#######################

#!/usr/bin/env bash

echo ">> Start logstash."

NORMAL_SLEEP=1800

#COUNT_HTTP=$(curl -sL -w "%{http_code}" 10.132.57.64:9200 -o /dev/null | grep 000  | wc -l)
#COUNT_HTTPS=$(curl -sL -w "%{http_code}" https://10.132.57.64:9200 -k -o /dev/null | grep 000  | wc -l)

echo "logstash's checking.."

while [ 1 ]
do
        DATE=`date +%Y%m%d-%H%M%S`
        CNT=`jps -v | grep logstash|wc -l`
        
        #if [ $CNT -le 1 ]
        if [ $CNT -eq 0 ]
        then
						echo "$DATE >> logstash's checking..[OK]"
					    export CLASSPATH=; export JAVA_HOME=/WAS/DATA/ES/jdk1.8.0_60/; /WAS/DATA/ES/connector_logstash/logstash-5.2.0/bin/logstash -f /WAS/DATA/ES/logstash-5.2.0/logstash_server_logs.conf &
					
					    # Wait for it to start up and the HTTP interface to be available
					    #while [ $CNT -le 1 ]
					    while [ $CNT -eq 0 ]
					    do
					        echo "$DATE >> Waiting for logstash to start up..."
					        sleep 5
					        #COUNT_HTTP=$(curl -sL -w "%{http_code}" 10.132.57.64:9200 -o /dev/null | grep 000  | wc -l)
					        #COUNT_HTTPS=$(curl -sL -w "%{http_code}" https://10.132.57.64:9200 -k -o /dev/null | grep 000  | wc -l)
					        CNT=`jps -v | grep logstash|wc -l`
					    done
    					echo "$DATE >> logstash started"
				else
							echo "$DATE >> logstash's already running.."
        fi
        sleep $NORMAL_SLEEP

done


#######################
#######################
#######################
# logstash_stop.sh
#######################
#######################
#######################

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




########################################
########################################
########################################
# elasticsearch 7.9 Shell Script
# Update : 21.01.06
########################################
########################################
########################################



#######################
#######################
#######################
# data_delete_curl.sh
#######################
#######################
#######################

#!/bin/ksh

RESULT=`curl -H 'Content-Type: application/json' -u 'elastic:gsaadmin' -XPOST 'http://10.132.57.75:9205/ict_sop_idx/_delete_by_query' -d '
{
  "query": {
    "match_all": {}
  }
}
'`

echo $RESULT




########################################
########################################
########################################
# elasticsearch 7.9 Shell Script
# Update : 21.01.06
########################################
########################################
########################################


#######################
#######################
#######################
# Feed_Client.sh
#######################
#######################
#######################

#!/bin/ksh
clear

#export LD_LIBRARY_PATH=./lib/lib_linux64:$LD_LIBRARY_PATH
#export LIBPATH=./lib/lib_linux64:$LIBPATH
#export CLASSPATH=.:./lib/fasoo-jni-2.7.6u.jar:$CLASSPATH

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/TOM/DrmDocFilter
export LIBPATH=$LIBPATH:/TOM/DrmDocFilter
export CLASSPATH=/TOM/DrmDocFilter/libfasoopackager.so:/TOM/DrmDocFilter/fasoo-jni-2.7.6u.jar:.

echo "###################################"
echo "####                           ####"
echo "####    START  GSA  FEEDS!     ####"
echo "####                           ####"
echo "###################################"
echo "================================================"

RUN_JAR=/WAS/DATA/ES/Feeds/ElasticFeeder.jar

echo ">URN_JAR : $RUN_JAR"

export RUN_JAR
export LANG=ko_KR

echo ">LANG : $LANG"


#echo "----<<<< feedJob.sh  BATCH  START!!!! >>>>----"
echo "----<<<< [$1] [$2] SYSTEM  BATCH  START!!!! >>>>----"
echo "========================================================="


#echo "---- START Start.java [`date +%T`]----"
echo "----START [$1] [$2] SYSTEM [`date +%T`]----"
start=`date +%T`
s_start=`perl -e 'print time()'`
t_start=`perl -e 'print time()'`
#/TOM/jdk1.8.0_131/bin/java -classpath /WAS/DATA/ES/Feeds/ElasticFeeder.jar -jar   /WAS/DATA/ES/Feeds/ElasticFeeder.jar  $1 $2
/TOM/jdk1.8.0_171/bin/java -classpath /WAS/DATA/ES/Feeds/ElasticFeeder.jar -jar   /WAS/DATA/ES/Feeds/ElasticFeeder.jar  $1 $2
s_end=`perl -e 'print time()'`
#echo "---- END   Start.java [`date +%T`]----"
echo "----END   [$1] [$2] SYSTEM [`date +%T`]----"
echo "----[$1] [$2] SYSTEM 소요 시간 : [ `expr $s_end - $s_start`초 ]----"
echo "---------------------------------------------------------"

end=`date +%T`
t_end=`perl -e 'print time()'`

#echo "----<<<< feedJob.sh  BATCH  END!!!! >>>>----"
echo "----<<<< [$1] [$2] SYSTEM  BATCH  END!!!! >>>>----"
echo "----배치 시작 시간 : [$start]----"
echo "----배치 종료 시간 : [$end]----"

#t_start=1336960472
#t_end=1336960572

minus=`expr $t_end - $t_start`
share=`expr $minus / 60`
rest=`expr $minus % 60`

if [ $minus -ge 60 ]
then
        #echo $share $rest
        #echo `expr $share`분 `expr $rest`초
        #echo $share 분 $rest 초
	echo "----서비스 총 소요 시간 : [ `expr $share`분 `expr $rest`초 ]----"
else
	echo "----서비스 총 소요 시간 : [ `expr $minus`초 ]----"
fi
#echo "----서비스 총 소요 시간 : [ `expr $t_end - $t_start`초 ]----"

echo "========================================================="
echo "###################################"
echo "####                           ####"
echo "####    END  GSA  FEEDS!       ####"
echo "####                           ####"
echo "###################################"



########################################
########################################
########################################
# elasticsearch 7.9 Shell Script
# Update : 21.01.06
########################################
########################################
########################################

echo "#######################################"
	
if [ "$1" = "start" ] ; then
	echo "Start Redis Process !!"
	/TOM/redis/redis-3.2.9/src/redis-server /TOM/redis/redis-3.2.9/cluster/8281/redis.conf
	/TOM/redis/redis-3.2.9/src/redis-server /TOM/redis/redis-3.2.9/cluster/8282/redis.conf
	/TOM/redis/redis-3.2.9/src/redis-server /TOM/redis/redis-3.2.9/cluster/8283/redis.conf
	/TOM/redis/redis-3.2.9/src/redis-server /TOM/redis/redis-3.2.9/cluster/8284/redis.conf
elif [ "$1" = "stop" ] ; then
	echo "Stop Redis Process !!"
	/TOM/redis/redis-3.2.9/src/redis-cli –p 8281 shutdown
	/TOM/redis/redis-3.2.9/src/redis-cli –p 8282 shutdown
	/TOM/redis/redis-3.2.9/src/redis-cli –p 8283 shutdown
	/TOM/redis/redis-3.2.9/src/redis-cli –p 8284 shutdown

else
	echo "input excute parameter. start or stop"

echo "#######################################"

ps -ef | grep redis
```
