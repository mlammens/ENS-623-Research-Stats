# Meeting 10

# Venn diagrams

install.packages("VennDiagram")
library(VennDiagram)


draw.single.venn(area = 0.23, category = "Blue M&M", fill = "blue", alpha = 0.5)

# prob of blue or red
grid.newpage()
draw.pairwise.venn(area1 = 0.23, area2 = 0.13, cross.area = 0,
                   category = c("Blue M&M", "Red M&M"),
                   fill = c("blue", "red"), alpha = c(0.5, 0.5))

# Add a bunch of peanut and almond m&ms
# Prob blue and peanut M&M
grid.newpage()
draw.pairwise.venn(area1 = 0.23, area2 = 0.33, cross.area = 0.0759,
                   category = c("Blue M&M", "Peanut"),
                   fill = c("blue", "yellow"), alpha = c(0.5, 0.5))

# End probability 


# Begin distributions

## Uncertainty in biology

# - process uncertainty - imperfect knowledge - USUALLY INTERESTED IN THIS
# - observation uncertainty - inaccuracies - MINIMIZE THIS AS MUCH AS POSSIBLE

# We try is understand process uncertainty using probability distributions

# Iris
library(ggplot2)
ggplot() +
  geom_histogram(data = iris, aes(x = Petal.Length, y = ..density.., 
                                  fill = Species)) +
  facet_grid(Species ~ . ) +
  geom_density(data = iris, aes(x = Petal.Length, colour = Species),
               size = 2) +
  theme_bw()


# Important distributions

## Bernoulli

# P(x) = p if x = 1 and (1-p) if x = 0

## Binomial distribution

## can be thought of as a lot of beroulli's combined
?rbinom
new_data <- rbinom(n = 100, size = 100, prob = 0.7)
new_data

ggplot() +
  geom_histogram(data = NULL,
                 aes(x = new_data, y = ..density..,
                     binwidth = 1)) +
  theme_bw()

# questions - what is the number of successess, x, in N trials,
# where the probability of success is p


## Negative Binomial

# questions - what is the number of trials, N, needed to reach the xth success,
# if the probability of success is p

?rnbinom
new_data <- rnbinom(n = 100, size = 100, prob = 0.5)
ggplot() +
  geom_histogram(data = NULL,
                 aes(x = new_data, y = ..density..,
                     binwidth = 1)) +
  theme_bw()

## Poisson distribution
pois_data <- rpois(1000, lambda = 3.5)
pois_data

ggplot() +
  geom_histogram(data = NULL,
                 aes(x = pois_data, 
                     binwidth = 1)) +
  theme_bw()


max(rpois(500000, lambda = 3))


# question - how many observations do you make of a thing that has a rate
# lambda

# ***

# Normal Distribution

?rnorm
normal_rvs <- rnorm(n = 1000, mean = 0, sd = 1)
ggplot() +
  geom_histogram(data = NULL,
                 aes(x = normal_rvs)) +
  theme_bw()


# Other distributions
# - Standard Normal
# - Student's t distribution
# - Chi^2 distribution
# - F distribution


