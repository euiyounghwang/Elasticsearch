
# NORI
**NORI Index Setting**  

PUT nori_ict_korean
 {
   "settings": {
     "index": {
       "number_of_shards": "5",
       "number_of_replicas": "1",
       "analysis": {
         "analyzer": {
           "korean_analyzer_custom": {
             "filter": [
               "pos_filter",
               "nori_readingform",
               "lowercase"
             ],
             "tokenizer": "nori_user_dict"
           },
           "korean_analyzer_raw": {
             "filter": [
               "lowercase"
             ],
             "tokenizer": "nori_user_dict"
           },
           "korean_analyzer_default": {
             "filter": [
               "pos_filter",
               "lowercase"
             ],
             "tokenizer": "nori_tokenizer"
           }
         },
         "tokenizer": {
           "nori_user_dict": {
             "mode": "MIXED",
             "type": "nori_tokenizer",
             "user_dictionary": "userdic_ko.txt"
           }
         },
         "filter": {
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
         }
       }
     }
   },
   "mappings": {
     "properties": {
       "message": {
         "type": "text",
         "fields": {
           "korean_custom": {
             "type": "text",
             "analyzer": "korean_analyzer_custom",
             "fielddata": true
           },
           "korean_default": {
             "type": "text",
             "analyzer": "korean_analyzer_default",
             "fielddata": true
           },
           "korean_raw": {
             "type": "text",
             "analyzer": "korean_analyzer_raw",
             "fielddata": true
           }
         },
         "fielddata": true
       }
     }
   }
 }

**NORI Index Sample**  
 POST tt/_bulk
 {"index":{"_id":1}}
 {"message":"The quick cat animal", "a" : "quick and or dog"}



 GET nori_ict_korean/_analyze
 {
   "text" : "幸福 사랑 대한민국은 임시정부 기념을을 중시한다",
   "analyzer" : "korean_analyzer_custom"
 }

 GET nori_ict_korean/_analyze
 {
   "text" : "幸福 사랑 대한민국은 임시정부 기념을을 중시한다",
   "analyzer" : "korean_analyzer_default",
   "explain": true
 }

 GET nori_ict_korean/_analyze
 {
   "text" : "幸福 사랑 대한민국은 임시정부 기념을을 중시한다",
   "analyzer" : "korean_analyzer_raw"
 }


