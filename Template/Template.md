
# Template

```sh
 PUT /_template/legacy_template/
 {
   "index_patterns": [
     "*_ppms_*",
     "*_dm_*",
     "posco_gsop_*",
     "*_sigmaro_*",
     "posco_el_*"
   ],
   "settings": {
     "index": {
       "number_of_shards": 10,
       "number_of_replicas": 1,
       "max_ngram_diff": 20,
       "mapping": {
         "ignore_malformed": "true",
         "total_fields.limit": "3000"
       },
       "analysis": {
         "filter": {
           "stop": {
             "ignore_case": "true",
             "type": "stop",
             "stopwords_path": "analysis/stopwords.txt"
           },
           "synonym": {
             "ignore_case": "true",
             "type": "synonym",
             "synonyms_path": "analysis/glossary_arirang.txt"
           },
           "synonym_type_filter": {
             "type": "keep_types",
             "types": [
               "SYNONYM"
             ]
           },
           "length_filter": {
             "type": "length",
             "min": 2
           },
           "truncate_filter": {
             "type": "truncate",
             "length": 150
           },
           "whitespace_remove": {
             "type": "pattern_replace",
             "pattern": " ",
             "replacement": ""
           },
           "pos_filter": {
             "type": "nori_part_of_speech",
             "stoptags": [
               "E",
               "IC",
               "J",
               "MAG",
               "MM",
               "SP",
               "SSC",
               "SSO",
               "SC",
               "SE",
               "XPN",
               "XSA",
               "XSN",
               "XSV",
               "UNA",
               "NA",
               "VSV"
             ]
           }
         },
         "analyzer": {
           "korean_synonym": {
             "filter": [
               "lowercase",
               "synonym",
               "stop",
               "synonym_type_filter"
             ],
             "type": "custom",
             "tokenizer": "nori_tokenizer"
           },
           "split_analyzer": {
             "filter": [
               "lowercase"
             ],
             "type": "custom",
             "tokenizer": "my_tokenizer"
           },
           "korean_analyzer_custom": {
             "filter": [
               "pos_filter",
               "nori_readingform",
               "lowercase",
               "stop"
             ],
             "tokenizer": "nori_user_dict"
           },
           "korean_analyzer_default": {
             "filter": [
               "pos_filter",
               "lowercase",
               "stop"
             ],
             "tokenizer": "nori_tokenizer"
           },
           "upper_index_analyzer": {
             "filter": [
               "uppercase"
             ],
             "type": "custom",
             "tokenizer": "standard"
           },
           "nGram_analyzer": {
             "filter": [
               "lowercase"
             ],
             "tokenizer": "ngram_tokenizer"
           },
           "search_keyword_analyzer": {
             "filter": [
               "lowercase"
             ],
             "type": "custom",
             "tokenizer": "standard"
           },
           "whitespace_analyzer": {
             "filter": [
               "lowercase",
               "asciifolding"
             ],
             "type": "custom",
             "tokenizer": "whitespace"
           },
           "whitespace_keyword_analyzer": {
             "filter": [
               "lowercase",
               "whitespace_remove"
             ],
             "type": "custom",
             "tokenizer": "sentence_tokenizer"
           },
           "my_truncate_analyzer": {
             "filter": [
               "truncate_filter"
             ],
             "type": "custom",
             "tokenizer": "keyword"
           }
         },
         "tokenizer": {
           "sentence_tokenizer": {
             "type": "pattern",
             "pattern": """\."""
           },
           "my_tokenizer": {
             "type": "pattern",
             "pattern": """\."""
           },
           "nori_user_dict": {
             "decompound_mode": "mixed",
             "type": "nori_tokenizer",
             "user_dictionary": "userdic_ko.txt"
           },
           "ngram_tokenizer": {
             "token_chars": [
               "letter",
               "digit",
               "punctuation"
             ],
             "min_gram": "1",
             "type": "nGram",
             "max_gram": "20"
           }
         }
       }
     }
   },
   "mappings": {
     "dynamic_templates": [
       {
         "date_template": {
           "match": "*_DT",
           "mapping": {
             "type": "date",
             "format": "yyyy-MM-dd HH:mm:ss"
           }
         }
       },
       {
         "date_template": {
           "match": "*_DATE",
           "mapping": {
             "type": "date",
             "format": "yyyy-MM-dd HH:mm:ss"
           }
         }
       },
       {
         "date_template": {
           "match": "*_TIMESTAMP",
           "mapping": {
             "type": "date",
             "format": "yyyy-MM-dd HH:mm:ss"
           }
         }
       },
       {
         "date_template": {
           "match": "*_CNT",
           "mapping": {
             "type": "long"
           }
         }
       },
       {
         "date_template": {
           "match": "*DATE",
           "mapping": {
             "type": "date",
             "format": "yyyy-MM-dd HH:mm:ss"
           }
         }
       },
       {
         "text_template": {
           "match": "TITLE",
           "mapping": {
             "type": "text",
             "fields": {
               "keyword": {
                 "type": "keyword"
               },
               "nGram": {
                 "type": "text",
                 "analyzer": "nGram_analyzer"
               }
             },
             "analyzer": "korean_analyzer_custom"
           }
         }
       },
       {
         "text_template": {
           "match": "CONTENT",
           "mapping": {
             "type": "text",
             "term_vector": "with_positions_offsets",
             "fields": {
               "truncated": {
                 "type": "text",
                 "analyzer": "my_truncate_analyzer",
                 "fielddata": true
               }
             },
             "analyzer": "korean_analyzer_custom"
           }
         }
       }
     ],
     "properties": {
       "@timestamp": {
         "type": "date",
         "format": "yyyy-MM-dd HH:mm:ss"
       },
       "DELETE_FLAG": {
         "type": "date"
       },
       "DEPT_NAME": {
         "type": "text",
         "analyzer": "nGram_analyzer"
       },
       "THUMBNAILS": {
         "type": "binary"
       },
       "USER_NAME": {
         "type": "text",
         "analyzer": "nGram_analyzer"
       }
     }
   }
 }
 ```
