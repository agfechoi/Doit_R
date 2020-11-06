# 11월 6일 6단원 -4 순서대로 정렬하기

exam <- data.frame(id = c(1, 2, 3, 4, 5, 6),
                   class = c(1, 1, 1, 1, 2, 2),
                   math = c(50, 60, 45, 30, 25, 50),
                   english = c(98, 97, 86, 98, 80, 89),
                   science = c(50, 60, 78, 58, 65, 98))

#exam data는 id변수 순으로 정렬되어 있다. 이를 다른 열 기준으로 보고 싶으면
exam %>% arrange(math) #math 오름차순 정렬

#내림차순으로 정렬하고 싶을땐?
exam %>% arrange(desc(math))

#정렬 기준으로 삼을 변수를 여러 개 지정하려면 쉼표를 이용해 변수명을 나열하면
#된다. 아래 코드를 실행하면 먼저 반을 기준으로 오름차순 정렬한 후 각 반에서 
#수학 점수를 기준으로 오름차순 정렬해 출력합니다.

exam %>% arrange(class, math) #class 및 math 오름차순 정렬


#혼자서 해보기 mpg 데이터를 이용해 분석 문제를 해결해 보세요.
#Q1. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가
#높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는
#자동차의 데이터를 출력하세요.
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

audi <- mpg %>% filter(manufacturer == "audi") #먼저 아우디를 필터로 뽑는다. 
audi %>% arrange(desc(hwy)) %>% head(5) #내림차순으로 놓고 head로 뽑는다.
