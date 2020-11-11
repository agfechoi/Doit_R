#11월 11일 6단원 -7 데이터 합치기

#하나의 데이터만 가지고 분석하기도 하지만 여러 데이터를 합쳐 하나의 데이터로
#만든다음에 분석하기도 한다.

#가로로 합치기

#학생 다섯명의 중간고사와 기말고사 봤다고 하고 데이터를 만들어본다.

#중간고사 데이터 생성
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60, 80, 70, 90, 85))
#기말고사 데이터 생성
test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70, 83, 65, 95, 80))
 
test1 #중간고사 출력
test2 #기말고사 출력

#dplyr 패키지의 left_join()을 이용하면 데이터를 가로로 합칠 수 있다
#괄호안에 합칠 데이터 프레임명을 나열하고, 기준으로 삼을 변수명을
#by에 저장하면 된다.
total <- left_join(test1, test2, by = "id")
total
#쨘.

#다른 데이터를 활용해 변수 추가하기.
#left_join을 응용하여 특정 변수 값 기준으로 다른 데이터를 추가할 수 있다.

#각반 학생들의 시험 점수를 담은 exam 데이터를 분석하고 있는데
#추가로 반별 담임교사 명단을 얻었다고 가정해보자.

name <- data.frame(class = c(1,2),
                   teacher = c("Kim", "Choi"))
name

#class를 변수로 삼아서 name의 teacher변수를 exam에 추가해본다.
exam_new <- left_join(exam, name, by = 'class')
exam_new

#세로로 합치기
#1. 다섯 학생이 먼저 시험을 보고 나중에 다섯명이 따로 시험을 봤다고 가정

group_a <- data.frame(id = c(1,2,3,4,5),
                    test = c(60, 80, 70, 90, 85))

group_b <- data.frame(id = c(6,7,8,9,10),
                    test = c(70, 83, 65, 95, 80))

#bind_rows()를 이용하여 데이터를 세로로 합친다.

group_all <- bind_rows(group_a, group_b)
group_all
#데이터를 세로로 합칠때는 두 데이터의 변수명이 같아야 한다,
#만약 변수명이 다르면 rename()을 이용해 동일하게 맞춘 후에 합치면 된다.


#혼자서 해보기
#mpg데이터를 이용해 분석 문제를 해결해 보세요.
#mpg데이터의 fl변수는 자동차에 사용하는 연료를 의미한다.
#주어진 자료대로 데이터 프레임을 만들어보자

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = FALSE)
#stringAsFactors = FALSE는 문자를 factor 타입으로 변환하지 않도록 설정하는
#파라미터다. data.frame()은 변수에 문자가 들어 있으면 factor타입으로 변환
#하도록 기본 설정되어 있다. fuel데이터의 문자 변수 fl을 mpg데이터와
#동일하게 문자 타입(chr)으로 만들어야 분석작업에서 오류가 발생하지 않기 때문에
#이 파라미터를 설정한 것이다.

#Q1. mpg데이터에는 연료 종류를 나타낸 fl변수는 있지만 연료 가격을 나타낸
#변수는 없다. 위에서 만든 fuel데이터를 이용해 mpg 데이터에 price_fl(연료가격)
#변수를 추가하세요.
mpg <- ggplot2::mpg
mpg_new <- left_join(mpg, fuel, by = "fl")
head(mpg_new)
View(mpg_new)

#Q2. 연료 가격 변숙 잘 추가됐는지 확인하기 위해 model, fl, price_fl 변수를
#추출해 앞부분 5행을 출력해보세요
mpg_new %>% select(model, fl, price_fl) %>% head(5)
