#11월 26일 13단원 통계 분석 기법을 이용한 가설 검정

#13-2
#t 검정 - 두 집단의 평균 비교

#t검정은 두 집단의 평균에 통계적으로 유의한 차이가 있는지 알아볼 때 사용하는
#통계 분석 기법입니다.

#compact 자동차와 suv자동차의 도시 연비 t 검정

#ggplot2 패키지의 mpg데이터를 이용해 t검정을 수행하는 방법을 알아보자

#1. 먼저 mpg데이터를 불러와 class, cty변수만 남긴뒤 class 변수가
#compact인 자동차와 suv인 자동차를 추출

mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)

table(mpg_diff$class)

#t.test()를 이용해 t검정을 하자
#mpg_diff를 데이터로 지정하고 ~를 이용해 비교값인 cty변수와 class변수를 지정
#t검정은 비교하는 집단의 분산이 같은지 여부에 따라 적용하는 공식이 다르다
#여기서는 집단간 분산이 같다고 가정하고 var.equal에 t를 지정한다.

t.test(data = mpg_diff, cty~class, var.equal = TRUE)

#P-VLAUE가 유의확률이다. 일반적으로 유의확률 5%를 판단 기준으로 삼고
#P밸류가 0.05미만이면 집단 간 차이가 통계적으로 유의하다고 해석한다.
#이 경우 P값이 0.05보다 작으므로 집단간 차이가 통계적으로 유의하다.
#COMPACT와 SUV간 평균 도시 연비 차이가 통계적으로 유의하다

#SAMPLE ESTIMATES부분을 보면 각 집단의 CTY평균이 나와있다. COMPACT는 20
#SUV는 13이므로 COMPACT의 도시연비가 더 크다고 볼 수 있다.

#2. 일반 휘발유와 고급 휘발유의 도시 연비 T검정
#이번에는 일반 휘발유를 사용하는 자동차와 고급 휘발유를 사용하는
#자동차 간 도시 연비 차이가 통계적으로 유의한지 알아보겠다.
#두 연료를 사용하는 자동차를 추출한 후 T검정을 실시하겠다.

mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p")) #r : regular, p:premium

table(mpg_diff2$fl)

t.test(data = mpg_diff2, cty ~ fl, var.equal = TRUE)

#분석결과 p벨류는 0.05보다 크므로 통계적으로 둘의 차이가 유의미하지 않은 것이다.
#우연에 의해 이런 차이가 발생할 확률이 28퍼센트

#출력결과의 sample estimates 부분을 보면 고급 휘발유 자동차의 도시 연비
#평균이 0.6정도 높지만 이런 정도의 차이는 우연히 발생했을 가능성이 크다고 
#해석하는 것이다.