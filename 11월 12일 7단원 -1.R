#11월 12일 7단원 -1 데이터 정제 - 빠진 데이터, 이상한 데이터 제거하기.


#1. 빠진 데이터를 찾아라! - 결측치 정제
#결측치는 누락된 값. 비어있는 값
#1-1결측치 제거

#R에서 결축치는 NA다.

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df
#문자로 구성된 변수는 NA가 <>에 감싸진 형태로 출력된다.

#1-2. 결측치 확인하기
#is.na()을 사용하면 데이터에 결측치가 들어있는지 확인 가능
#결측치가 있으면 true, 없으면 false가 나온다.

is.na(df)

#is.na를 table에 적용하면 데이터에 결측치가 총 몇개 있는지 출력한다.
table(is.na(df))
#결측치가 데이터에 2개 있다는걸 알 수 있다.

#결측치 제거하려면 데이터 전체가 아니라 구체적으로 어떤 변수에 결측치가 있는지
#알아야한다. table(is.na())에 변수명을 지정하면 해당 변수에 결측치가 몇 개 있는
#지 알 수 있다. 
table(is.na(df$sex))
table(is.na(df$score))
#아래 코드 출력 결과를 보면 sex와 score에 각각 결측치가 1개씩 있다는것을 
#알 수 있다.

#결측치가 포함된 데이터를 함수에 적용하면 정상적 연산이 안된다.
mean(df$score)
sum(df$score)

#결측치 있는 행 제거하기.
#filter를 사용하면 제거 가능하다.
library(dplyr)
df %>% filter(is.na(score)) #score가 NA인 데이터만 출력

#is.na()앞에 아니다를 의미하는 기호 !를 붙이면 결측치가 아니 값을 의미
#이걸 filter에 적용하면 결측치 제외한 행을 출력해준다.

df %>% filter(!is.na(score))

#이렇게 추출한 데이터로 데이터 프레임을 만들면 결측치가 없는 데이터가 된다.
#결측치가 제거 되었으니 수치 연산 함수도 잘 먹힌다.

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

#여러 변수 동시에 결측치 없는 데이터 추출하기
#filter()에 & 기호를 이용해서 조건을 나열하면 여러 변수에 모두 결측치가
#없는 행을 추출할 수 있다.

df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

#결측치가 하나라도 있으면 제거하기.
#앞에서는 filter()에 일일이 변수를 지정해 결측치가 있는 행을 제거하도록 했지만
#na.omit()을 이용하면 변수 지정없이 결측치가 있는 행을 한번에 날릴 수 있다.

df_nomiss2 <- na.omit(df)
df_nomiss2
#편리하지만 분석에 필요한 행까지 모두 날릴 수 있으므로 filter로 날리는게
#안전한 편이다.

#함수의 결측치 제외 기능 이용하기.
#na.rm을 true로 설정하면 결측치를 제외하고 함수를 적용한다.
#하지만 모든 함수가 na.rm을 지원하는 것은 아니다. 이 경우 filter 쓰는 수밖에

mean(df$score, na.rm = TRUE)
sum(df$score, na.rm = TRUE)
#결측치를 제외하고 결과들을 산출했다.

exam[c(1,3,5), "math"] <- NA #1,3,5행의 math에 NA할당

#exam의 math는 결측치를 포함하고 있기 때문에 summarise로 평균을 산출하면
#NA가 출력된다.
exam %>% summarise(mean_math = mean(math))

#이제 mean에 na.rm =T를 적용해서 결측치 제외한 평균을 구해보자
exam %>% summarise(mean_math = mean(math, na.rm = TRUE))

#mean말고 다른 수치 연산 함수들도 na.rm을 지원한다.
exam %>% summarise(mean_math = mean(math, na.rm = TRUE),
                   sum_math = sum(math, na.rm = TRUE),
                   median_math = median(math, na.rm = TRUE))

#결측치 대체하기.
#결측치가 너무 많은 데이터에서 결측치를 모두 다 제거해버리면 너무 많은 데이터
#들이 다 없어져 버리는데 이건 좀 별로 안좋다. 그러므로 결측치를 대체 하는
#방법들을 사용하는데 이를 결측치 대체법이라고 한다.
#보통 평균이나 최빈값같은 대표값을 넣어 대체한다.

#평균값으로 결측치 대체하기.
mean(exam$math, na.rm = TRUE) #결측치 제외한 math 평균 산출

#평균값을 구했으니 ifelse()를 이용해서 NA값을 평균값으로 대체
exam$math <- ifelse(is.na(exam$math), 47, exam$math) #math가 NA면 47로 대체
table(is.na(exam$math)) #결측치 빈도표를 보면 모두 들어간걸 확인 가능

exam
#이제 일반 수치연산 함수 사용 가능하다.
mean(exam$math)

#혼자서 해보기
#결측치가 들어있는 mpg 데이터를 이용해 분석 문제를 해결해 보세요.
#mpg데이터 원본에는 결측치가 없다. 우선 mpg데이터를 불러와 일부러
#몇 개의 값을 결측치로 만든다. 아래 코드를 실행하면 다섯 행의 hwy변수에
#NA가 할당된다.

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA #NA할당

#위 코드에서 대괄호[] 안에 쉼표와 함께 입력된 숫자는 각각의 값이
#어떤 행렬에 위치하는지 의미하는 인덱스 값이다. 

#Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알아보려고 한다.
#분석을 하기전에 우선 두 변수에 결측치가 있는지 확인해야 한다.
#drv 변수와 hwy변수에 결측치가 몇개 있는지 알아보자.
table(is.na(mpg$drv)) #drv 변수열에는 결측치가 없다.
table(is.na(mpg$hwy)) #hwy 변수열에는 결측치가 5개 있다.


head(mpg)
#Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동 방식의 hwy
#평균이 높은지 알아보자. dplyr구문으로 만들어야한다.
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
