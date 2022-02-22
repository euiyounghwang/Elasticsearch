
# Metric Aggregations
 
**metric aggregations는 산술 연산 결과를 확인할 때 쓰인다.**  

![image](https://user-images.githubusercontent.com/84139720/155038643-a6aafc05-0781-4d19-9d0c-0c67fcada667.png)



**PUT INDEX**  
```sh
PUT order/
{
  "mappings": {
    "properties": {
      "lines": {
        "properties": {
          "amount": {
            "type": "float"
          },
          "product_id": {
            "type": "long"
          },
          "quantity": {
            "type": "long"
          }
        }
      },
      "purchased_at": {
        "type": "date"
      },
      "sales_channel": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "salesman": {
        "properties": {
          "id": {
            "type": "long"
          },
          "name": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword",
                "ignore_above": 256
              }
            }
          }
        }
      },
      "status": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "total_amount": {
        "type": "float"
      }
    }
  }
}
```

**Bulk JSON**  
```sh
{"index":{"_id":1}}
{"purchased_at":"2016-07-10T16:52:43Z","lines":[{"product_id":6,"amount":71.32,"quantity":1},{"product_id":3,"amount":58.96,"quantity":3},{"product_id":1,"amount":29.8,"quantity":3}],"total_amount":160.08,"salesman":{"id":11,"name":"Matthus Mitkcov"},"sales_channel":"store","status":"processed"}
{"index":{"_id":2}}
{"purchased_at":"2016-03-08T16:18:37Z","lines":[{"product_id":7,"amount":31.44,"quantity":2},{"product_id":4,"amount":74.82,"quantity":2}],"total_amount":106.26,"salesman":{"id":79,"name":"Ulberto Woodruff"},"sales_channel":"store","status":"completed"}
{"index":{"_id":3}}
{"purchased_at":"2016-01-04T02:46:54Z","lines":[{"product_id":9,"amount":38.89,"quantity":1}],"total_amount":38.89,"salesman":{"id":68,"name":"Thea Chidgey"},"sales_channel":"store","status":"completed"}
{"index":{"_id":4}}
{"purchased_at":"2016-04-14T11:44:29Z","lines":[{"product_id":4,"amount":26.18,"quantity":2},{"product_id":8,"amount":76.45,"quantity":1},{"product_id":1,"amount":65.59,"quantity":3}],"total_amount":168.22,"salesman":{"id":81,"name":"Melany Cerith"},"sales_channel":"store","status":"cancelled"}
{"index":{"_id":5}}
{"purchased_at":"2016-02-18T17:11:21Z","lines":[{"product_id":2,"amount":56.06,"quantity":3},{"product_id":5,"amount":79.75,"quantity":3}],"total_amount":135.81,"salesman":{"id":23,"name":"Flynn Dome"},"sales_channel":"web","status":"completed"}
{"index":{"_id":6}}
{"purchased_at":"2016-03-26T07:28:22Z","lines":[{"product_id":7,"amount":86.88,"quantity":1},{"product_id":5,"amount":27.34,"quantity":3},{"product_id":5,"amount":88.52,"quantity":2}],"total_amount":202.74,"salesman":{"id":16,"name":"Mirilla Penkman"},"sales_channel":"web","status":"completed"}
{"index":{"_id":7}}
{"purchased_at":"2016-05-06T18:37:33Z","lines":[{"product_id":3,"amount":25.27,"quantity":2}],"total_amount":25.27,"salesman":{"id":5,"name":"Modestia McCreadie"},"sales_channel":"app","status":"confirmed"}
{"index":{"_id":8}}
{"purchased_at":"2016-11-26T11:24:36Z","lines":[{"product_id":4,"amount":51.26,"quantity":1},{"product_id":8,"amount":72.41,"quantity":1}],"total_amount":123.67,"salesman":{"id":55,"name":"Grange Smiths"},"sales_channel":"phone","status":"cancelled"}
{"index":{"_id":9}}
{"purchased_at":"2016-12-26T08:29:47Z","lines":[{"product_id":2,"amount":98.87,"quantity":3}],"total_amount":98.87,"salesman":{"id":5,"name":"Carlyn Stegers"},"sales_channel":"web","status":"cancelled"}
{"index":{"_id":10}}
{"purchased_at":"2016-12-21T12:47:43Z","lines":[{"product_id":7,"amount":21.97,"quantity":3},{"product_id":10,"amount":19.26,"quantity":3}],"total_amount":41.23,"salesman":{"id":83,"name":"Kennie Gilks"},"sales_channel":"app","status":"cancelled"}
{"index":{"_id":11}}
{"purchased_at":"2016-04-02T04:42:31Z","lines":[{"product_id":6,"amount":86.89,"quantity":1},{"product_id":4,"amount":18.04,"quantity":3},{"product_id":10,"amount":18.61,"quantity":3}],"total_amount":123.54,"salesman":{"id":39,"name":"Ashely Rawnsley"},"sales_channel":"phone","status":"cancelled"}
{"index":{"_id":12}}
{"purchased_at":"2016-09-08T16:24:12Z","lines":[{"product_id":1,"amount":11.75,"quantity":1},{"product_id":5,"amount":77.33,"quantity":2},{"product_id":2,"amount":86.76,"quantity":1}],"total_amount":175.84,"salesman":{"id":40,"name":"Raynor Dennis"},"sales_channel":"web","status":"pending"}
{"index":{"_id":13}}
{"purchased_at":"2016-01-12T06:20:27Z","lines":[{"product_id":6,"amount":93.69,"quantity":2}],"total_amount":93.69,"salesman":{"id":62,"name":"Byran Gallihaulk"},"sales_channel":"app","status":"processed"}
{"index":{"_id":14}}
{"purchased_at":"2016-01-31T13:06:58Z","lines":[{"product_id":10,"amount":80.33,"quantity":2}],"total_amount":80.33,"salesman":{"id":43,"name":"Eveleen Ickovici"},"sales_channel":"store","status":"processed"}
{"index":{"_id":15}}
{"purchased_at":"2016-02-20T23:02:31Z","lines":[{"product_id":5,"amount":20.51,"quantity":1},{"product_id":10,"amount":93.35,"quantity":1}],"total_amount":113.86,"salesman":{"id":78,"name":"Erda Boyet"},"sales_channel":"store","status":"confirmed"}
{"index":{"_id":16}}
{"purchased_at":"2016-08-17T09:52:50Z","lines":[{"product_id":9,"amount":61.95,"quantity":1}],"total_amount":61.95,"salesman":{"id":91,"name":"Gherardo MattiCCI"},"sales_channel":"web","status":"confirmed"}
{"index":{"_id":17}}
{"purchased_at":"2016-06-05T18:59:23Z","lines":[{"product_id":8,"amount":32.46,"quantity":3},{"product_id":6,"amount":13.7,"quantity":2},{"product_id":8,"amount":28.74,"quantity":2}],"total_amount":74.9,"salesman":{"id":82,"name":"Shanon Eilhertsen"},"sales_channel":"phone","status":"confirmed"}
{"index":{"_id":18}}
{"purchased_at":"2016-07-26T12:10:15Z","lines":[{"product_id":3,"amount":23.16,"quantity":1},{"product_id":4,"amount":18.94,"quantity":1},{"product_id":10,"amount":38.65,"quantity":2}],"total_amount":80.75,"salesman":{"id":58,"name":"Thekla De Beauchemp"},"sales_channel":"phone","status":"processed"}
{"index":{"_id":19}}
{"purchased_at":"2016-05-08T19:54:44Z","lines":[{"product_id":9,"amount":29.8,"quantity":2},{"product_id":6,"amount":97.61,"quantity":3}],"total_amount":127.41,"salesman":{"id":96,"name":"Susannah Grigoryev"},"sales_channel":"phone","status":"cancelled"}
{"index":{"_id":20}}
{"purchased_at":"2016-06-19T21:34:51Z","lines":[{"product_id":2,"amount":23.3,"quantity":2},{"product_id":5,"amount":30.44,"quantity":2},{"product_id":6,"amount":22.15,"quantity":1}],"total_amount":75.89,"salesman":{"id":66,"name":"Janeta Crutchfield"},"sales_channel":"phone","status":"completed"}
```

**GET Search Aggregation**  
```sh
GET /order/_search
{
  "size":0,
  "aggs": {
    "total_sales": {
      "sum": {
        "field": "total_amount"
      }
    },
    "avg_sale":{
      "avg": {
        "field": "total_amount"
      }
    },
     "min_sale":{
      "min": {
        "field": "total_amount"
      }
    },
    "max_sale":{
      "max": {
        "field": "total_amount"
      }
    }     
  }
}
```

**GET Search Result Aggregation**  
```sh
{
  "took" : 9,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "max_sale" : {
      "value" : 202.74000549316406
    },
    "avg_sale" : {
      "value" : 105.46000080108642
    },
    "min_sale" : {
      "value" : 25.270000457763672
    },
    "total_sales" : {
      "value" : 2109.2000160217285
    }
  }
}

```


# Range Aggregation  
**range aggregation**  
```sh
GET order/_search
{
  "size": 0,
  "aggs": {
    "amout_range": {
      "range": {
        "field": "total_amount",
        "ranges": [
          {
            "from": 75.88,
            "to": 75.89
          },
          {
            "from": 0,
            "to": 200
          },
          {
            "from": 200,
            "to": 400
          },
          {
            "from": 400,
            "to": 600
          },
          {
            "from": 600,
            "to": 800
          }
        ]
      }
    }
  }
}

```


**GET Search Result Aggregation**  
```sh
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "amout_range" : {
      "buckets" : [
        {
          "key" : "0.0-200.0",
          "from" : 0.0,
          "to" : 200.0,
          "doc_count" : 19
        },
        {
          "key" : "75.88-75.89",
          "from" : 75.88,
          "to" : 75.89,
          "doc_count" : 1
        },
        {
          "key" : "200.0-400.0",
          "from" : 200.0,
          "to" : 400.0,
          "doc_count" : 1
        },
        {
          "key" : "400.0-600.0",
          "from" : 400.0,
          "to" : 600.0,
          "doc_count" : 0
        },
        {
          "key" : "600.0-800.0",
          "from" : 600.0,
          "to" : 800.0,
          "doc_count" : 0
        }
      ]
    }
  }
}

```


# date aggregation
**2016-07-10T16:52:43Z**  
**그리니치 천문대 표준시의 기준 : GMT(Greenwich Mean Time) 는 UTC와 같다.**  
**UTC TimeZone **  
**https://currentmillis.com/**  

```sh
GET order/_search
{
  "size": 1,
  "aggs": {
    "request_count_date": {
      "date_range": {
        "field": "purchased_at",
        "ranges": [
          {
            "from": "2016-07-10 16:52:00",
            "to": "2016-07-10 16:52:00"
          },
          {
            "from": "2016-07-10 00:51:00",
            "to": "2016-07-11 01:53:00"
          }
        ],
        "format": "yyyy-MM-dd HH:mm:s"
      }
    }
  }
}
```



# Bucket Aggregations
 
**Bucket Aggregations 기능을 이용하면 Elasticsearch 는 documents 를 위한 그룹인 Bucket 을 만든다.**  
 
그림에서 보면 두개의 Bucket 이 보이며 SQL 로 치면 group by 와 같은 기능을 한다.

![image](https://user-images.githubusercontent.com/84139720/155038886-e4a75020-b82d-4116-92dd-a216baab9298.png)


**GET Search Aggregation**  
```sh
GET /order/_search
{
  "size":0,
  "aggs": {
    "status_terms":{
      "terms": {
        "field": "status.keyword"
      }
    }
  }
}
```

**GET Search Result Aggregation**  
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
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "status_terms" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "cancelled",
          "doc_count" : 6
        },
        {
          "key" : "completed",
          "doc_count" : 5
        },
        {
          "key" : "confirmed",
          "doc_count" : 4
        },
        {
          "key" : "processed",
          "doc_count" : 4
        },
        {
          "key" : "pending",
          "doc_count" : 1
        }
      ]
    }
  }
}
```

**sum_other_doc_count**  
 
> sum_other_doc_count 는 그룹핑 되지 않은 count 를 말하는데 위의 예에서는 모두 그룹핑 되어 해당 count 가 0 이 된다.
> total_amount 를 기준으로 Buckets 를 구해보면 값이 다양하여 그룹핑 되지 않은 많은 documents 항목이 있으며 아래와 같은 결과를 볼 수 있다.

> sum_other_doc_count - this number is the sum of the document counts for all buckets that are not part of the response. We return only the top buckets in the response. If there are many buckets, some buckets will not make it to the response. We count all the documents that contain these buckets and display this number as sum_other_doc_count.

# sum_other_doc_count

**GET Search Aggregation**
```sh
GET /order/_search
{
  "size":0,
  "aggs": {
    "status_terms":{
      "terms": {
        "field": "total_amount"
      }
    }
  }
}
```

**GET Search Result Aggregation**  
```sh
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "status_terms" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 10,
      "buckets" : [
        {
          "key" : 25.270000457763672,
          "doc_count" : 1
        },
        {
          "key" : 38.88999938964844,
          "doc_count" : 1
        },
        {
          "key" : 41.22999954223633,
          "doc_count" : 1
        },
        {
          "key" : 61.95000076293945,
          "doc_count" : 1
        },
        {
          "key" : 74.9000015258789,
          "doc_count" : 1
        },
        {
          "key" : 75.88999938964844,
          "doc_count" : 1
        },
        {
          "key" : 80.33000183105469,
          "doc_count" : 1
        },
        {
          "key" : 80.75,
          "doc_count" : 1
        },
        {
          "key" : 93.69000244140625,
          "doc_count" : 1
        },
        {
          "key" : 98.87000274658203,
          "doc_count" : 1
        }
      ]
    }
  }
}
```


# doc_count_error_upper_bound
 
> 집계 count 결과는 정확하지 않을 수 있다.
> 예를 들어 특정 product 를 Bucket Aggregation 한다고 생각해 보면 아마도 아래와 같이 쿼리를 하게 된다.
```sh
GET /_search
{
    "aggs" : {
        "products" : {
            "terms" : {
                "field" : "product",
                "size" : 3
            }
        }
    }
}
```

![image](https://user-images.githubusercontent.com/84139720/155046872-9819d595-ccd9-436a-9e47-585587088cdd.png)


> 예를 들어 전체 제품이 아래와 같다고 생각해 보면
> 이중 각 Shard 별 3개지 top products 만 count 하여

![image](https://user-images.githubusercontent.com/84139720/155046915-5944841b-7d24-41e7-ae33-10a6c5109149.png)
실행의 결과가 아래와 같게 된다.
 
> 결과적으로 Product B 와 Product C 의 집계 결과가 전체 documents 에서 집계한 것과 차이가 발생한다.

![image](https://user-images.githubusercontent.com/84139720/155047069-84a99c36-4d42-4fa9-bdd8-cfabc077a329.png)
doc_count_error_upper_bound 는 이렇듯 포함되지 않은 데이터 중 마지막 행을 조사하여 리턴한다.
 
> 위의 경우라면 각 shard 의 5번 행이 되며 10 + 10 + 10 = 30 을 리턴할 것이다.

```sh
GET order/_search
{
  "size": 0,
  "aggs": {
    "status_terms": {
      "terms": {
        "field": "_id",
        "size": 150000
      },
      "aggs": {
        "text": {
          "terms": {
            "field": "total_amount"
          }
        }
      }
    }
  }
}

# Search Results
{
  "took" : 5,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "status_terms" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "1",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 160.0800018310547,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "10",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 41.22999954223633,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "11",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 123.54000091552734,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "12",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 175.83999633789062,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "13",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 93.69000244140625,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "14",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 80.33000183105469,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "15",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 113.86000061035156,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "16",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 61.95000076293945,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "17",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 74.9000015258789,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "18",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 80.75,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "19",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 127.41000366210938,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "2",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 106.26000213623047,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "20",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 75.88999938964844,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "3",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 38.88999938964844,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "4",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 168.22000122070312,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "5",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 135.80999755859375,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "6",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 202.74000549316406,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "7",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 25.270000457763672,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "8",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 123.66999816894531,
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "9",
          "doc_count" : 1,
          "text" : {
            "doc_count_error_upper_bound" : 0,
            "sum_other_doc_count" : 0,
            "buckets" : [
              {
                "key" : 98.87000274658203,
                "doc_count" : 1
              }
            ]
          }
        }
      ]
    }
  }
}

```




# Nested Aggregation
 
>  Metric Aggregation 과 Bucket Aggregation 은 같이 사용되어 쿼리 결과를 얻어낼 때 사용할 수 있다.
>  
![image](https://user-images.githubusercontent.com/84139720/155047101-7f73bc2b-075a-468d-a588-d628883f5601.png)

**Nested Aggregation**  
```sh
GET order/_search
{
  "size":0,
  "aggs": {
    "status_terms":{
      "terms": {
        "field": "status.keyword"
      },
      "aggs": {
        "status_stats": {
          "stats": {
            "field" : "total_amount"
          }
        }
      }
    }
  }
}


# Search Results
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
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "status_terms" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "cancelled",
          "doc_count" : 6,
          "status_stats" : {
            "count" : 6,
            "min" : 41.22999954223633,
            "max" : 168.22000122070312,
            "avg" : 113.82333437601726,
            "sum" : 682.9400062561035
          }
        },
        {
          "key" : "completed",
          "doc_count" : 5,
          "status_stats" : {
            "count" : 5,
            "min" : 38.88999938964844,
            "max" : 202.74000549316406,
            "avg" : 111.91800079345703,
            "sum" : 559.5900039672852
          }
        },
        {
          "key" : "confirmed",
          "doc_count" : 4,
          "status_stats" : {
            "count" : 4,
            "min" : 25.270000457763672,
            "max" : 113.86000061035156,
            "avg" : 68.9950008392334,
            "sum" : 275.9800033569336
          }
        },
        {
          "key" : "processed",
          "doc_count" : 4,
          "status_stats" : {
            "count" : 4,
            "min" : 80.33000183105469,
            "max" : 160.0800018310547,
            "avg" : 103.7125015258789,
            "sum" : 414.8500061035156
          }
        },
        {
          "key" : "pending",
          "doc_count" : 1,
          "status_stats" : {
            "count" : 1,
            "min" : 175.83999633789062,
            "max" : 175.83999633789062,
            "avg" : 175.83999633789062,
            "sum" : 175.83999633789062
          }
        }
      ]
    }
  }
}

```


# Filter Aggregation
```sh
GET order/_search
{
  "size": 0,
  "aggs": {
    "low_value": {
      "filter": {
        "range": {
          "total_amount": {
            "lte": 50
          }
        }
      },
      "aggs": {
        "avg_amount": {
          "avg": {
            "field": "total_amount"
          }
        }
      }
    }
  }
}

# Search Results
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "low_value" : {
      "doc_count" : 3,
      "avg_amount" : {
        "value" : 35.12999979654948
      }
    }
  }
}

```



# Range Aggregation
```sh
{
  "size": 0,
  "aggs": {
    "amount_distribution": {
      "range": {
        "field": "total_amount",
        "ranges": [
          {
            "to": 50
          },
          {
            "from": 50,
            "to": 100
          },
          {
            "from": 100
          }
        ]
      }
    }
  }
}

# Search Results
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "amount_distribution" : {
      "buckets" : [
        {
          "key" : "*-50.0",
          "to" : 50.0,
          "doc_count" : 3
        },
        {
          "key" : "50.0-100.0",
          "from" : 50.0,
          "to" : 100.0,
          "doc_count" : 7
        },
        {
          "key" : "100.0-*",
          "from" : 100.0,
          "doc_count" : 10
        }
      ]
    }
  }
}

```

# Histogram Aggregation
혹은 Histogram 이라는 옵션을 사용하는데 이는 특정 간격으로 Range 를 구할수 있다.
![image](https://user-images.githubusercontent.com/84139720/155049248-a08310d1-4a9c-4d51-918d-9d140313e24b.png)

```sh
GET order/_search
{
  "size":0,
  "aggs": {
    "amount_distribution": {
      "histogram": {
        "field": "total_amount",
        "interval": 50
      }
    }
  }
}

# Search Results
{
  "took" : 6,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "amount_distribution" : {
      "buckets" : [
        {
          "key" : 0.0,
          "doc_count" : 3
        },
        {
          "key" : 50.0,
          "doc_count" : 7
        },
        {
          "key" : 100.0,
          "doc_count" : 6
        },
        {
          "key" : 150.0,
          "doc_count" : 3
        },
        {
          "key" : 200.0,
          "doc_count" : 1
        }
      ]
    }
  }
}


```


