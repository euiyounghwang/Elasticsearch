# Elasticsearch
Elasticsearch Cluster, Settings&amp;Mappings, Query, Extra

Elasticsearch에 저장되는 도큐먼트는 모든 문자열(text) 필드 별로 역 인덱스를 생성합니다. 검색에 사용하는 경우에는 앞에서 설명한 역 인덱스의 예제는 실제로는 보통 아래와 같이 저장됩니다.

<img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-LntVKcOQaeoQJjPnbpP%2F-LntVxXxMRFyBg4lJyRx%2F6.2-01.png?alt=media&token=7926be1d-e99f-4f5c-8bed-f80708f55931">

Elasticsearch는 문자열 필드가 저장될 때 데이터에서 검색어 토큰을 저장하기 위해 여러 단계의 처리 과정을 거칩니다. 이 전체 과정을 텍스트 분석(Text Analysis) 이라고 하고 이 과정을 처리하는 기능을 애널라이저(Analyzer) 라고 합니다. Elasticsearch의 애널라이저는 0~3개의 캐릭터 필터(Character Filter)와 1개의 토크나이저(Tokenizer), 그리고 0~n개의 토큰 필터(Token Filter)로 이루어집니다.

<img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-LntYrdKmTe441TqYAJl%2F-LntZ63SAIfHu6Q_OgzJ%2F6.2-02.png?alt=media&token=52213afe-e6ab-4bc2-b9e0-20027542a79e">

텍스트 데이터가 입력되면 가장 먼저 필요에 따라 전체 문장에서 특정 문자를 대치하거나 제거하는데 이 과정을 담당하는 기능이 캐릭터 필터입니다. 뒤에서 자세히 설명하고 지금 설명 할 예제에서는 적용하지 않겠습니다.
  다음으로는 문장에 속한 단어들을 텀 단위로 하나씩 분리 해 내는 처리 과정을 거치는데 이 과정을 담당하는 기능이 토크나이저 입니다. 토크나이저는 반드시 1개만 적용이 가능합니다. 다음은 whitespace 토크나이저를 이용해서 공백을 기준으로 텀 들을 분리 한 결과입니다.
  
<img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-LntL_BGpuFbNXy_sFtK%2F-LntLbibpXHABupWvXtu%2F6.1-03.png?alt=media&token=d2726f20-a7ea-4219-bcb0-340cbe1d21f1">
  
  다음으로 분리된 텀 들을 하나씩 가공하는 과정을 거치는데 이 과정을 담당하는 기능이 토큰 필터 입니다. 토큰 필터는 0개 부터 여러 개를 적용할 수 있습니다.
  여기서는 먼저 lowercase 토큰 필터를 이용해서 대문자를 모두 소문자로 바꿔줍니다. 이렇게 하면 대소문자 구별 없이 검색이 가능하게 됩니다. 대소문자가 일치하게 되어 같은 텀이 된 토큰들은 모두 하나로 병합이 됩니다.
  
  <img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-LntbFF1Cbw9kue34dxC%2F-LntcLPw_rlidqO38odU%2F6.2-04.png?alt=media&token=52d756b7-9533-492d-999d-0640f775bcd7">
  
  텀 중에는 검색어로서의 가치가 없는 단어들이 있는데 이런 단어를 불용어(stopword) 라고 합니다. 보통 a, an, are, at, be, but, by, do, for, i, no, the, to … 등의 단어들은 불용어로 간주되어 검색어 토큰에서 제외됩니다. stop토큰 필터를 적용하면 우리가 만드는 역 인덱스에서 the가 제거됩니다.
  
<img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-LntdTZrPbJB3nIxslS_%2F-LntdYna6xmoecLuIbcL%2F6.2-05.png?alt=media&token=4e537bb0-76a1-4b98-877d-ceabe3e71bd9">
    
    제 형태소 분석 과정을 거쳐서 문법상 변형된 단어를 일반적으로 검색에 쓰이는 기본 형태로 변환하여 검색이 가능하게 합니다. 영어에서는 형태소 분석을 위해 snowball 토큰 필터를 주로 사용하는데 이 필터는 ~s, ~ing 등을 제거합니다. 그리고 happy, lazy 와 같은 단어들은 happiness, laziness와 같은 형태로도 사용되기 때문에 ~y 를 ~i 로 변경합니다. snowball 토큰 필터를 적용하고 나면 jumps와 jumping은 모두 jump로 변경되고, 동일하게 jump 로 되었기 때문에 하나의 텀으로 병합됩니다.
    
<img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-Lntet01jJphNCVzIo7v%2F-Lntf24nCf5pgDeswY5d%2F6.2-06.png?alt=media&token=4140c045-ee24-443f-b927-84cfdad57a9f">
        
필요에 따라서는 동의어를 추가 해 주기도 합니다. synonym 토큰 필터를 사용하여 quick 텀에 동의어로 fast를 지정하면 fast 로 검색했을 때도 같은 의미인 quick 을 포함하는 도큐먼트가 검색되도록 할 수 있습니다. AWS 와 Amazon 을 동의어로 놓아 amazon을 검색해도 AWS 를 찾을 수 있게 하는 등 실제로도 사용되는 사례가 많습니다.

<img src="https://1535112035-files.gitbook.io/~/files/v0/b/gitbook-28427.appspot.com/o/assets%2F-Ln04DaYZaDjdiR_ZsKo%2F-LntgOPNccbFlmVJP9gx%2F-LntgR3I2LDe35aKI--u%2F6.2-07.png?alt=media&token=b758aac1-6f16-4a8f-8649-bd5a131adbbc">



        
