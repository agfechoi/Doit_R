#11월 10일 6-6 집단별로 요약하기

#집단별 평균이나 집단별 빈도처럼 각 집단을 요약한 값을 구할 때는 group_by와
#summarise를 사용한다. 이 함수들을 이용해 요약표를 만들면 집단 간에 어떤 차이가
#있는지 쉽게 파악할 수 있다.

#먼저 집단별로 요약하기. summarise()를 사용해보자
exam %>% summarise(mean_math = mean(math)) #수학 평균 산출
mean(exam$math) # 똑같
#summarise는 group by와 조합해서 집단별 요약표를 만들떄 사용

# group_by에 변수를 지정하면 변수 항목별로 데이터를 분리한다. 여기에
#summarise()를 조합하면 집단별 요약 통계량을 산출한다. 아래 코드는
#반별 수학 점수 평균을 산출하는 기능을 한다.

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math))

#여러 요약 통계량 한 번에 산출하기
#mutate로 여러 변수를 동시에 추가했던 것처럼 summarise도 여러 요약 통계량을
#한번에 산출 할 수 있다.

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

#코드 맨 밑줄 n()은 데이터가 몇 행으로 되어 있는지 '빈도'를 구하는 기능
#여기서는 반별 학생수를 말해준다.

#각 집단별로 다시 집단 나누기
#group_by에 여러 변수를 지정하면 집단을 나눈 후 다시 하위 집단으로 나눌 수 
#있다. mpg데이터를 이용해서 하위 집단별 평균을 구해보자
#회사별로 집단을 나눈 후 다시 구동 방식별로 나눠 도시 연비 평균을 구해보자
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

#dplyr 조합하기
#회사별로 "suv"자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로
#정렬하고, 1~5위까지 출력하기

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == 'suv') %>% 
  mutate(tot = (cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

#혼자서 해보기
#Q1. mpg 데이터의 class는 "suv", "compact"등 자동차를 특징에 따라 일곱 종류로
#분류한 변수다. 어떤 차종의 도시 연비가 높은지 비교하고 싶다.
#class별 cty 평균을 구해보자

mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head

#Q2. 앞 문제의 출력 결과는 class 값 알파벳 순서로 정렬 되어 있다.
#어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty평균이 높은 순으로
#정렬해 출력하라

mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% head

#Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 한다.
#hwy평균이 가장 높은 회사 세곳을 출력하세요

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% head(3)

#Q4. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 한다.
#각 회사별 compact 차종 수를 내림차순으로 정렬해 출력하라

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == 'compact') %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))
