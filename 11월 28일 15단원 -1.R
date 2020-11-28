#11월 28일 15단원 R 내장함수, 변수 타입과 데이터 구조.

#이 장에서는 R 내장 함수를 이용해 데이터를 추출하는 방법을 알아보겠습니다.
#글고 R에서 사용하는 변수의 타입과 데이터 구조들을 알아봅시다.

#행 번호로 행 추출하기

member[] #조건없이 전체 데이터 출력

#원하는 데이터를 추출하려면 대괄호에 조건을 지정하면 된다.
#대괄호 안 쉼표를 기준으로 왼쪽은 행에 대한 조건, 오른쪽은 열(변수)에 대한 조건
member[1,] #1행 추출
member[2,] #2행 추출

#이렇게 인덱스를 이용해 데이터를 추출하는 작업을 '인덱싱'이라고 한다.

#조건을 충족하는 행 추출하기
#쉼표 왼쪽에 조건을 입력하면 조건에 맞는 행을 추출할 수 있다.
member[member$team == 'TOR', ] #팀이 TOR인 행 추출


#대괄호 안에 &와 |을 사용해서 여러조건을 동시에 충족하거나 하나 이상 충족하는
#행을 추출할 수 있다. dplyr과 달리 내장 함수에서는 조건을 입력할때 변수명
#앞에 데이터프레임 이름을 반복해서 써줘야 한다.

#tor팀이면서 stuno가 1003이하인 선수
member[member$team == 'TOR' & member$Stuno < 1003, ]

#열 번호로 변수 추출하기
member[,1] #첫 번째 열 추출
member[,2] #두 번째 열 추출
member[,3]
member[,4]
#변수를 하나만 추출할 경우 추출된 데이터는 데이터 프레임이 아니라 연속 값이 된다.
#따라서 출력하면 연속 값으로 구성된 변수를 출력할 때처럼 가로로 나열된다.
#2개 이상의 변수를 추출하면 데이터 프레임의 형태가 된다. 반면 dplyr패키지의
#select는 변수가 하나만 있어도 데이터 프레임 형태로 추출한다.

#변수명으로 변수 추출하기
#변수가 여러개면 위처럼 숫자인덱스로 추출하기 어렵다. 그러므로 이름으로 추출한다
#쉼표 오른쪽에 따옴표와 함께 변수명을 입력하면 된다.
member[, "team"]
member[, "Birth"]


#c()를 이용하면 여러 변수를 동시에 추출할 수 있다.

member[, c("Stuno", "Nmae", "Birth")]

#행, 변수 동시에 추출하기
#행 변수 모두 인덱스
member[1,3]
member[3,1]

#행 인덱스, 열 변수명
member[1, "team"]

#행 부등호 조건, 열 변수명
member[member$Stuno < 1003, "team"]

#행 부등호 조건, 열 변수명
member[member$Stuno <1002, c("Birth", "team")]

#혼자서 해보기
#dplyr패키지 함수를 이용해서 compact와 suv차종의 도시 및 고속도로 통합 연비
#평균을 구하는 코드를 보고 R내장함수로 똑같이 해보세요

#dplyr버전
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
mpg %>% 
  mutate(tot = (cty+hwy)/2) %>% 
  filter(class == "compact" | class == "suv") %>% 
  group_by(class) %>% 
  summarise(mean_tot = mean(tot))

#R내장함수 버전
mpg <- as.data.frame(ggplot2::mpg)
mpg$tot <- (mpg$cty+mpg$hwy)/2
aggregate(data=mpg[mpg$class == "compact" | mpg$class == "suv",], tot~class, mean)
