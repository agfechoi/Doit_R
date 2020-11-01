#11월 1일 R기본다지기

#4단원부터!! 데이터 프레임의 세계로!

#1. 변수만들기
getwd()
setwd("C:/Doit_R")
english <- c(90, 80, 60, 70)
english

math <- c(50, 60, 100, 20)
math
#2. dataframe 만들기
df_midterm <- data.frame(english, math)
df_midterm

#3. 학생의 반에 대한 정보가 추가된 데이터프레임을 만들자
class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

#4. 분석하기
mean(df_midterm$english)
#영어성적 평균
mean(df_midterm$math)
#수학성적 평균

# $기호는 데이터 프레임 안에 있는 변수를 지정할때 사용한다.

#5. 데이터프레임 한 번에 만들기
df_midterm
df_midterm2 <- data.frame(english = c(90, 80, 60, 70),
                          math = c(50, 60, 100, 20),
                          class = c(1, 1, 2, 2))
df_midterm2

#혼자서 해보기
#data.frame()과 c()를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보자
fruit <- data.frame(product = c("사과", "딸기", "수박"),
                    price = c(1800, 1500, 3000),
                    sales = c(24, 38, 13))

fruit
#앞에서 만든 데이터 프레임을 이용해 과일 가격 평균, 판매량 평균을 구해보자
mean(fruit$price) #2100
mean(fruit$sales) #25

#pg95 데이터 프레임만들기

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))

df_midterm

write.csv(df_midterm, "df_midterm.csv")
#만든 데이터 프레임 csv파일로 저장
