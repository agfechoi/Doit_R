#11월 2일 5장 데이터 분석 기초!
#-데이터 파악하기, 다루기 쉽게 수정하기


#5-1 데이터 파악하기

library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)

head(mpg) #데이터 앞부분 6행 확인
tail(mpg) #데이터 뒷부분 6행 확인
dim(mpg) #데이터 차원 확인 234개의 행과 11개의 열로 이루어진 데이터다
str(mpg) #각 변수들(열)의 속성 확인

?mpg #각 변수가 무얼 의미하는지 궁금할때 사용한다.

summary(mpg) #요약통계량 살펴보기
#숫자로된 변수는 여섯가지 요약 통계량을 보여주고 문자로 된 변수는
#요약 통계량을 보여줄 수 없으니 값의 개수(length)와 변수의 속성을 보여준다.

#cty열을 보면 다음과 같은 특성 파악 가능
#자동차들이 도시에서 평균적으로 개런당 16.86마일을 주행한다.
#연비가 가장 낮은 모델은 갤런당 9마일(min), 가장 높은 모델은 35마일(max)을 주행
#자동차들의 연비가 갤런당 17마일을 중심(median)으로 14마일에서 19마일 사이에
#몰려있다.

#5-2 변수명 바꾸기
#dplyr패키지의 rename()함수를 이용해 변수명을 바꾸어보자

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))

df_raw
library(dplyr)

#변수명을 바꾸기 전에 원본을 유지하기 위해 df_new라는 데이터 프레임 복사본을
#만든다. 복사본을 만들어서 그걸로 정리하는 습관을 들이는게 좋다.
df_new <- df_raw

# 이제 변수명을 var1, var2에서 v1, v2로 바꾸어보자

df_new <- rename(df_new, v1 = var1)
df_new <- rename(df_new, v2 = var2)
df_new #쨘.

#혼자서 해보기
#mpg 데이터의 변수명은 긴 단어를 줄인 축약어로 되어 있다. cty변수는 도시연비
#hwy변수는 고속도로 연비다. 이를 이해하기 쉽게 바꿔보는 연습을 해보자

#Q1 ggplot2패키지의 mpg데이터를 사용할 수 있도록 불러온 후 복사본을 만드세요
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg #복사본 생성!

#Q2 복사본 데이터를 이용해서 cty는 city로 hwy는 highway로 수정하세요
mpg_new <- rename(mpg_new, city = cty)
mpg_new <- rename(mpg_new, highway = hwy)
head(mpg_new) #해결!

# 5-3 파생변수 만들기
#변수 조합해서 파생변수 만들기

df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))

df
#var1과 var2변수의 값을 더한 var_sum이라는 파생변수를 만들어서 df에 추가해보자
#데이터 프레임명에 $를 붙여서 새로만들 변수명을 입력하고 <-로 할당한다.

df$var_sum <- df$var1 + df$var2
df #짠.

#이번에는 var1과 var2를 더한 후 2로 나누어 var_mean이라는 파생변수를 만들자
#변수명 앞에 데이터 프레임명을 반복해서 입력해야한다!!

df$var_mean <- (df$var1 + df$var2)/2
df #짠.

#mpg데이터를 가지고 해보자
#cty와 hwy를 더하고 2로 나우어서 돋로 유형을 통합한 연비 변수를 만들어보자
mpg$total <- (mpg$cty + mpg$hwy)/2 #통합 연비 변수 생성성
head(mpg) #쨘
#변수를 추가하고 나면 함수로 똑같이 분석 가능하다.
mean(mpg$total) #통합 연비 변수 평균

#조건문 사용해서 파생변수 만들기
#mpg데이터에서 연비가 기준치를 넘기면 합격, 못넘기면 불합격을 부여하도록

#1. 기준값 정하기
#몇을 기준으로 합격 여부를 판단할 것인가?
summary(mpg$total)
#평균과 중앙값을 확인해본다.
hist(mpg$total) #히스토그램 생성
#히스토그램을 그려서 연비 분포를 살펴본다.
#total연비의 평균과 중앙값이 약 20이다.
#total연비의 20~25사이에 해당하는 자동차 모델이 가장 많다.
#대부분 25이하이고 25를 넘기는 자동차는 많지 않다.

#20을 기준으로 놓고 20을 넘기면 합격, 못넘기면 불합격을 주어보자.

#2. 합격 판정 변수 만들기
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
#위 코드는 total이 20 이상히면 pass 미만이면 fail을 부여하는 test라는 변수를
#생성하겠다는 코드다
head(mpg)

#그럼 이제 합격 판정을 받은 자동차와 불합격 판정을 받은 자동차가 각각 몇대
#인지 알아보자

#3. 빈도표로 합격 판정 자동차 수 알아보기
table(mpg$test)
#fail 106, pass 128이다.

#4. 막대 그래프로 빈도 표현하기
#ggplot2 패키지 안에 있는 qplot으로 막대그래프를 그려본다
library(ggplot2)
qplot(mpg$test) #연비 합격 빈도 막대 그래프 생성

#중첩 조건문 활용하기
#이번에는 A, B, C 세 종류의 연비 등급으로 분류하는 변수를 만들어 본다.
#total이 30 이상이면 A, 20~29면 B, 20미만이면 C로 분류
#ifelse()안에 ifelse()를 넣는 식으로 조건문을 중첩해서 작성한다.

#total을 기준으로 A, B, C 등급 부여
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))

head(mpg) #쨘

#빈도표, 막대 그래프로 연비 등급 살펴보기
table(mpg$grade) #등급 빈도표 생성
qplot(mpg$grade) #등급 빈도 막대 그래프 생성

#원하는 만큼 범주 만들기
#ifelse를 중첩하면 원하는 만큼 더 범주를 늘릴 수 있다.
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))

head(mpg)
table(mpg$grade2) #새로운 등급 빈도표 생성
qplot(mpg$grade2) #새로운 등급 막대 그래프 생성

#분석 도전!
#ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 정보를 담은
#midwest라는 데이터가 들어 있다. 이를 이용하여 분석 문제 해결해보자

#Q1 ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러온 다음 데이터의
#특징을 파악하자

midwest <- as.data.frame(ggplot2::midwest)
summary(midwest)
dim(midwest) #28개열에 437개 행

#Q2 poptotal(전체 인구)변수를 total로, popasian(아시아 인구)변수를 asian으로
#수정해본다.

midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)
head(midwest)
View(midwest)
#Q3 total, asian 변수를 사용해서 '전체 인구 대비 아시아 인구 백분율'
#파생변수를 만들고, 히스토그램을 만들어 도시들이 어떻게 분포하는지 보세요
midwest$ratio <- (midwest$asian/midwest$total)*100
head(midwest)
hist(midwest$ratio)

#Q4 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large" 아니면
#"small"을 부여하는 파생변수를 만들어보자
mean(midwest$ratio)
midwest$test <- ifelse(midwest$ratio >= mean(midwest$ratio), "large", "small")
head(midwest)

#Q5 "large"와 "small"에 해당하는 지역이 얼마나 되는지 빈도표와 빈도 막대
#그래프를 만들어 확인해보자
table(midwest$test)
qplot(midwest$test)
#끝
