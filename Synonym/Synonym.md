
# synonyms.txt
```sh
airpods,에어팟,airpod,airpot 
2080,이공팔공
```

# synonyms.txt path
/usr/share/elasticsearch/config/analysis


# Synonyms Test Index
```sh
PUT synonyms_test
{
  "settings": {
    "index": {
      "analysis": {
        "analyzer": {
          "synonym": {
            "tokenizer": "nori_tokenizer",
            "filter": [
              "synonym"
            ]
          }
        },
        "filter": {
          "synonym": {
            "type": "synonym",
            "synonyms_path": "analysis/synonyms.txt"
          }
        }
      }
    }
  },
  "mappings": {
    "_doc": {
      "dynamic": "false",
      "properties": {
        "keyword": {
          "type": "text",
          "analyzer": "synonym",
          "search_analyzer": "synonym",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        }
      }
    }
  }
}
```


# Synonyms Test Index
```sh
POST synonyms_test/_bulk
{"index":{"_id":1}}
{"keyword":"2080"}
{"index":{"_id":2}}
{"keyword":"이공팔공"}
```

# Synonyms Test Index : Get Search
```sh
GET synonyms_test/_search
{
  "query": {
    "match": {
      "keyword": "이공팔공"
    }
  }
}
```
# Synonyms Test Index : Get Search Result
```sh
{
  "took" : 1,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 1,
      "relation" : "eq"
    },
    "max_score" : 0.6931471,
    "hits" : [
      {
        "_index" : "synonyms_test",
        "_type" : "_doc",
        "_id" : "2",
        "_score" : 0.6931471,
        "_source" : {
          "keyword" : "이공팔공"
        }
      }
    ]
  }
}
```

# Synonyms Test Index : Updatable
```sh
PUT /test_index
{
  "settings": {
    "index": {
      "analysis": {
        "analyzer": {
          "synonym_test": {
            "tokenizer": "whitespace",
            "filter": [
              "synonym_test"
            ]
          }
        },
        "filter": {
          "synonym_test": {
            "type": "synonym",
            "synonyms_path": "analysis/synonym.txt",
            "updateable": true
          }
        }
      }
    }
  },
  "mappings": 
  { 
    "_doc": 
    { 
       "dynamic": "false", 
       "properties": 
        { 
          "keyword": 
          { 
            "type": "text", 
            "analyzer": "synonym", 
            "search_analyzer": "synonym", 
            "fields": 
            { 
              "keyword": 
                { 
                  "type": "keyword" 
                } 
            } 
          } 
       } 
    } 
  }
}
```


# Sample2 template index
```sh
PUT test2
{
  "settings": {
    "analysis": {
      "tokenizer": {
        "nori_user_dict": {
          "type": "nori_tokenizer",
          "decompound_mode": "mixed",
          "user_dictionary": "user_dic.txt"
        }
      },
      "analyzer": {
        "korean_analyzer": {
          "filter": [
            "pos_filter_speech", "nori_readingform",
            "lowercase", "synonym", "remove_duplicates"
          ],
          "tokenizer": "nori_user_dict"
        }
      },
      "filter": {
        "synonym" : {
          "type" : "synonym_graph",
          "synonyms_path" : "synonyms.txt"
        },
        "pos_filter_speech": {
          "type": "nori_part_of_speech",
          "stoptags": [
            "E", "J", "SC", "SE", "SF", "SP", "SSC", "SSO", "SY", "VCN", "VCP",
            "VSV", "VX", "XPN", "XSA", "XSN", "XSV"
          ]
        }
      }
    }
  }
}

```

> 색인 시점과 검색 시점의 동의어 사전
> 색인 시점에 동의어 사전 필터를 적용하는 것은 아래와 같은 단점이 있습니다.

> 인덱스가 더 커질 수 있습니다. 모든 동의어가 색인되어야 하기 때문입니다.
> 단어의 통계 정보에 의존하는 검색 점수가 동의어도 개수 계산에 포함되기 때문에 좀 더 일반적으로 사용되지 않는 단어들에 대한 통계가 왜곡됩니다.
> 동의어 규칙이 변경되더라도 기존의 색인이 변경되지 않습니다. 즉, 기존의 색인을 모두 삭제하고 색인을 다시 생성해야만 변경된 사전의 내용이 적용됩니다.
> 특히, 마지막 두 가지가 큰 단점입니다. 색인 시 동의어 사전의 사용이 가진 장점은 성능입니다. 확장 프로세스에 대한 대가를 미리 다 지불하며, 쿼리마다 매번 수행해야 할 필요가 없기 때문에 일치되어야 하는 많은 용어들이 잠재적으로 결과에 포함될 수 있습니다.

 
> 검색 시점
> 검색 시점에 동의어 사전 필터를 적용하는 것은 색인 시점에서 사용할 때의 문제들 중 많은 부분이 발생하지 않습니다.
> - 인덱스의 크기에 영향을 미치지 않습니다.
> - 단어의 통계 정보가 동일하게 유지됩니다.
> - 동의어 규칙이 수정되더라도 문서를 재색인 할 필요가 없습니다.
> 일반적으로 검색 시점의 동의어 사용에 대한 장점은 
> 색인 시점의 동의어를 사용할 때 얻을 수 있는 약간의 성능 상의 
> 이점보다 큽니다.

 
# ElasticSearch 7.3 버전부터는 위의 index close/open 의 번거로움을 없애기 위해 
**_reload_search_analyzers API를 추가**  
```sh
POST /test_index/_reload_search_analyzers
```

```sh
GET /test_index/_analyze
{
  "analyzer": "synonym_test", 
  "text": "Elasticsearch Harry Potter Apple"
}
```

