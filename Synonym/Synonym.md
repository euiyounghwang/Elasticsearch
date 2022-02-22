
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


