
## Spane Query Sample

```sh
####################################################
 # sample.1
 # 시나리오 : (스테인레* 스텐레스*) OR (압연* 열연* (선강* adj 연주*) (기술* adj 시스템*))
 ####################################################

GET test_idx/_search
 {
   "_source": [
     "CURR_DEPT_NM_ALL",
     "CURR_DEPT_NM_ALL.space"
   ],
   "query": {
     "bool": {
       "should": [
         {
           "span_or": {
             "clauses": [
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "스테인레*"
                       }
                     }
                   }
                 }
               },
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "스텐레스*"
                       }
                     }
                   }
                 }
               }
             ]
           }
         },
         {
           "span_or": {
             "clauses": [
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "압연*"
                       }
                     }
                   }
                 }
               },
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "열연*"
                       }
                     }
                   }
                 }
               },
               {
                 "span_near": {
                   "clauses": [
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "선강*"
                             }
                           }
                         }
                       }
                     },
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "연주*"
                             }
                           }
                         }
                       }
                     }
                   ],
                   "slop": 1,
                   "in_order": true
                 }
               },
               {
                 "span_near": {
                   "clauses": [
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "기술*"
                             }
                           }
                         }
                       }
                     },
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "시스템*"
                             }
                           }
                         }
                       }
                     }
                   ],
                   "slop": 1,
                   "in_order": true
                 }
               }
             ]
           }
         }
       ]
     }
   },"size": 500, 
   "highlight": {
     "fields": {
       "*": {}
     }
   }
 }
 ```



```sh
 ##############################################
 # sample.2
 # 시나리오 : (압연* 박판*) adj3 (열연* 전기*)
 ##############################################
GET posco_patent_idx/_search
 {
   "query": {
     "bool": {
       "must": [
         {
           "span_near": {
             "clauses": [
               {
                 "span_or": {
                   "clauses": [
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "압연*"
                             }
                           }
                         }
                       }
                     },
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "박판*"
                             }
                           }
                         }
                       }
                     }
                   ]
                 }
               },
               {
                 "span_or": {
                   "clauses": [
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "열연*"
                             }
                           }
                         }
                       }
                     },
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "전기*"
                             }
                           }
                         }
                       }
                     }
                   ]
                 }
               }
             ],
             "slop": 3,
             "in_order": true
           }
         }
       ]
     }
   },
   "size": 500,
   "highlight": {
     "fields": {
       "*":{}
     }
   }
 }



 ####################################################
 # sample.3 (sample.1 + sample.2)
 # 시나리오 : (스테인레* 스텐레스*) OR (압연* 열연* (선강* adj 연주*) (기술* adj 시스템*) ((압연* 박판*) adj3 (열연* 전기*)))
 ####################################################

GET posco_patent_idx/_search
 {
   "_source": [
     "CURR_DEPT_NM_ALL",
     "CURR_DEPT_NM_ALL.space"
   ],
   "query": {
     "bool": {
       "should": [
         {
           "span_or": {
             "clauses": [
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "스테인레*"
                       }
                     }
                   }
                 }
               },
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "스텐레스*"
                       }
                     }
                   }
                 }
               }
             ]
           }
         },
         {
           "span_or": {
             "clauses": [
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "압연*"
                       }
                     }
                   }
                 }
               },
               {
                 "span_multi": {
                   "match": {
                     "wildcard": {
                       "CURR_DEPT_NM_ALL.space": {
                         "value": "열연*"
                       }
                     }
                   }
                 }
               },
               {
                 "span_near": {
                   "clauses": [
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "선강*"
                             }
                           }
                         }
                       }
                     },
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "연주*"
                             }
                           }
                         }
                       }
                     }
                   ],
                   "slop": 1,
                   "in_order": true
                 }
               },
               {
                 "span_near": {
                   "clauses": [
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "기술*"
                             }
                           }
                         }
                       }
                     },
                     {
                       "span_multi": {
                         "match": {
                           "wildcard": {
                             "CURR_DEPT_NM_ALL.space": {
                               "value": "시스템*"
                             }
                           }
                         }
                       }
                     }
                   ],
                   "slop": 1,
                   "in_order": true
                 }
               },
               {
                 "span_near": {
                   "clauses": [
                     {
                       "span_or": {
                         "clauses": [
                           {
                             "span_multi": {
                               "match": {
                                 "wildcard": {
                                   "CURR_DEPT_NM_ALL.space": {
                                     "value": "압연*"
                                   }
                                 }
                               }
                             }
                           },
                           {
                             "span_multi": {
                               "match": {
                                 "wildcard": {
                                   "CURR_DEPT_NM_ALL.space": {
                                     "value": "박판*"
                                   }
                                 }
                               }
                             }
                           }
                         ]
                       }
                     },
                     {
                       "span_or": {
                         "clauses": [
                           {
                             "span_multi": {
                               "match": {
                                 "wildcard": {
                                   "CURR_DEPT_NM_ALL.space": {
                                     "value": "열연*"
                                   }
                                 }
                               }
                             }
                           },
                           {
                             "span_multi": {
                               "match": {
                                 "wildcard": {
                                   "CURR_DEPT_NM_ALL.space": {
                                     "value": "전기*"
                                   }
                                 }
                               }
                             }
                           }
                         ]
                       }
                     }
                   ],
                   "slop": 3,
                   "in_order": true
                 }
               }
             ]
           }
         }
       ]
     }
   },
   "size": 500, 
   "highlight": {
     "fields": {
       "*": {}
     }
   }
 }

 


## auto query
####################################################
# sample.1
# 시나리오 : (스테인레* 스텐레스*) OR (압연* 열연* (선강* 
# adj 연주*) (기술* adj 시스템*))
# ####################################################

GET posco_patent_idx/_search
{
  "_source": [
    "CURR_DEPT_NM_ALL",
    "CURR_DEPT_NM_ALL.space"
  ],
  "query": {
    "bool": {
      "should": [
        {
          "span_or": {
            "clauses": [
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CURR_DEPT_NM_ALL.space": {
                        "value": "스1테인레*"
                      }
                    }
                  }
                }
              },
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CURR_DEPT_NM_ALL.space": {
                        "value": "스텐1레스*"
                      }
                    }
                  }
                }
              }
            ]
          }
        },
        {
          "span_or": {
            "clauses": [
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CURR_DEPT_NM_ALL.space": {
                        "value": "압1연*"
                      }
                    }
                  }
                }
              },
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CURR_DEPT_NM_ALL.space": {
                        "value": "열1연*"
                      }
                    }
                  }
                }
              },
              {
                "span_near": {
                  "clauses": [
                    {
                      "span_or": {
                        "clauses": [
                          {
                            "span_multi": {
                              "match": {
                                "wildcard": {
                                  "CURR_DEPT_NM_ALL.space": {
                                    "value": "스테*"
                                  }
                                }
                              }
                            }
                          }
                        ]
                      }
                    },
                    {
                      "span_or": {
                        "clauses": [
                          {
                            "span_multi": {
                              "match": {
                                "wildcard": {
                                  "CURR_DEPT_NM_ALL.space": {
                                    "value": "품질*"
                                  }
                                }
                              }
                            }
                          }
                        ]
                      }
                    }
                  ],
                  "slop": 1,
                  "in_order": true
                }
              },
              {
                "span_near": {
                  "clauses": [
                    {
                      "span_multi": {
                        "match": {
                          "wildcard": {
                            "CURR_DEPT_NM_ALL.space": {
                              "value": "기1술*"
                            }
                          }
                        }
                      }
                    },
                    {
                      "span_multi": {
                        "match": {
                          "wildcard": {
                            "CURR_DEPT_NM_ALL.space": {
                              "value": "시1스템*"
                            }
                          }
                        }
                      }
                    }
                  ],
                  "slop": 1,
                  "in_order": true
                }
              }
            ]
          }
        }
      ]
    }
  },
  "size": 500,
  "highlight": {
    "fields": {
      "*": {}
    }
  }
}


# final span query
# span query
# span near
# span or _near span_or (*)
GET span_test/_search
{
  "_source": [
    "PATT_SUGG_NO",
    "CONTENT"
  ],
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "query": "((CERT*) 통신*) OR (1*) -의영*",
            "analyze_wildcard": true,
            "lenient": true,
            "fields": [
              "CONTENT"
            ],
            "default_operator": "AND"
          }
        },
        {
          "terms": {
            "CODE_TEST.comma": [
              "시험/계측"
            ]
          }
        },
        {
          "terms": {
            "CODE": [
              "KR",
              "-KR"
            ]
          }
        },
        {
          "span_or": {
            "clauses": [
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CONTENT.space": {
                        "value": "*명령*"
                      }
                    }
                  }
                }
              },
              {
                "span_near": {
                  "clauses": [
                    {
                      "span_or": {
                        "clauses": [
                          {
                            "span_multi": {
                              "match": {
                                "wildcard": {
                                  "CONTENT.space": {
                                    "value": "*1압연*"
                                  }
                                }
                              }
                            }
                          },
                          {
                            "span_multi": {
                              "match": {
                                "wildcard": {
                                  "CONTENT.space": {
                                    "value": "*압연*"
                                  }
                                }
                              }
                            }
                          }
                        ]
                      }
                    },
                    {
                      "span_or": {
                        "clauses": [
                          {
                            "span_multi": {
                              "match": {
                                "wildcard": {
                                  "CONTENT.space": {
                                    "value": "*장치*"
                                  }
                                }
                              }
                            }
                          }
                        ]
                      }
                    }
                  ],
                  "slop": 10,
                  "in_order": false
                }
              }
            ]
          }
        }
      ]
    }
  },
  "from": 0,
  "size": 1,
  "highlight": {
    "require_field_match": true,
    "order": "score",
    "pre_tags": [
      "<b>"
    ],
    "post_tags": [
      "</b>"
    ],
    "fields": {
      "*": {
        "number_of_fragments": 1,
        "type": "plain",
        "fragment_size": 150
      }
    }
  }
}


# final span query
# span query
# span near
# span or _near
GET span_test/_search
{
  "_source": [
    "PATT_SUGG_NO",
    "CONTENT"
  ],
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "query": "((CERT*) 통신*) OR (1*) -의영*",
            "analyze_wildcard": true,
            "lenient": true,
            "fields": [
              "CONTENT"
            ],
            "default_operator": "AND"
          }
        },
        {
          "terms": {
            "CODE_TEST.comma": [
              "시험/계측"
            ]
          }
        },
        {
          "terms": {
            "CODE": [
              "KR",
              "-KR"
            ]
          }
        },
        {
          "span_or": {
            "clauses": [
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CONTENT.space": {
                        "value": "*엔터*"
                      }
                    }
                  }
                }
              },
              {
                "span_near": {
                  "clauses": [
                    {
                      "span_multi": {
                        "match": {
                          "wildcard": {
                            "CONTENT.space": {
                              "value": "*엔터*"
                            }
                          }
                        }
                      }
                    },
                    {
                      "span_multi": {
                        "match": {
                          "wildcard": {
                            "CONTENT.space": {
                              "value": "작업*"
                            }
                          }
                        }
                      }
                    }
                  ],
                  "slop": 3,
                  "in_order": false
                }
              },
              {
                "span_near": {
                  "clauses": [
                    {
                      "span_multi": {
                        "match": {
                          "wildcard": {
                            "CONTENT.space": {
                              "value": "인증*"
                            }
                          }
                        }
                      }
                    },
                    {
                      "span_multi": {
                        "match": {
                          "wildcard": {
                            "CONTENT.space": {
                              "value": "없음*"
                            }
                          }
                        }
                      }
                    }
                  ],
                  "slop": 3,
                  "in_order": false
                }
              }
            ]
          }
        }
      ]
    }
  },
  "from": 0,
  "size": 1,
  "highlight": {
    "require_field_match": true,
    "order": "score",
    "pre_tags": [
      "<b>"
    ],
    "post_tags": [
      "</b>"
    ],
    "fields": {
      "*": {
        "number_of_fragments": 1,
        "type": "plain",
        "fragment_size": 150
      }
    }
  }
}


GET span_test/_search

# inteval query
POST span_test/_search
{
  "query": {
    "intervals" : {
      "CONTENT" : {
        "all_of" : {
          "ordered" : true,
          "intervals" : [
            {
              "match" : {
                "query" : "*엔터*",
                "max_gaps" : 10,
                "ordered" : true
              }
            },
            {
              "any_of" : {
                "intervals" : [
                  { "match" : { "query" : "*작업1" } },
                  { "match" : { "query" : "red velvet" } },
                  { "match" : { "query" : "*작업" } }
                ]
              }
            }
          ]
        }
      }
    }
  }
}


GET span_test/_search
{
  "_source": [
    "PATT_SUGG_NO",
    "CONTENT"
  ],
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "query": "((CERT*) 통신*) OR (1*) -의영*",
            "analyze_wildcard": true,
            "lenient": true,
            "fields": [
              "CONTENT"
            ],
            "default_operator": "AND"
          }
        },
        {
          "terms": {
            "CODE": [
              "KR",
              "-KR"
            ]
          }
        },
        {
          "span_near": {
            "clauses": [
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CONTENT.space": {
                        "value": "*이즈*"
                      }
                    }
                  }
                }
              },
              {
                "span_multi": {
                  "match": {
                    "wildcard": {
                      "CONTENT.space": {
                        "value": "작업*"
                      }
                    }
                  }
                }
              }
            ],
            "slop": 3,
            "in_order": false
          }
        }
      ]
    }
  },
  "from": 0,
  "size": 1,
  "highlight": {
    "require_field_match": true,
    "order": "score",
    "pre_tags": [
      "<b>"
    ],
    "post_tags": [
      "</b>"
    ],
    "fields": {
      "*": {
        "number_of_fragments": 1,
        "type": "plain",
        "fragment_size": 150
      }
    }
  }
}
```
