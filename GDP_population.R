library(tidyverse) #loading the tidyverse package

#the next line reads in the gapminder_1997.csv file
gapminder_1997 <- read_csv("gapminder_1997.csv")
read_csv(file = "gapminder_1997.csv")
Sys.Date() #print the date and time
getwd() #prints the current working directory
sum(5,6)

?round
round(3.1415,3)

round(x =3.1415, digits =2) #the number after decimal point

result <- 2+2

result

name <- "Sarah"
name

name <- "B"
name

number1 <- 3
number1

################################Plotting######################################
ggplot(data=gapminder_1997) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) + 
  labs(x = "GDP Per Capital", y = "Life Expectancy", size = "Population (in millions)", 
       title = "Do people in wealthy countries live longer?") +
  geom_point() +
  scale_color_brewer(palette = "Spectral")

#Encode each continent as different shapes
#instead of colors
ggplot(data=gapminder_1997) + aes(x = gdpPercap) + labs(x = "GDP Per Capital") +
  aes(y = lifeExp) + labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?")+
  aes(shape = continent)

?scale_color_brewer
??scale_color_shape
