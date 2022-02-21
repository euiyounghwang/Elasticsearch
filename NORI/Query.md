
# NORI
**NORI Index Setting**  

```sh
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
```

**NORI Analyzer Test **  

```sh
 GET nori_ict_korean/_analyze
 {
   "text" : "幸福 사랑 대한민국은 임시정부 기념을을 중시한다",
   "analyzer" : "korean_analyzer_custom"
 }

{
  "tokens" : [
    {
      "token" : "행복",
      "start_offset" : 0,
      "end_offset" : 2,
      "type" : "word",
      "position" : 0
    },
    {
      "token" : "사랑",
      "start_offset" : 3,
      "end_offset" : 5,
      "type" : "word",
      "position" : 1
    },
    {
      "token" : "대한",
      "start_offset" : 6,
      "end_offset" : 8,
      "type" : "word",
      "position" : 2
    },
    {
      "token" : "민국",
      "start_offset" : 8,
      "end_offset" : 10,
      "type" : "word",
      "position" : 3
    },
    {
      "token" : "임시",
      "start_offset" : 12,
      "end_offset" : 14,
      "type" : "word",
      "position" : 5
    },
    {
      "token" : "정부",
      "start_offset" : 14,
      "end_offset" : 16,
      "type" : "word",
      "position" : 6
    },
    {
      "token" : "기념",
      "start_offset" : 17,
      "end_offset" : 19,
      "type" : "word",
      "position" : 7
    },
    {
      "token" : "중시",
      "start_offset" : 22,
      "end_offset" : 24,
      "type" : "word",
      "position" : 10
    }
  ]
}
```


```sh
 GET nori_ict_korean/_analyze
 {
   "text" : "幸福 사랑 대한민국은 임시정부 기념을을 중시한다",
   "analyzer" : "korean_analyzer_default",
   "explain": true
 }
 
 {
  "detail" : {
    "custom_analyzer" : true,
    "charfilters" : [ ],
    "tokenizer" : {
      "name" : "nori_tokenizer",
      "tokens" : [
        {
          "token" : "幸福",
          "start_offset" : 0,
          "end_offset" : 2,
          "type" : "word",
          "position" : 0,
          "bytes" : "[e5 b9 b8 e7 a6 8f]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : "행복",
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "사랑",
          "start_offset" : 3,
          "end_offset" : 5,
          "type" : "word",
          "position" : 1,
          "bytes" : "[ec 82 ac eb 9e 91]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "대한",
          "start_offset" : 6,
          "end_offset" : 8,
          "type" : "word",
          "position" : 2,
          "bytes" : "[eb 8c 80 ed 95 9c]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "민국",
          "start_offset" : 8,
          "end_offset" : 10,
          "type" : "word",
          "position" : 3,
          "bytes" : "[eb af bc ea b5 ad]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "은",
          "start_offset" : 10,
          "end_offset" : 11,
          "type" : "word",
          "position" : 4,
          "bytes" : "[ec 9d 80]",
          "leftPOS" : "J(Ending Particle)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "J(Ending Particle)",
          "termFrequency" : 1
        },
        {
          "token" : "임시",
          "start_offset" : 12,
          "end_offset" : 14,
          "type" : "word",
          "position" : 5,
          "bytes" : "[ec 9e 84 ec 8b 9c]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "정부",
          "start_offset" : 14,
          "end_offset" : 16,
          "type" : "word",
          "position" : 6,
          "bytes" : "[ec a0 95 eb b6 80]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "기념",
          "start_offset" : 17,
          "end_offset" : 19,
          "type" : "word",
          "position" : 7,
          "bytes" : "[ea b8 b0 eb 85 90]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "을",
          "start_offset" : 19,
          "end_offset" : 20,
          "type" : "word",
          "position" : 8,
          "bytes" : "[ec 9d 84]",
          "leftPOS" : "J(Ending Particle)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "J(Ending Particle)",
          "termFrequency" : 1
        },
        {
          "token" : "을",
          "start_offset" : 20,
          "end_offset" : 21,
          "type" : "word",
          "position" : 9,
          "bytes" : "[ec 9d 84]",
          "leftPOS" : "J(Ending Particle)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "J(Ending Particle)",
          "termFrequency" : 1
        },
        {
          "token" : "중시",
          "start_offset" : 22,
          "end_offset" : 24,
          "type" : "word",
          "position" : 10,
          "bytes" : "[ec a4 91 ec 8b 9c]",
          "leftPOS" : "NNG(General Noun)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "NNG(General Noun)",
          "termFrequency" : 1
        },
        {
          "token" : "하",
          "start_offset" : 24,
          "end_offset" : 26,
          "type" : "word",
          "position" : 11,
          "bytes" : "[ed 95 98]",
          "leftPOS" : "XSV(Verb Suffix)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "XSV(Verb Suffix)",
          "termFrequency" : 1
        },
        {
          "token" : "ᆫ다",
          "start_offset" : 24,
          "end_offset" : 26,
          "type" : "word",
          "position" : 12,
          "bytes" : "[e1 86 ab eb 8b a4]",
          "leftPOS" : "E(Verbal endings)",
          "morphemes" : null,
          "posType" : "MORPHEME",
          "positionLength" : 1,
          "reading" : null,
          "rightPOS" : "E(Verbal endings)",
          "termFrequency" : 1
        }
      ]
    },
    "tokenfilters" : [
      {
        "name" : "pos_filter",
        "tokens" : [
          {
            "token" : "幸福",
            "start_offset" : 0,
            "end_offset" : 2,
            "type" : "word",
            "position" : 0,
            "bytes" : "[e5 b9 b8 e7 a6 8f]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : "행복",
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "사랑",
            "start_offset" : 3,
            "end_offset" : 5,
            "type" : "word",
            "position" : 1,
            "bytes" : "[ec 82 ac eb 9e 91]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "대한",
            "start_offset" : 6,
            "end_offset" : 8,
            "type" : "word",
            "position" : 2,
            "bytes" : "[eb 8c 80 ed 95 9c]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "민국",
            "start_offset" : 8,
            "end_offset" : 10,
            "type" : "word",
            "position" : 3,
            "bytes" : "[eb af bc ea b5 ad]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "임시",
            "start_offset" : 12,
            "end_offset" : 14,
            "type" : "word",
            "position" : 5,
            "bytes" : "[ec 9e 84 ec 8b 9c]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "정부",
            "start_offset" : 14,
            "end_offset" : 16,
            "type" : "word",
            "position" : 6,
            "bytes" : "[ec a0 95 eb b6 80]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "기념",
            "start_offset" : 17,
            "end_offset" : 19,
            "type" : "word",
            "position" : 7,
            "bytes" : "[ea b8 b0 eb 85 90]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "중시",
            "start_offset" : 22,
            "end_offset" : 24,
            "type" : "word",
            "position" : 10,
            "bytes" : "[ec a4 91 ec 8b 9c]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          }
        ]
      },
      {
        "name" : "lowercase",
        "tokens" : [
          {
            "token" : "幸福",
            "start_offset" : 0,
            "end_offset" : 2,
            "type" : "word",
            "position" : 0,
            "bytes" : "[e5 b9 b8 e7 a6 8f]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : "행복",
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "사랑",
            "start_offset" : 3,
            "end_offset" : 5,
            "type" : "word",
            "position" : 1,
            "bytes" : "[ec 82 ac eb 9e 91]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "대한",
            "start_offset" : 6,
            "end_offset" : 8,
            "type" : "word",
            "position" : 2,
            "bytes" : "[eb 8c 80 ed 95 9c]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "민국",
            "start_offset" : 8,
            "end_offset" : 10,
            "type" : "word",
            "position" : 3,
            "bytes" : "[eb af bc ea b5 ad]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "임시",
            "start_offset" : 12,
            "end_offset" : 14,
            "type" : "word",
            "position" : 5,
            "bytes" : "[ec 9e 84 ec 8b 9c]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "정부",
            "start_offset" : 14,
            "end_offset" : 16,
            "type" : "word",
            "position" : 6,
            "bytes" : "[ec a0 95 eb b6 80]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "기념",
            "start_offset" : 17,
            "end_offset" : 19,
            "type" : "word",
            "position" : 7,
            "bytes" : "[ea b8 b0 eb 85 90]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          },
          {
            "token" : "중시",
            "start_offset" : 22,
            "end_offset" : 24,
            "type" : "word",
            "position" : 10,
            "bytes" : "[ec a4 91 ec 8b 9c]",
            "leftPOS" : "NNG(General Noun)",
            "morphemes" : null,
            "posType" : "MORPHEME",
            "positionLength" : 1,
            "reading" : null,
            "rightPOS" : "NNG(General Noun)",
            "termFrequency" : 1
          }
        ]
      }
    ]
  }
}

```

```sh
 GET nori_ict_korean/_analyze
 {
   "text" : "幸福 사랑 대한민국은 임시정부 기념을을 중시한다",
   "analyzer" : "korean_analyzer_raw"
 }

{
  "tokens" : [
    {
      "token" : "幸福",
      "start_offset" : 0,
      "end_offset" : 2,
      "type" : "word",
      "position" : 0
    },
    {
      "token" : "사랑",
      "start_offset" : 3,
      "end_offset" : 5,
      "type" : "word",
      "position" : 1
    },
    {
      "token" : "대한",
      "start_offset" : 6,
      "end_offset" : 8,
      "type" : "word",
      "position" : 2
    },
    {
      "token" : "민국",
      "start_offset" : 8,
      "end_offset" : 10,
      "type" : "word",
      "position" : 3
    },
    {
      "token" : "은",
      "start_offset" : 10,
      "end_offset" : 11,
      "type" : "word",
      "position" : 4
    },
    {
      "token" : "임시",
      "start_offset" : 12,
      "end_offset" : 14,
      "type" : "word",
      "position" : 5
    },
    {
      "token" : "정부",
      "start_offset" : 14,
      "end_offset" : 16,
      "type" : "word",
      "position" : 6
    },
    {
      "token" : "기념",
      "start_offset" : 17,
      "end_offset" : 19,
      "type" : "word",
      "position" : 7
    },
    {
      "token" : "을",
      "start_offset" : 19,
      "end_offset" : 20,
      "type" : "word",
      "position" : 8
    },
    {
      "token" : "을",
      "start_offset" : 20,
      "end_offset" : 21,
      "type" : "word",
      "position" : 9
    },
    {
      "token" : "중시",
      "start_offset" : 22,
      "end_offset" : 24,
      "type" : "word",
      "position" : 10
    },
    {
      "token" : "하",
      "start_offset" : 24,
      "end_offset" : 26,
      "type" : "word",
      "position" : 11
    },
    {
      "token" : "ᆫ다",
      "start_offset" : 24,
      "end_offset" : 26,
      "type" : "word",
      "position" : 12
    }
  ]
}

```

