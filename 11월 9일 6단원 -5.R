#11월 9일 6-5 파생변수 추가하기

# 1. exam에 세 과목의 점수를 모두 합한 총합 변수를 만들어 추가한 후 일부를 출력
#해보겠다. 여기서는 total이라는 변수명을 사용해보자.

exam %>% 
  mutate(total = math + english + science) %>% #종합 변수 추가
  head(3) #일부 추출

# 2. 여러 파생변수 한 번에 추가하기 쉼표를 이용해 새 변수명과 변수를 만드는 공식
#나열

exam %>% mutate(total = math + english + science,
                mean = (math + english + science)/3) %>% 
  head(2)

# 3. mutate()에 ifelse() 적용하기
#mutate에 ifelse()를 적용하면 조건에 따라 다른 값을 부여한 변수를 추가할 수 있다.

exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head(4)

# 4. 추가한 변수를 dplyr 코드에 바로 적용하기
#변수를 추가하고 나면 이어지는 dplyr 코드에 바로 활용할 수 있다.
#아래 코드를 실행하면 mutate로 추가한 변수를 arrange()에서 기준으로 삼아
#정렬해서 일부를 출력할 수 있다.

exam %>% mutate(total = math + english + science) %>% 
  arrange(total) %>% 
  head(4)

#혼자서 해보기
#mpg 데이터를 이용해 분석 문제를 해결해 보세요

#mpg 데이터는 연비를 나타내는 변수가 hwy(고속도로 연비), cty(도시 연비)
#두 종류로 분리되어 있다. 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를
#만들어 분석하려고 한다.

#Q1. mpg() 데이터 복사본을 만들고 cty와 hwy를 합한 '합산 연비 변수를 추가해봐
mpgmpg <- as.data.frame(mpg)
mpgmpg <- mpgmpg %>% mutate(total = hwy + cty)
head(mpgmpg)

#Q2. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요.
mpgmpg <- mpgmpg %>% mutate(mean = total/2)
head(mpgmpg)

#Q3. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
mpgmpg %>% arrange(desc(mean)) %>% head(3)

#Q4. 1~3번 문제를 하나로 연결된 dplyr로 만들어서 실행해보세요

mpg %>% mutate(total = hwy + cty,
                      mean = (hwy+cty)/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)
