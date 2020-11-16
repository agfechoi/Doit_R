#11월 16일 8 -3 막대그래프 - 집단 간 차이 표현하기

#mpg를 이용해 drv별 평균 hwy 막대 그래프를 만들어보자
#1. 집단별 평균표 만들기
#평균 막대 그래프를 만들려면 집단별 평균표로 구성된 데이터 프레임이 필요
#dplyr 패키지를 이용해 구동방식별 평균 고속도로 연비로 구성된 데이터 프레임을
#만들자
mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg

library(ggplot2)
#그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#크기 순으로 정렬하기
#막대는 기본적으로 범주의 알파벳 순서로 정렬된다. 
#reorder()를 사용하면 막대를 값의 크기 순으로 정렬할 수 있다.
#reorder()에 변수와 정렬 기준으로 삼을 변수를 지정하면 된다.
#정렬 기준 변수 앞에 - 기호를 붙이면 내림차순으로 정렬한다.

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

#빈도 막대 그래프 만들기
#빈도 막대 그래프는 값의 개수로 막대의 길이를 표현한 그래프이다.
#y축 없이 x축만 지정하고 geom_col() 대신 geom_bar()를  사용한다.
ggplot(data = mpg, aes(x = drv)) + geom_bar()

#x축에 연속 변수를 지정하면 값의 분포를 파악할 수 있다.
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#알아두면 좋아요. geom_col() vs geom_bar()
#평균 막대 그래프는 데이터를 요약한 평균표를 먼저 만든 후 이 평균표를 이용해 
#만듭니다. 반면 빈도 막대 그래프는 별도로 표를 만들지 않고 원자료와 함께
#바로 만듭니다. 요약표를 이용하는지 원자료를 이용하는지에 따라 그래프를
#만드는 절차와 함수가 다르므로 유의하세요.
#요약표는 geom_col() 원자료는 geom_bar()을 사용해 막대 그래프를 만듭니다.

#혼자서 해보기
#mpg 데이터를 이용해 분석 문제를 해결해보세요

#Q1. 어떤 회사에서 생산한 "SUV" 차종의 도시 연비가 높은지 알아보려고 합니다.
#"SUV"차종을 대상으로 평균 CTY가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해
#보세요. 막대는 연비가 높은 순으로 정렬하세요.

mpg <- as.data.frame(ggplot2::mpg)
head(mpg)

mpg_suv <- mpg %>% 
  filter(class == 'suv') %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

ggplot(data = mpg_suv, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()

#Q2. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 한다.
#자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

ggplot(data = mpg, aes(x = class))+geom_bar()
