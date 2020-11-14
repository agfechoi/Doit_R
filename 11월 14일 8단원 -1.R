#11월 14일 8 - 2 산점도 - 변수 간 관계 표현하기

#데이터를 x축과 y축으로 표현한 그래프를 산점도라고 한다.

#1. 산점도 만들기
# ggplot2 패키지를 로드 한다.
library(ggplot2)

#배경설정하기
#X축은 displ, y축은 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

#그래프 추가하기
#산점도를 그리는 함수 geom_point()를 추가하겠다.
#배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
#산점도에 표시된 점들은 각각의 관측치를 의미한다.
#그래프를 보면 전반적으로 배기량이 큰 자동차일수록 고속도로 연비가 낮은
#경향이 있다는 것을 알 수 있다.

#축 범위를 조정하는 설정 추가하기
# +기호를 이용해 그래프 설정을 변경하는 코드를 추가할 수 있다.
#축 범위는 xlim() + ylim()을 이용해 지정할 수 있다.

#x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

#x축 범위 3~6, y축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) +geom_point() + xlim(3, 6) + ylim(10, 30)

#가독성 높이기
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#ggplot() vs qplot()
#7장에서 그래프를 만들 때, qplot()을 사용했다. qplot()은 기능은 많지 않지만
#문법이 간단하기 때문에 주로 전처리 단계에서 데이터를 빠르게 확인해 보는
#용도로 활용한다. 최종적으로 분석 결과를 보고하기 위해 그래프를 만들때는
#ggplot()을 사용한다. ggplot()은 다양한 그래프를 만들수도 있고
#색, 크기, 폰트 등 세부 요소들을 자유롭게 조정 할 수 있다.

#혼자서 해보기
#Q1. mpg데이터의 cty(도시 연비)와 hwy(고속도로 연비)간에 어떤 관계가 있는지
#알아보려고 한다. x축은 cty, y축은 hwy로 된 산점도를 만들어보세요.
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

#Q2. 미국 지역별 인구통계 정보를 담은 ggplot2패키지의 midwest데이터를 이용해
#전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 한다. x축은 
#poptotal(전체 인구), y축은 popasian(아시아인 인구)로 된 산점도를 만들어보세요
#전체 인구는 50만 명 이하, 아시아인 인구는 1만명 이하인 지역만 산점도에
#표시되게 설정하세요
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() + xlim(0, 500000) + ylim(0, 10000)
