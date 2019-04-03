# Meeting 8 - Programming and Data Vis

# Functions

## What is a function?
# - set of rules or steps
# - you give it some input (or sometimes not)
# - it gives you some output

## Why a function?
# - to get things done faster
# - mathy things
# - logic things
# - things that you need to repeat

# Silly function
hello_fun <- function(){ print("Hello, Hi!")}
hello_fun()

# Function to convert from Fahrenheit to Kelvin
fahr_to_kelvin <- function(temp){
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}

fahr_to_kelvin(32)
fahr_to_kelvin(temp = 32)
fahr_to_kelvin(temp = 48)

# Effects of return
fahr_to_kelvin <- function(temp){
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  #return(kelvin)
}
fahr_to_kelvin(32)

# Convert from Kelvin to Celsius
kelvin_to_celsius <- function(temp){
  celsius <- temp - 273.15
  return(celsius)
}
kelvin_to_celsius(0)

# Challenge
# Write a function that conversts from Fahrenheit to Celsius,
# using the functions we just wrote
fahr_to_celsius <- function(temp_fahr){
  kelvin <- fahr_to_kelvin(temp = temp_fahr)
  celsius <- kelvin_to_celsius(temp = kelvin)
  return(celsius)
}

fahr_to_celsius(32)

# for loops

## let's make some data
set.seed(8)
temp_data <- runif(n = 20, min = -5, max = 5) + 45
temp_data

# Aside - resetting your seed
rm(.Random.seed, envir = globalenv())

# Iteration 1
for( x in temp_data){
  fahr_to_kelvin(x)
}

# Iteration 2 - by element
for( x in temp_data){
  print(x)
  print(fahr_to_kelvin(x))
}

# Iteration 3 - by element location
for( x in 1:length(temp_data)){
  print(x)
  print(fahr_to_kelvin(temp_data[x]))
}

# Iteration 4 - by element location with output in a new vector
temp_data_kelvin <- vector()
for( x in 1:length(temp_data)){
  temp_data_kelvin[x] <- fahr_to_kelvin(temp_data[x])
}

# Iteration 4b
temp_data_kelvin <- vector()
for( x in 1:length(temp_data)){
  print("before fahr_to_kelvin function")
  print(temp_data_kelvin)
  temp_data_kelvin <- c(temp_data_kelvin, fahr_to_kelvin(temp_data[x]))
  print("after function")
  print(temp_data_kelvin)
}


# Conditionals

# statements that allow you to **control the flow** of your code
# and to make choices

## if / else
if(TRUE){
  print("It's true!")
}

## TRUE FALSE values
TRUE

FALSE

20 == 20
x = 20
y = 20
x == y
x = y

x == y
x = y ## NO!!!!

x = 20
y = 5
x > 5
x < 5

x = 20
y = 20
x > y
x < y
x >= y
x <= y

!TRUE
!FALSE
!(20 > 40)

# Challenge
x <- TRUE
y <- FALSE

x & y

x | y

xy <- c(x,y)

any(xy)

all(xy)

## Essential of the if/else statement
num <- 101
if(num > 100){
  print("greater than 100")
} else {
  print("not greater than 100")
}

num <- 37
if(num > 100){
  print("greater than 100")
}

# We can also cascade if/else statements
num <- -5
if( num > 0){
  print(1)
} else if (num == 0){
  print(0)
} else {
  print(-1)
}

# Challenge
# make the above a function that takes a value and returns whether
# it is positive, negative, or 0
# hint: replace print with return
neg_pos_id <- function(num){
  if( num > 0){
    return("positive")
  } else if (num == 0){
    return("zero")
  } else {
    return("negative")
  }
}
neg_pos_id(-5)
neg_pos_id(10)

# Data visualization

## Iris data set
data(iris)
summary(iris)

## Review navigate a data frame
# Get a column of data
iris$Sepal.Length
# Get some elements of a column of data
iris$Sepal.Length[10:37]
iris[10:37, 1]

names(iris)
iris[10:37, c(1, 3)]

iris["Sepal.Length"]

## add some habitat data
iris_habitat <- 
  data.frame(Species = c("setosa", "versicolor", "virginica"),
             Habitat = c("forest", "wetland", "meadow") )

iris_full <- merge(x = iris, y = iris_habitat, by = "Species")
head(iris_full)

# Visualizing the measurements of a single variable
plot(sort(iris_full$Sepal.Length))

hist(iris_full$Sepal.Length)

# Change number of bins
hist(iris_full$Sepal.Length, breaks = 30)

hist(iris_full$Petal.Length, breaks = 30)

# Two variables
plot(x = iris_full$Sepal.Length, y = iris_full$Petal.Length)

plot(x = iris_full$Species, y = iris_full$Petal.Length)
boxplot(iris_full$Petal.Length~iris_full$Species)

## Let's get a package called ggplot2
install.packages("ggplot2")
library(ggplot2)

# first ggplot
ggplot() +
  geom_point(data = iris_full, aes( x = Sepal.Length, y = Petal.Length))

# second ggplot
ggplot(data = iris_full, 
       aes( x = Sepal.Length, y = Petal.Length,
            colour = Species, shape = Habitat)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~Species) +
  theme_bw()

ggplot(data = iris_full,
       aes(x = Petal.Length, fill = Species)) +
  geom_histogram(aes(y = ..density..), position = "dodge") +
  geom_density(alpha = 0.3) +
  theme_bw()

ggplot(data = iris_full,
       aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot() +
  theme_classic()

