#11월 19일 12단우너 인터랙티브 그래프

#인터랙티브 그래프란 마우스 움직임에 반응하여 실시간으로 형태가 변하는 그래프다.
#이걸 이용하면 그래프를 자유롭게 조작하면서 관심있는 부분을 자세히 볼 수 있다.
#그래프를 HTML로 저장하면 일반 사용자들도 웹 브라우저를 이용해 그래프를 조작
#할 수 있다.

#1 패키지 준비하기
install.packages("plotly")
library(plotly)

#2 ggplot2로 그래프 만들기
#ggplot2로 만든 그래프를 plotly패키지의 ggplotly()에 적용하면
#인터랙티브 그래프가 만들어진다. mpg를 이용해서 x축에 displ y축에 hwy넣어서
#산점도 만들고 산점도의 점을 drv별로 다른 색으로 표현하도록 col 파라미터에
#drv를 지정한다
library(ggplot2)

p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

#3 인터랙티브 그래프 만들기
ggplotly(p)
#산점도 점 위에 마우스 커서를 올리면 값이 나타난다.
#마우스를 드래그하면 특정 영역을 확대할 수 있다.
#그래프 위에서 더블클릭하면 원래로 돌아온다.

#4 html로 저장하기
#뷰어창에서 export - save as web page를 클릭하면 인터랙티브 그래프를
#html포맷으로 저장할 수 있다.

#5. 인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = 'dodge')

ggplotly(p)
