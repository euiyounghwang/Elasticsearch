
# Search Guard Install (7.9)

```sh
##########################################
##########################################
##########################################
# elasticsearch data migration 7.9
# Search Guard 7.9 Install
# https://yongho1037.tistory.com/737
##########################################
##########################################
##########################################


# centos postman 
 . wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
 . tar -xzf postman.tar.gz -C /opt
 . sudo ln -s /opt/Postman/Postman /usr/bin/postman



General

The first time installation procedure on a production cluster is to:

1) Disable shard allocation



######################################################
######################################################
######################################################
### Cluster Reboot
######################################################
######################################################
######################################################

GET _cat/indices
GET _cluster/stats?human&pretty

# 클러스터 정지 전에 아래 명령으로 shard allocation도 중지시키고 
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "none"
  }
}

# 버퍼의 내용도 flush 시키셨다가
POST _flush/synced


# X-Pack 설치 후 노드를 다시 실행시키고 클러스터 상태가 yellow가 될 때까지 기다리신 다음 아래 명령으로 shard allocation을 재개시키시기 바랍니다. 
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "all"
  }
}


2) Stop all nodes
3) Install the Search Guard plugin on all nodes
4) Add at least the TLS configuration to elasticsearch.yml
5) Restart Elasticsearch and check that the nodes come up
6) Re-enable shard allocation by using sgadmin
7) Configure authentication/authorization, users, roles and permissions by uploading the Search Guard configuration with sgadmin


# Search Guard License : https://search-guard.com/licensing/
# Search Guard : https://docs.search-guard.com/latest/search-guard-versions

 Search Guard 개요
 . ELK의 X-pack 대신 사용 권한 기능을 제공하는 Free 오픈소스, SSL/TLS 적용 필수 (Kibana 로그인만 보안 적용 불가능) 설치
 . Search Guard Download 사이트에서 ELK 각 모듈별 버전에 맞는 플러그인 다운로드 후 설치
        예시: ELK 6.2.4 버전인 경우
            search-guard-6-6.2.4-22.3.zip
            search-guard-kibana-plugin-6.2.4-13.zip



######################################################
######################################################
######################################################
### Elasticsearch 7.9.0 with SearchGuard
######################################################
######################################################
######################################################


1) Root 계정이 아닌 일반계정으로 설치할것
 - Search Guard 설치시 인증을 위해 Master와 Data Node 1대씩 같이 설치(아래 단계) 할것
   . 준비사항 : elasticsearch-7.9.0-linux-x86_64.tar.gz, kibana-7.9.0-linux-x86_64.tar.gz, search-guard-suite-plugin-7.9.0-45.0.0.zip
     -  Download : 10.132.12.89(172.31.137.89), tomadmt/posco123 (경로 : /TOM/Elastic_Download/)
   . 설치순서 : 
     - Master1대 우선설치 (아래 가이드 참고) 후 실행
     - 데이터노드 설치(설치 시 plugins 및 config 파일 복사 후 수정) 후 실행
     - Master 노드에서 searchguard (/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/tools/sgadmin_demo.sh) 실행 후,
       데이터노드로 searchguard 사용 인덱스 등 생성, 인증 완료 처리)
      ※ sgadmin_demo.sh : 사용자인증, 키 등  searchguard 를 클러스터에서 사용을 위한 명령어 shell임
     - 단계별 설치 순서는 2번을 참고

   ※ Master1대, 데이터노드1대 설치 및 인증후, 
     추가되는 Master 및 데이터노드는 노드 역할에 맞게 elasticsearch 압축을 푼후, plugins 폴더 내 SearchGuard 설치폴더 복사
   ※ Config 폴더 내 elasticsearch.yml을 포함해서 ./Config 내 파일 복사 후 elasticsearch.yml 및 jvm.option 메모리 값 변경
     (Master 노드는 8G, 데이터노드는 32G로 설정할 것)
     
 
2) 설치(아래 단계별로 할것) 및 사전 설정 단계(우선 Master 노드)
 - 설치 및 설정은 일반계정(root 가 아닌 devuser, esuser 등 검색 계정으로..)

. tar -zxvf elasticsearch-7.9.0-linux-x86_64.tar.gz

- Elasticsearch Plugin 설치
./bin/elasticsearch-plugin install analysis-nori
./bin/elasticsearch-plugin install analysis-icu
./bin/elasticsearch-plugin install -b file:///home/ES/DEV_Cluster/Master/search-guard-suite-plugin-7.9.0-45.0.0.zip

future versions of Elasticsearch will require Java 11; your Java version from [/usr/local/jdk1.8.0_60/jre] does not meet this requirement
-> Installing file:/home/ES/search-guard-suite-plugin-7.9.0-45.0.0.zip
-> Downloading file:/home/ES/search-guard-suite-plugin-7.9.0-45.0.0.zip
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@     WARNING: plugin requires additional permissions     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
* java.io.FilePermission /proc/sys/net/core/somaxconn read
* java.lang.RuntimePermission accessClassInPackage.com.sun.jndi.*
* java.lang.RuntimePermission accessClassInPackage.sun.misc
* java.lang.RuntimePermission accessClassInPackage.sun.nio.ch
* java.lang.RuntimePermission accessClassInPackage.sun.security.x509
* java.lang.RuntimePermission accessDeclaredMembers
* java.lang.RuntimePermission accessUserInformation
* java.lang.RuntimePermission createClassLoader
* java.lang.RuntimePermission getClassLoader
* java.lang.RuntimePermission setContextClassLoader
* java.lang.RuntimePermission shutdownHooks
* java.lang.reflect.ReflectPermission suppressAccessChecks
* java.net.NetPermission getNetworkInformation
* java.net.NetPermission getProxySelector
* java.net.SocketPermission * connect,accept,resolve
* java.security.SecurityPermission getProperty.ssl.KeyManagerFactory.algorithm
* java.security.SecurityPermission insertProvider.BC
* java.security.SecurityPermission org.apache.xml.security.register
* java.security.SecurityPermission putProviderProperty.BC
* java.security.SecurityPermission setProperty.ocsp.enable
* java.util.PropertyPermission * read,write
* java.util.PropertyPermission org.apache.xml.security.ignoreLineBreaks write
* javax.security.auth.AuthPermission doAs
* javax.security.auth.AuthPermission modifyPrivateCredentials
* javax.security.auth.kerberos.ServicePermission * accept
See http://docs.oracle.com/javase/8/docs/technotes/guides/security/permissions.html
for descriptions of what these permissions allow and the associated risks.
-> Installed search-guard-7

- elasticsearch-7.9.0 폴더 내 plugins 폴더로 이동

. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7
. cd tools/
. chmod 755 *.sh

- elasticsearch.yml 내 각종 설정 값 및 라이브러리 설치를 위한 작업

$ ./install_demo_configuration.sh


Search Guard 7 Demo Installer
 ** Warning: Do not use on production or public reachable systems **
Install demo certificates? [y/N] y
Initialize Search Guard? [y/N] y
Cluster mode requires maybe additional setup of:
  - Virtual memory (vm.max_map_count)
    See https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html

Enable cluster mode? [y/N] y
Basedir: /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0
Elasticsearch install type: .tar.gz on CentOS Linux release 7.8.2003 (Core)
Elasticsearch config dir: /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config
Elasticsearch config file: /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/elasticsearch.yml
Elasticsearch bin dir: /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/bin
Elasticsearch plugins dir: /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins
Elasticsearch lib dir: /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/lib
Detected Elasticsearch Version: x-content-7.9.0
Detected Search Guard Version: *



- 사용자 추가 (검색엔진 클러스터 HTTP Authentication API 기반 인증)
 ※ posroesd(Feed 색인계정), elastic(검색계정) 2개 계정은 필수로 추가해야함
  - 패스워드는 gsaadmin 임

. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/
. vi sg_internal_users.yml

===============
elastic:
  hash: "$2y$12$ScV8euAglZETM/H1xTuQkOP36raAW7ylOw/pVpF10QKja3RSW2aYu"
  reserved: false
  backend_roles:
  - "admin"
  description: "common admin"


-- 아래 계정 추가  
posroesd:
  hash: "$2y$12$ScV8euAglZETM/H1xTuQkOP36raAW7ylOw/pVpF10QKja3RSW2aYu"
  reserved: false
  backend_roles:
  - "admin"
  description: "feed admin"

===============

- 추가 계정에 대한 패스워드 값은 아래 hash.sh을 통해서 값을 추출할 수 있음

./hash.sh 
WARNING: JAVA_HOME not set, will use /usr/bin/java
[Password:]
$2y$12$UhovBA4wJq4gzO0ikCOFsOlrYAn1J9Wv65vaNd/BOW/Q9kh9KErja




- 인증키 설정 (기본적으로 elasticsearch 9200, 9300 포트를 쓸 경우에는 설정 불필요하지만 아래처럼 클러스터명, 포트를 명시하는게 좋다..)
 ※ 인증 사용자, searchguard 라이선스, 키 등 searchguard가 필요한 정보를 검색엔진내 저장하기 위해 사용

- 포트를 달리하게 될 경우, 하기 명령어 내 포트정보를 추가해야함
- 예) 
	ES_MY_CLUSTER_7.9 -h 10.132.11.83 -p 9310 (9310은 http 포트가 아닌 transport port임)
	ES_ZOO_PROD_7.9  -h 192.168.79.107 -p 9300

※ Master 노드, 데이터노드 모두 실행 중인 상태에서 Master 노드에서 아래 sgadmin_demo.sh 실행

. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/tools
. vi sgadmin_demo.sh

#!/bin/bash

#"/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/tools/sgadmin.sh" -cd "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig" -icl -key "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/kirk-key.pem" -cert "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/kirk.pem" -cacert "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/root-ca.pem" -nhnv
"/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/tools/sgadmin.sh" ES_MY_CLUSTER_7.9 -h 10.132.17.62 -p 9310 -cd "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig" -icl -key "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/kirk-key.pem" -cert "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/kirk.pem" -cacert "/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/root-ca.pem" -nhnv




3)노드설정 (elasticsearch.yml)
 - 아래 예제는 실제 searchguard 7.9 버전 설치 시 추가되는 항목과 함께 수정해야할 값 샘플임

##############################################
##############################################

# ======================== Elasticsearch Configuration =========================
#
# NOTE: Elasticsearch comes with reasonable defaults for most settings.
#       Before you set out to tweak and tune the configuration, make sure you
#       understand what are you trying to accomplish and the consequences.
#
# The primary way of configuring a node is via this file. This template lists
# the most important settings you may want to configure for a production cluster.
#
# Please consult the documentation for further information on configuration options:
# https://www.elastic.co/guide/en/elasticsearch/reference/index.html
#
# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
#

# 수정할부분
cluster.name: ES_MY_CLUSTER_7.9

#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
#
#node.name: node-1

# 수정할부분

node.name: ES_MA_#01

node.master: true
node.data: false


#
# Add custom attributes to the node:
#
#node.attr.rack: r1
#
# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
#
#path.data: /path/to/data
#
# Path to log files:
#
#path.logs: /path/to/logs
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
#
bootstrap.memory_lock: true
#
# Make sure that the heap size is set to about half the memory available
# on the system and that the owner of the process is allowed to use this
# limit.
#
# Elasticsearch performs poorly when the system is swapping the memory.
#
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#

# 수정할부분
network.host: 10.132.17.62

#
# Set a custom port for HTTP:
#

# 수정할부분
http.port: 9210

# 수정할부분
transport.tcp.port: 9310

#
# For more information, consult the network module documentation.
#
# --------------------------------- Discovery ----------------------------------
#
# Pass an initial list of hosts to perform discovery when this node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
#
#discovery.seed_hosts: ["host1", "host2"]
#
# Bootstrap the cluster using an initial set of master-eligible nodes:
#
#cluster.initial_master_nodes: ["node-1", "node-2"]
#
# For more information, consult the discovery and cluster formation module documentation.
#
#

# 수정할부분

cluster.initial_master_nodes: ["10.132.17.62:9310"]

discovery.seed_hosts: ["10.132.17.62:9310"]



#
#
# ---------------------------------- Gateway -----------------------------------
#
# Block initial recovery after a full cluster restart until N nodes are started:
#
#gateway.recover_after_nodes: 3
#
# For more information, consult the gateway module documentation.
#
# ---------------------------------- Various -----------------------------------
#
# Require explicit names when deleting indices:
#
#action.destructive_requires_name: true
# 수정할부분 : searchguard.ssl.http.enabled: false

######## Start Search Guard Demo Configuration ########
# WARNING: revise all the lines below before you go into production
searchguard.ssl.transport.pemcert_filepath: esnode.pem
searchguard.ssl.transport.pemkey_filepath: esnode-key.pem
searchguard.ssl.transport.pemtrustedcas_filepath: root-ca.pem
searchguard.ssl.transport.enforce_hostname_verification: false
searchguard.ssl.http.enabled: false
searchguard.ssl.http.pemcert_filepath: esnode.pem
searchguard.ssl.http.pemkey_filepath: esnode-key.pem
searchguard.ssl.http.pemtrustedcas_filepath: root-ca.pem
searchguard.allow_unsafe_democertificates: true
searchguard.allow_default_init_sgindex: true
searchguard.authcz.admin_dn:
  - CN=kirk,OU=client,O=client,L=test, C=de

searchguard.audit.type: internal_elasticsearch
searchguard.enable_snapshot_restore_privilege: true
searchguard.check_snapshot_restore_write_privileges: true
searchguard.restapi.roles_enabled: ["SGS_ALL_ACCESS"]
cluster.routing.allocation.disk.threshold_enabled: false
xpack.security.enabled: false
######## End Search Guard Demo Configuration ########

# 추가항목
bootstrap.system_call_filter: false
searchguard.enterprise_modules_enabled: false
indices.breaker.total.use_real_memory: false
indices.query.bool.max_clause_count: 100000


##############################################
##############################################



4) Elasticsearch 7.9.0 실행 전 (Master 노드)
- 실행전, 동의어 사전 등 기본 설정
. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/
. mkdir analysis
※ config/analysis/synonym.txt 형태로 파일 만들어서 사용하면 됨
- 아래는 복합명사 사전을 위해 기본으로 만들어놓을것
예)
"analysis" : {
	 "tokenizer" : {
			"nori_user_dict" : {
	    	"type" : "nori_tokenizer",
	      "user_dictionary" : "userdic_ko.txt",
	      "decompound_mode" : "mixed"
	     }
	  }
}
 . cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/ 디렉토리 내에서 복합명사 처리 txt 파일을 아래처럼 생성할것..
. vi userdic_ko.txt
#Additional nouns
슬라브공정
포스코건설
북미정상회담
:wq!


5) Elasticsearch 7.9.0 실행 (Master 노드)

- elasticsearch가 실행 된 후 아래 sgadmin 스크립트를 실행 시켜주어야 Search Guard를 사용하기 위해 필요한 데이터들이 elasticsearch에 생성된다.
. /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/bin/elastic



6) 데이터노드 설치
 - 데이터노드 설치는 Master 노드와 동일하게 설치하고 plugins 아래 전체폴더, confing 아래 전체 디렉토리 및 파일은 
   Master 노드에서 복사후 elasticsearch.yml 정보 수정, jvm.options 정보 수정 후 실행하면 됨
   (node role, ip address, port 등)
   . cp -r /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/* ./
   . cp -r /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/config/* ./




7) 최종 Master 노드, 데이터노드 전체 2대에서 인증처리
 - Master 노드, 데이터 노드 1대씩 실행상태에서 아래 인증 처리 명령어 수행

## MASTER 노드
-> DATA 복사 config 아래 인증키 및 plugins/search_guard_7 폴더
. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/tools/
. ./sgadmin_demo.sh 

WARNING: JAVA_HOME not set, will use /usr/bin/java
Search Guard Admin v7
Will connect to 10.132.17.62:9310
ERR: Seems there is no Elasticsearch running on 10.132.17.62:9310 - Will exit
[devuser@localhost tools]$ ./sgadmin_demo.sh 
WARNING: JAVA_HOME not set, will use /usr/bin/java
Search Guard Admin v7
Will connect to 10.132.17.62:9310 ... done
Connected as CN=kirk,OU=client,O=client,L=test,C=de
Elasticsearch Version: 7.9.0
Search Guard Version: 7.9.0-45.0.0
Contacting elasticsearch cluster 'elasticsearch' and wait for YELLOW clusterstate ...
Clustername: ES_MY_CLUSTER_7.9
Clusterstate: YELLOW
Number of nodes: 2
Number of data nodes: 1
searchguard index already exists, so we do not need to create one.
Populate config from /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_action_groups.yml OK
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_internal_users.yml OK
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_roles.yml OK
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_roles_mapping.yml OK
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_config.yml OK
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_tenants.yml OK
/home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_blocks.yml OK
Will update '_doc/config' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_config.yml 
   SUCC: Configuration for 'config' created or updated
Will update '_doc/roles' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_roles.yml 
   SUCC: Configuration for 'roles' created or updated
Will update '_doc/rolesmapping' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_roles_mapping.yml 
   SUCC: Configuration for 'rolesmapping' created or updated
Will update '_doc/internalusers' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_internal_users.yml 
   SUCC: Configuration for 'internalusers' created or updated
Will update '_doc/actiongroups' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_action_groups.yml 
   SUCC: Configuration for 'actiongroups' created or updated
Will update '_doc/tenants' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_tenants.yml 
   SUCC: Configuration for 'tenants' created or updated
Will update '_doc/blocks' with /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/sg_blocks.yml 
   SUCC: Configuration for 'blocks' created or updated
Done with success
[devuser@localhost tools]$ 


- 인증 및 사용자 등 설정값이 클러스터내 저장이 완료되면 각 노드별로 아래와 같은 로그가 추가가 된다.

. Master 노드
[2021-07-29T14:34:42,843][INFO ][o.q.c.QuartzScheduler    ] [ES_MA_#01] Scheduler meta-data: Quartz Scheduler (v2.3.2) 'signals/admin_tenant' with instanceId 'signals/admin_tenant'
  Scheduler class: 'org.quartz.core.QuartzScheduler' - running locally.
  NOT STARTED.
  Currently in standby mode.
  Number of jobs executed: 0
  Using thread pool 'org.quartz.simpl.SimpleThreadPool' - with 3 threads.
  Using job-store 'com.floragunn.searchsupport.jobs.core.IndexJobStateStore' - which supports persistence. and is clustered.

[2021-07-29T14:34:42,843][INFO ][o.q.c.QuartzScheduler    ] [ES_MA_#01] JobFactory set to: com.floragunn.searchsupport.jobs.execution.AuthorizingJobDecorator$DecoratingJobFactory@50427fd

. 데이터노드

[2021-07-29T02:44:09,916][INFO ][o.q.c.QuartzScheduler    ] [ES_DATA_#01] Scheduler meta-data: Quartz Scheduler (v2.3.2) 'signals/admin_tenant' with instanceId 'signals/admin_tenant'
  Scheduler class: 'org.quartz.core.QuartzScheduler' - running locally.
  NOT STARTED.
  Currently in standby mode.
  Number of jobs executed: 0
  Using thread pool 'org.quartz.simpl.SimpleThreadPool' - with 3 threads.
  Using job-store 'com.floragunn.searchsupport.jobs.core.IndexJobStateStore' - which supports persistence. and is clustered.

[2021-07-29T02:44:09,917][INFO ][o.q.c.QuartzScheduler    ] [ES_DATA_#01] JobFactory set to: com.floragunn.searchsupport.jobs.execution.AuthorizingJobDecorator$DecoratingJobFactory@1cb077ee
[2021-07-29T02:44:09,917][INFO ][o.q.c.QuartzSc


- 추가로 사용자 추가(e.x, add_account)시, Master 노드에서
. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/sgconfig/
. vi sg_internal_users.yml
 
 ===============
add_account:
  hash: "$2y$12$ScV8euAglZETM/H1xTuQkOP36raAW7ylOw/pVpF10QKja3RSW2aYu"
  reserved: false
  backend_roles:
  - "admin"
  description: "common admin"

!wq!

- 클러스터내 사용자 추가 명령어 실행
. cd /home/ES/DEV_Cluster/Master/elasticsearch-7.9.0/plugins/search-guard-7/tools/
. ./sgadmin_demo.sh
. 이후 클러스터 재반영

- 최종 : http://localhost:9210 브라우저에서 인증이 정상적으로 로그인 되면 성공..~~





######################################################
######################################################
######################################################
### Kibana 7.9.0 with SearchGuard
######################################################
######################################################
######################################################

1) 설치 (root 계정으로 설치 가능)
 . tar -zxvf kibana-7.9.0-linux-x86_64.tar.gz


##Kibaba (kibana plugin install 없이 http 기동하게 되면 messaage box for login)
# https://docs.search-guard.com/latest/search-guard-versions

Plugin installation was unsuccessful due to error "No kibana plugins found in archive"
[devuser@gsa02 kibana-7.9.0-linux-x86_64]$ ./bin/kibana-plugin install file:///home/ES/search-guard-kibana-plugin-7.9.0-45.0.0.zip 
Attempting to transfer from file:///home/ES/search-guard-kibana-plugin-7.9.0-45.0.0.zip
Transferring 38485230 bytes....................
Transfer complete
Retrieving metadata from plugin archive
Extracting plugin archive
Extraction complete
Plugin installation complete
[devuser@gsa02 kibana-7.9.0-linux-x86_64]$ 


# is proxied through the Kibana server.
elasticsearch.username: "elastic"
elasticsearch.password: "gsaadmin"


elasticsearch.ssl.verificationMode: none
xpack.security.enabled: false

xpack.reporting.capture.browser.chromium.disableSandbox: false


#searchguard.basicauth.login.showbrandimage: true
#searchguard.basicauth.login.brandimage: "http://10.132.16.31:7091/pic/img_ci_eng.png"
#searchguard.basicauth.login.title: "POSCO ICT Search-I3Bot"
#searchguard.basicauth.login.subtitle: "Authorization"


#/home/ES/kibana-7.9.0-linux-x86_64/plugins/searchguard/public/apps/login
#login.html


3) kibana 실행
- root 계정이면 ./bin/kibana --allow-root

log   [06:38:30.949] [warning][plugins][reporting] Enabling the Chromium sandbox provides an additional layer of protection.
log   [06:38:53.172] [info][optimize] Optimization of bundles for status_page and timelion complete in 25.54 seconds
log   [06:38:53.178] [info][status][plugin:kibana@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.183] [info][status][plugin:elasticsearch@7.9.0] Status changed from uninitialized to yellow - Waiting for Elasticsearch
log   [06:38:53.183] [info][status][plugin:elasticsearch@7.9.0] Status changed from yellow to green - Ready
log   [06:38:53.185] [info][status][plugin:xpack_main@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.193] [info][status][plugin:monitoring@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.194] [info][status][plugin:spaces@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.196] [info][status][plugin:beats_management@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.227] [info][status][plugin:apm_oss@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.231] [info][status][plugin:console_legacy@7.9.0] Status changed from uninitialized to green - Ready
log   [06:38:53.241] [info][listening] Server running at http://10.132.17.62:5601
log   [06:38:53.647] [info][server][Kibana][http] http server running at http://10.132.17.62:5601

```
