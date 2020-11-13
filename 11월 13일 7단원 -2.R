#11월 13일 7단원 -2 이상한 데이터를 찾아라! 이상치 제거하기.

#정상 범주에서 크게 벗어난 값을 이상치라고 한다.
#얘네가 포함되어 있으면 분석 결과가 왜곡될 수 있으므로 빼는 경우가 있다.

#이상치 제거하기 - 존재할 수 없는 값.

outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))

outlier
#이상치 확인하기
table(outlier$sex)
table(outlier$score)

#결측 처리하기
#변수에 이상치가 포함되어 있는 것을 확인했으니 이상치를 결측치로 변환한다.
#ifelse()를 이용해서 NA부여.

outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

#score변수의 아상치도 결측치로 변환한다. 
outlier$score <- ifelse(outlier$score == 6, NA, outlier$score)
outlier

#sex, score 변수 모두 이상치를 결측치로 변환했으니 분석할 때 결측치롤 제외하면
#된다.

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

#이상치 제거하기 - 극단적인 값.

#논리적으로 존재할 수 있지만 극단적으로 크거나 작은 값을 '극단치'라고 한다.
#어디까지 정상범위로 볼 것인지 정해야한다. 

#상자 그림으로 극단치 기준 정하기
#상자 그림에서는 중심에서 멀리 떨어진 극단치가 점으로 표현된다.
#먼저 mpg데이터의 hwy 변수로 상자 그림을 만들어 보자.
boxplot(mpg$hwy)
#18값에서 27지점이 25%~75%
#12에서 37을 벗어나는 지점이 극단치

boxplot(mpg$hwy)$stats #상자 그림 통계치 출력

#상자 그림을 이용해 정상 범위를 파악했으니 이 범위를 벗어난 값을 결측처리
mpg <- as.data.frame(ggplot2::mpg)
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

#극단치가 결측 처리 된 데이터를 얻었으니 마지막으로 결측치를 제외하고
#간단한 분석을 해본다.

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = TRUE))

#혼자서 해보기
#mpg 데이터를 이용해 분석 문제를 해결해 보세요.
#우선 mpg데이터를 불러와서 이상치를 만든다. drv(구동방식) 변수의 값은
#4(4륜구동), f(전륜구동), r(후륜구동) 세 종류로 되어 있습니다. 
#몇 개의 행에 존재할 수 없는 값 K를 할당 하도록 한다.

mpg <- as.data.frame(ggplot2::mpg) #데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k" #drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42) #cty 이상치 할당

#구동 방식별로 도시 연비가 다른지 알아보려고 한다. 분석을 하기전에
#우선 두 변수에 이상치가 있는지 확인해보려고 한다.

#Q1. drv에 이상치가 있는지 확인하세요. 이상치를 결측 처리한 후 이상치가
#사라졌는지 확인하세요.
table(mpg$drv)
mpg$drv <- ifelse(mpg$drv == "k", NA, mpg$drv)
table(mpg$drv) #k가 사라졌다.

#Q2. 상자 그림을 이용해 cty에 이상치가 있는지 확인하세요. 상자 그림의 통계치를
#이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어
#이상치가 사라졌는지 확인하세요.
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty) #이상치들이 사라졌다.

#Q3. 두 변수의 이상치를 결측 처리했으니 이제 분석할 차례다. 이상치를 제외한
#다음 drv별로 cty평균이 어떻게 다른지 알아보세요. 하나의 dplyr구문으로 만드세요
mpg %>% 
  group_by(drv) %>% 
  summarise(cty_mean = mean(cty, na.rm = TRUE))

#이렇게 하면 na값에서의 평균도 나와버린다.
#filter로 결측치를 제외한 값만 불러와야 하는 갑다.

mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))
