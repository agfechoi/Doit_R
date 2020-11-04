#11월 4일 6단원 -3 필요한 변수만 추출하기

#변수 추출하기
#exam에서 math변수만 추출해 출력하는 기능을 하는 함수 select()
exam %>% select(math)
exam %>% select(english)

#여러 변수 추출하기
exam %>% select(math, english)

#변수 제외하기
exam %>% select(-math)
#제외할 변수명 앞에 빼기 기호 -를 입력하면 된다.
#여러 변수를 제외하려면 쉼표를 이용해 제외할 변수를 나열하면 된다.
exam %>% select(-math, -english)

#dplyr 함수 조합하기
#filter()와 select() 조합하기
#filter와 select를 조합해서 1반 학생의 영어 점수를 추출해 보겠습니다.

#class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>% select(english)

#가독성 있게 줄 바꾸기
exam %>% 
  filter(class == 1) %>% 
  select(english)

#일부만 출력하기
exam %>% 
  select(id, math) %>% #id, math 추출 
  head %>% 앞부분 6행까지 추출

#혼자서 해보기
#mpg 데이터를 이용해 분석 문제를 해결해 보세요.
#Q1 mpg데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해 분석에
#활용하려고 합니다. mpg데이터에서 class(자동차종류), cty(도시연비) 변수를
#추출해 새로운 데이터를 만드세요. 새로 만든 데이터의 일부를 출력해
#두 변수로만 구성되어 있는지 확인하세요.

class_cty <- mpg %>% 
  select(class, cty)

head(class_cty)

#Q2 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 앞에서 추출한
#데이터를 이용해 class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중
#어떤 자동차의 cty(도시 연비) 평균이 더 높은지 알아보세요.

suv <- class_cty %>% filter(class == "suv")
compact <- class_cty %>% filter(class == "compact")
mean(suv$cty)
mean(compact$cty)
#compact의 도시 연비가 suv의 도시 연비보다 더 높다.