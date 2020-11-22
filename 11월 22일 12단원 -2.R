#11월 19일 12 -2 dygraphs 패키지로 인터랙티브 시계열 그래프 만들기

#시간에 따른 데이터의 변화를 표현한 인터랙티브 시계열 그래프를 만들어보자
#인터랙티브 시계열 그래프를 이용하면 마우스로 시간 축을 움직이면서
#시간에 따라 데이터가 어떻게 변하는지 알 수 있다.

#인터랙티브 시계열 그래프 만들기
#dygrpahs 패키지로 인터랙티브 시계열 그래프를 만들자
#ggplot2패키지에 내장된 economics 데이터를 이용해 그래프를 만들자
#economics는 실업자 수 저축률 등 1967~ 2015년 미국의 월별 경제 지표를 담았다.

install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
head(economics)

#dygraphs 패키지를 이용해 인터랙티브 시계열 그래프를 만드려면 데이터가 
#시간 순서속성을 지니는 xts 데이터 타입으로 되어 있어야 한다.
#xts()를 이용해 economics 데이터의 unemploy를 xts 타입으로 변경한다

library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

#인터랙티브 시계열 그래프 만들기
dygraph(eco)
#선위에 마우스 커서를 올리면 그래프 오른쪽 위에 날짜와 실업자 수가 표시된다.
#들그하면 특정 기간만 확대할 수 있고 더블클릭하면  더블클릭하면 다시 원래
#대로 되돌아온다.

#dygraphs에 %>%를 통해 dyRangeSelector()를 추가하면 그래프 아래에
#날짜 범위 선택 기능이 추가된다. 버튼을 움직여 특정 기간만 선택 가능
#범위를 정한뒤 좌우로 움직이면 시간에 따라 데이터가 어떻게 변하는지
#알 수 있다.

dygraph(eco) %>% dyRangeSelector()

#여러 값 표현하기
#economics 데이터의 unemploy와 psavert를 그래프에 함께 표현해보자
#먼저 unemploy변수와 psavert 변수를 xts타입으로 바꾼다.
#unemploy변수는 값이 1000명 단위로 되어 있는데 psavert와 비교해 보기 쉽도록
#1000으로 나눠 100만명 단위로 수정해준다.

#저축률
eco_a <- xts(economics$psavert, order.by = economics$date)

#실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

#앞에서 만든 두 데이터를 cbind()로 가로로 묶고 변수명을 알기 쉽도록 수정한다.
eco2 <- cbind(eco_a, eco_b)
colnames(eco2) <- c("psavert", "unemploy") #변수명 바꾸기

head(eco2)

#데이터가 준비되었으니 dygraph를 이용해서 그린다
dygraph(eco2) %>% dyRangeSelector()
