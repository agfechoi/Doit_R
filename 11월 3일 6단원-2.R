#11월 3일 6단원 자유자재로 데이터 가공하기

#6-2 조건에 맞는 데이터만 추출하기

library(dplyr)
exam <- data.frame(id = c(1,2,3,4,5,6),
                   class = c(1,1,1,1,2,2),
                   math = c(50, 60 ,45, 30, 25, 50),
                   english = c(98, 97, 86, 98, 80, 89),
                   science = c(50, 60, 78, 58, 65, 98))

#dplyr패키지의 filter()를 이용해 1반 학생들의 데이터만 추출
exam %>% filter(class == 1) #1반 학생들만 추출
exam %>% filter(class == 2)

exam %>% filter(class != 1) #1반 학생들이 아닌 학생들을 추출
#초과, 미만, 이상, 이하 조건걸기
exam %>% filter(math > 50) #수학 점수가 50점이 초과한경우
exam %>% filter(math < 50) #수학 점수가 50점 미만인 경우
exam %>% filter(english >=80) #영어 점수가 80점 이상인 경우

#여러 조건을 충족하는 행 추출하기
#1반이면서 수학 점수가 50점 이상인 경우
exam %>% filter(class == 1 & math >= 50)

#2반이면서 영어 점수가 80점 이상인 경우
exam %>% filter(class == 2 & english >= 80)

#여러조건 중 하나 이상 충족하는 행 추출하기
exam %>% filter(math >= 80 | english >= 90)
#수학점수가 80점 이상이거나 영어점수가 90점 이상인 행 추출

exam %>% filter(english < 80 | science < 60)
#영어점수가 80점 미만이거나 과학점수가 60점 미만인 행 추출

# %in%기호를 사용하면 코드를 간편하게 작성가능
# %in%기호와 c() 함수를 이용하여 조건 목록을 입력하면 된다.
# %in%기호는 변수의 값이 지정한 조건 목록에 해당하는지 확인하는 기능을 한다.

exam %>% filter(class %in% c(1,2,4))

#추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class ==1) #class가 1인 행 추출, class1에 할당
class2 <- exam %>% filter(class ==2) #동문

mean(class1$math) #1반 학생들의 수학점수 평균

#혼자서 해보기 mpg데이터를 사용해서!
#Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 한다.
#displ(배기량)이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의
#hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요

displ_low <- mpg %>% filter(displ <= 4)
displ_high <- mpg %>% filter(displ >= 5)
mean(displ_low$hwy) #25.96319
mean(displ_high$hwy) #18.52941
#배기량이 낮은 자동차가 고속도로 연비가 평균적으로 더 좋다.

#Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다.
#"audi"와 "toyota"중 어느 manufacturer(자동차제조회사)의 cty(도시 연비)가
#평균적으로 더 높은지 알아보세요

audi <- mpg %>% filter(manufacturer == "audi")
toyota <- mpg %>% filter(manufacturer == "toyota")
mean(audi$cty) # 17.61111
mean(toyota$cty) # 18.52941
#토요타의 도시 연비가 평균적으로 더 높다.

#Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려 한다.
#이 회사들의 데이터를 추출한 후 hwy 전체 평균을 구해보세요
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(mpg_new$hwy)

