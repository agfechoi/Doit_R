#11월 29일 15단원 -2 변수 타입

#변수에는 여러가지 타입이 있다.
#연속 변수와 범주 변수로 나뉜다.

#1. 연속변수 - numeric 타입
#연속 변수는 키, 몸무게, 소득처럼 연속적이고 크기를 의미하는 값을
#구성된 변수이다. 숫자가 크기를 지니기 때문에 더하기, 빼기, 평균 구하기 등
#산술을 할 수 있다. 연속변수는 양적 변수라고도 한다. R에서 연속 변수는
#Numeric으로 표현된다.

#2. 범주변수 -Factor 타입
#범주 변수는 값이 대상을 분류하는 의미를 지니는 변수다. 숫자가 크기를 의미하지
#않기 때문에 더하거나 평균을 구하는 등 산술을 할 수 없다. 범주 변수는
#숫자가 대상을 지칭하는 이름과 같은 역할을 하기 때문에 명복변수라고도 한다.
#R에서 범주변수는 factor라고 표현된다.

#변수 타입 간 차이 알아보기
#1. 먼저 몇개의 숫자로 구성된 numeric타입 변수와 factor타입 변수를 생성한다.
#factor타입 변수는 factor()를 이용해 만들 수 있다.

var1 <- c(1,2,3,1,2) #numeric 변수 생성
var2 <- factor(c(1,2,3,1,2)) #factor 변수 생성

#2. 생성한 두 변수를 출력해 어떤 차이가 있는지 살펴보자

var1
var2
#var1을 실행하면 변수에 들어있는 값들이 한주로 나오지만
#var2를 실행하면 두줄이 출력된다. 첫줄에는 var1처럼 변수에 들어있는 값들이 출력
#둘째줄에는 값이 어떤 범주로 구성되있는지 의미하는 levels가 1,2,3나온다.
#이처럼 factor 변수는 값을 지니는 동시에 값의 범주를 의미하는 levels정보를 지닌다.

#3. factor 변수는 연산이 안된다.
var1 + 2 #가능
var2 + 2 #불가

#4. 변수 타입 확인하기
#class()를 이용하면 변수의 타입을 알수 있다.
class(var1)
class(var2)

#5.factor 변수의 구성 범주 확인하기
#levels를 이용하면 factor 변수의 값이 어떤 범주로 구성되는지 알 수 있다.
levels(var1) #numeric이라 null
levels(var2) #factor라 잘 나옴

#6. 문자로 구성된 factor변수
var3 <- c("a", "b", "b", "c")
var4 <- factor(c("a", "b", "b", "c"))

var3
var4

class(var3) #character
class(var4) #factor

#7. 함수마다 적용 가능한 변수 타입이 다르다.
#mean()함수와 같은건 numeric에는 되지만 factor변수에는 불가하다
mean(var1)
mean(var2)


#변수 타입 바꾸기
#함수를 실행했는데 예상치 못한 결과가 나왔다면 변수가 함수에 적용가능한지 봐야한다.
#타입이 맞지 않다면 함수에 적용할 수 있도록 변환한 후 코드를 다시 실행시켜본다.

#1. 변수 타입을 변환하는 방법 앞에서 생성한 var2는 숫자로 구성되어 있지만
#factor변수였기 때문에 mean()이 불가능 했다. 이 경우 변수 타입을 numeric으로
#바꿔줘야 한다. as.numeric()을 이용하면 변수 타입을 numeric으로 변환할 수 있다.
#변환 후 mean()을 적용하면 결과가 출력된다.

var2 <- as.numeric(var2) #numeric 타입으로 변환
mean(var2) #함수 재적용

#2. numeric 타입으로 변환했기 때문에 class()에 적용하면 numeric이 출력된다.
class(var2)
levels(var2) #factor가 더이상 아니므로 null이 나옴

#이러한 변수 타입을 바꿔주는 애들이 몇몇 있다.
#as. numeric, as.factor, as.character, as.Date, as.data.frame

#혼자서 해보기
#mpg데이터의 drv 변수는 자동차의 구동 방식을 나타낸다. mpg 데이터를 이용해서
#아래 문제를 해결해보세요

#Q1. drv변수의 타입을 확인해보세요
mpg <- as.data.frame(ggplot2::mpg)
class(mpg$drv) #character다

#Q2. drv변수를 as.factor()를 이용해 factor타입으로 변환한 후 다시 타입을 확인
mpg$drv <- as.factor(mpg$drv)
class(mpg$drv)

#Q3. drv가 어떤 범주로 구성되는지 확인해 보세요.
levels(mpg$drv)
