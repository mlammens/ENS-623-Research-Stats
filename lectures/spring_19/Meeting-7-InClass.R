# R script for Meeting 7

3+3 * 5

# Some misc file commands
getwd()
getwd

file.create("foo.txt")

# Variables

# Numeric
bar

# Vector - 1 dimensional array of values of the same type
bar2 <- c(bar, foo)

# Factors - catagories

# Data frames - a 2-dimensional structure to store our datasets in

# Matrices - 2-dimensional structure where every value is the same type
# (e.g., everything is a number)
my_mat <- matrix(data = 1:9, nrow = 3, ncol = 3)
my_mat

# Challenge - redo the matrix command, but with "byrow = TRUE" 
# tell me what it did
matrix(data = 1:9, nrow = 3, ncol = 3, byrow = TRUE)
?matrix

# Arrays - 3+ dimensions

# Lists - list contains any type of object as a list of elements

# Practice with variables

my_var <- 8
my_var2 <- 10

my_var + my_var2

my_var_tot <- my_var + my_var2
my_var_tot

my_var2 <- 3

my_var_tot


v1 <- c(10, 2, 8, 7, 11, 15)
v1

v2 <- 1:10
v2
v3 <- seq(from = 1, to = 10)
v3

pets <- c("cat", "dog", "rabbit", "lion")

# Challenge
# look up the help for the `seq` fucntion
# 1. make a vector from 0 to 100, by steps of 5
# 2. make a vector that uses the length.out argument

# 1
seq(from = 0, to = 100, by = 5)

# 2
seq(from = 1, to = 100, length.out = 20)


# Explore variable elements

pets
pets[1]
pets(1)

pets[2]
pets[4]
pets[-1] # removes first element

# print 2nd and 4th elements
pets[c(2,4)]
pets[c(-1,-3)]

# add a new pet
new_pet <- "civet"
pets <- c(pets, new_pet)

# Matrices (again)
my_mat

my_mat[1]
my_mat[2]
my_mat[4]

# use row, column notation
my_mat[2,3]

# first two rows of the third column
my_mat[1:2, 3]

# first and third row of the third column
my_mat[-2, 3]
my_mat[c(1,3), 3]

# if I want all emelents in a row for the 2nd column
my_mat[ , 2]

# if I want all elements in a column for the 2nd row
my_mat[2, ]

my_mat

# Using internal functions with matrices
set.seed(1)
mat1 <- matrix(data = runif(50), nrow = 10, byrow = TRUE)
mat1

mean(mat1)
sd(mat1)

rowMeans(mat1)

# Mean of columns
colMeans(mat1)

# Generic way to do this, called apply
apply(X = mat1, MARGIN = 1, FUN = mean)

# get row std
apply(X = mat1, MARGIN = 1, FUN = sd)
apply(X = mat1, MARGIN = 1, FUN = max)
apply(X = mat1, MARGIN = 2, FUN = sd)


# Data frame
data(iris)

# Peek at first six lines of iris data
head(iris)

# last six lines
tail(iris)

# summarize our data
summary(iris)

iris[6,3]

iris[6, "Petal.Length"]
iris$Petal.Length[6]

iris$Petal.Length[1:50]

# Reading in your own data
gastropod <- read.csv(file.choose())
gastropod <- read.csv("/Users/EdMedia/Downloads/ward.csv")

summary(gastropod)

boxplot(gastropod$EGGS~gastropod$ZONE)
