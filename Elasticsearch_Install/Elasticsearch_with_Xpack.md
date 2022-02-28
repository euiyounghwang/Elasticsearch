
# Elasticsearch with XPack

```sh
https://www.elastic.co/kr/blog/getting-started-with-elasticsearch-security

http://kimjmin.net/2019/04/2019-04-elastic-stack-7-release/


iptables -I INPUT 1 -p tcp --dport 9201 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 9310 -j ACCEPT



/ES/elasticsearch-7.6.1/bin/elasticsearch

bootstrap.system_call_filter: false

# main
cluster.initial_master_nodes:  ["ES_FREE_DATA_#11:9500"]
discovery.seed_hosts: ["10.132.17.69:9500"]
#-> 대체 discovery.zen.ping.unicast.hosts: ["10.132.11.85:9310","10.132.17.63:9310","10.132.17.69:9310"]


iptables -I INPUT 1 -p tcp --dport 9201 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 9310 -j ACCEPT


discovery.seed_hosts: ["10.132.11.85:9310","10.132.17.63:9310","10.132.17.69:9310"]


1) 

cluster.initial_master_nodes:  ["ES_MA_#1"]

discovery.seed_hosts: ["192.168.79.107","192.168.79.108"]


xpack.security.enabled: true
#xpack.security.transport.ssl.enabled: true
#xpack.security.transport.ssl.verification_mode: certificate
#xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
#xpack.security.transport.ssl.truststore.path: elastic-certificates.p12


cd /etc/security/limits.conf

devuser hard nofile 65536
devuser soft nofile 65536
devuser hard nproc 65536
devuser soft nproc 65536

esuser hard nofile 65536
esuser soft nofile 65536
esuser hard nproc 65536
esuser soft nproc 65536

# error message
esuser soft memlock unlimited
esuser hard memlock unlimited


2)
sudo sysctl -w vm.max_map_count=262144

3)
iptables -I INPUT 1 -p tcp --dport 9200 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 9300 -j ACCEPT

firewall-cmd --permanent --zone=public --add-port=9200/tcp
firewall-cmd --permanent --zone=public --add-port=9300/tcp

4)

bin/elasticsearch-certutil cert -out config/elastic-certificates.p12 -pass ""

5)
/ES/elasticsearch-7.9.0/bin/elasticsearch

kibna.yml
xpack.reporting.capture.browser.chromium.disableSandbox: false

./bin/kibana --allow-root

7) 

jvm options (circit CircuitBreakingException: [parent] Data too large IN ES 7.x)
10-:-XX:InitiatingHeapOccupancyPercent=75

or

elasticsearch.yml
indices.breaker.total.use_real_memory: false


scp -r root@10.132.17.69:/home/ES/elasticsearch-7.6.1/config/analysis ./
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH; /home/ES/elasticsearch-5.4.1/bin/elasticsearch





[2020-03-20T11:13:47,437][INFO ][o.e.t.TransportService   ] [ES_MA_DATA] publish_address {10.132.17.69:9301}, bound_addresses {10.132.17.69:9301}
[2020-03-20T11:13:47,750][INFO ][o.e.b.BootstrapChecks    ] [ES_MA_DATA] bound or publishing to a non-loopback address, enforcing bootstrap checks
ERROR: [1] bootstrap checks failed
[1]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured
ERROR: Elasticsearch did not exit normally - check the logs at /home/ES/elasticsearch-7.6.1/logs/ES_ZOO_7.6.log



Setting built-in user passwordsedit
You must set the passwords for all built-in users.

The elasticsearch-setup-passwords tool is the simplest method to set the built-in users' passwords for the first time. It uses the elastic user’s bootstrap password to run user management API requests. For example, you can run the command in an "interactive" mode, which prompts you to enter new passwords for the elastic, kibana, logstash_system, beats_system, apm_system, and remote_monitoring_user users:
====================================================
/home/ES/elasticsearch-7.6.1/bin/elasticsearch-setup-passwords interactive


elastic-certificate


Elastic Stack 6.8과 7.1부터, TLS 암호화된 통신, 역할 기반 액세스 제어(RBAC) 등과 같은 보안 기능이 기본 배포 내에서 무료로 제공됩니다. 이 블로그 포스팅에서는 Elasticsearch 클러스터 보안을 위해 이러한 기능의 사용을 시작하는 방법을 다루려고 합니다.

Elastic Stack 구현에 대한 보안의 실례로, 로컬 컴퓨터에서 2-노드 Elasticsearch 클러스터를 만들고 보안 작업을 진행해 보겠습니다. 이를 위해, 먼저 두 개의 노드 사이에 TLS 통신을 구성합니다. 그리고 나서 클러스터에서 데이터를 분석하고 시각화하는 데 사용되는 Kibana 인스턴스를 위해 보안을 활성화합니다. 그 후에, Kibana 내에서 역할 기반 액세스 제어를 구성하여 사용자가 보기 권한을 받은 데이터만 볼 수 있게 합니다.

보안이 작동하는 방법에 대해 훨씬 더 많은 내용이 있지만, 지금은 시작하는 데 필요한 내용만 다뤄보겠습니다. 이 블로그를 읽은 후에 Elastic Stack 보안 설명서를 확인해 보실 것을 권해 드립니다. 이 설명서에는 유용한 실례가 많이 담겨 있습니다. 잠시 알려드리자면, 이 작업을 로컬 클러스터에서 모두 진행하게 됩니다. 이러한 기능이 버전 6.8과 7.1에서 이제 기본으로 제공되긴 하지만 언제나 Elasticsearch Service와 함께 표준이 되어왔기 때문입니다.

Elasticsearch와 Kibana 설치
이 예제의 경우, 리눅스를 실행하는 노트북 컴퓨터에 설치하겠습니다. 이제 소개해드리는 단계를 사용자의 구체적인 환경에 맞춰 조정하시기 바랍니다.

1단계: Elasticsearch와 Kibana 다운로드
제일 먼저 할 일은 Elasticsearch와 Kibana 버전 6.8+ 또는 7.1+의 기본 배포를 다운로드하는 것입니다. 버전 7.1과 6.8에서 기본 배포에 보안이 추가되었습니다. 따라서 이보다 구 버전을 사용 중이시라면, 업그레이드하셔야 합니다.

2단계: Elasticsearch와 Kibana 추출
이 예제의 경우, elasticsearch-7.1.0-linux-x86_64.tar.gz와 kibana-7.1.0-linux-x86_64.tar.gz를 다운로드했습니다. 일단 다운로드가 되면, 내용물을 추출해야 합니다.

3단계: Elasticsearch 노드 2개 만들기
2-노드 클러스터를 만들려면, Elasticsearch 디렉터리 복사본 2개를 만들고 하나는 마스터라는 이름을, 또 하나는 노드라는 이름을 붙입니다. 이 단계를 마치면, 다음 파일과 폴더가 생깁니다.

elasticsearch-7.1.0                      elasticsearch-7.1.0-node
elasticsearch-7.1.0-linux-x86_64.tar.gz  kibana-7.1.0-linux-x86_64
elasticsearch-7.1.0-master               kibana-7.1.0-linux-x86_64.tar.gz
TLS 구성과 인증
제일 먼저 할 일은 노드가 안전하게 통신할 수 있게 해주는 몇 가지 인증서를 생성하는 것입니다. 엔터프라이즈 CA를 이용해 이 작업을 할 수 있지만 이번 데모의 경우, elasticsearch-certutil이라고 하는 명령이 있습니다. 보통 생기는 인증서 혼동 없이 이 작업을 위해 이 명령을 실행할 수 있습니다.

1단계: Elasticsearch 마스터의 TLS
마스터 디렉터리로 cd를 한 다음, 이 명령을 실행할 수 있습니다.

bin/elasticsearch-certutil cert -out config/elastic-certificates.p12 -pass ""

그 다음, 선호하는 텍스트 편집기에서 config/elasticsearch.yaml 파일을 열고, 파일 끝에 아래 줄을 붙여넣습니다.

xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12
파일을 저장하면 이제 마스터 노드를 시작할 준비가 된 것입니다. bin/elasticsearch 명령을 실행합니다. 이 실행 파일은 계속 실행되고 있어야 합니다. 지금은 이 터미널을 따로 떼어놓겠습니다.

2단계: Elasticsearch 클러스터 비밀번호
일단 마스터 노드가 실행되면, 클러스터의 비밀번호를 설정할 때입니다. 새 터미널에서 마스터 노드 디렉터리에 cd를 해야 합니다. 그리고 나서 bin/elasticsearch-setup-passwords auto 명령을 실행합니다. 그러면 다양한 내부 스택 사용자들을 위한 무작위 비밀번호가 생성됩니다. 또는 자동 매개변수를 건너뛰고 대화형 매개변수를 사용해 수동으로 비밀번호를 정의할 수도 있습니다. 이 비밀번호를 기억해 두세요. 곧 다시 필요하게 됩니다.

3단계: Elasticsearch 노드의 TLS
이제 또 다른 새 터미널을 열어 노드 디렉터리로 cd를 합니다. 이 예제에서는, 여기에 elasticsearch-7.1.0-node라는 이름을 붙였습니다.

가장 쉽게 할 수 있는 방법은 마스터의 구성 디렉터리에서 노드의 구성 디렉터리로 모든 것을 복사하는 것입니다.

cp ../elasticsearch-7.1.0-master/config/* config/
또한 node.master: false 구성 옵션을 config/elasticsearch.yml 파일에 추가해야 합니다. 여기서는 자세한 내용까지 들어가지는 않겠습니다. 클러스터 설명서에서 추가적인 세부사항에 대해 찾아보실 수 있습니다. 구성 파일을 일괄적으로 복사하는 대신 그냥 인증서 파일을 복사한 다음, 마스터 노드에 있는 것과 동일하게 xpack.security.* 키를 설정해도 됩니다.

그리고 나서 bin/elasticsearch를 실행하여 노드를 시작하면, 노드가 클러스터에 연결되는 것을 보게 됩니다. 마스터 노드의 터미널 창을 보는 경우, 여기서 노드가 클러스터에 연결되었다는 메시지를 볼 수 있습니다. 이제 우리는 2-노드 클러스터를 실행하고 있습니다.

4단계: Kibana의 보안
마지막으로 해야 할 일은 Kibana 구성입니다. 다시 한 번 또 다른 터미널 창을 엽니다. (이번이 정말 마지막입니다.) Kibana 사용자를 위해 비밀번호를 추가해야 합니다. 이전에 setup-passwords 명령에서 출력된 것에서 비밀번호를 가져올 수 있습니다.

Kibana 디렉터리로 cd를 하고 원하는 텍스트 편집기에서 config/kibana.yml 파일을 엽니다. 다음과 같이 보이는 줄을 찾습니다.

#elasticsearch.username: "user"
#elasticsearch.password: "pass"
줄 처음에 있는 #문자를 제거하여 username과 password 필드의 주석 처리를 제거합니다. "user"를 "kibana"로 바꾼 다음 "pass"를 setup-passwords 명령이 Kibana 비밀번호라고 알려주는 것으로 바꿉니다. 파일을 저장한 다음 bin/kibana를 실행하여 Kibana를 시작할 수 있습니다.

Kibana 내에서 역할 기반 액세스 제어(RBAC)를 구성합니다.
일단 Kibana가 실행되고 있으면, 웹 브라우저로 전환하여 http://localhost:5601을 열 수 있습니다. 그러면 로그인하라는 요청을 받게 되는데, 우리는 elastic 슈퍼 사용자와 setup-passwords가 알려주는 비밀번호를 사용하겠습니다.
```

