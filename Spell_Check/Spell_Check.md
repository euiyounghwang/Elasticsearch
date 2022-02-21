
```sh
######################################################
######################################################
######################################################
### Spell Check
######################################################
######################################################
######################################################

DELETE spell_check

PUT spell_check
{
  "settings": {
    "index": {
      "analysis": {
        "filter": {
          "my_filter": {
            "mode": "decompose",
            "name": "nfc",
            "type": "icu_normalizer"
          }
        },
        "analyzer": {
          "nfd_analyzer": {
            "filter": [
              "lowercase"
            ],
            "char_filter": [
              "nfd_normalizer"
            ],
            "tokenizer": "standard"
          }
        },
        "char_filter": {
          "nfd_normalizer": {
            "mode": "decompose",
            "name": "nfc",
            "type": "icu_normalizer"
          }
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "TITLE": {
        "type": "text",
        "fields": {
          "raw": {
            "type": "keyword"
          },
          "spell": {
            "type": "text",
            "analyzer": "nfd_analyzer"
          }
        }
      }
    }
  }
}
```

```sh
PUT _bulk
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "신세계"}
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "신생"}
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "신세계,신솔"}
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "cloud"}
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "cloudera"}
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "포스코"}
{"index":{"_index":"spell_check","_type":"_doc"}}
{"TITLE" : "포스코건설"}
```

```sh
GET spell_check/_search
{
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```

```sh
GET /spell_check/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "default_field": "TITLE.*",
            "query": "신세*"
          }
        }
      ]
    }
  }
}
```

```sh
GET spell_check/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "default_field": "TITLE.*",
            "query": "신세계"
          }
        }
      ]
    }
  }
}
```

```sh
GET spell_check/_search
{
  "suggest": {
    "my-suggestion": {
      "text": "신세",
      "term": {
        "field": "TITLE.spell",
        "string_distance": "jaro_winkler"
      }
    }
  }
}
```
