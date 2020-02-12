# Meeting 13 - all things regression (eventually)

data(iris)
head(iris)

library(ggplot2)
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species))

covar <-
  sum( (iris$Sepal.Length - mean(iris$Sepal.Length)) * 
         (iris$Sepal.Width - mean(iris$Sepal.Width)) / (nrow(iris)-1))
covar

var(x = 10*iris$Sepal.Length, y = iris$Sepal.Width)



## Correlation values
cor(iris$Sepal.Length, iris$Sepal.Width)
cor.test(iris$Sepal.Length, iris$Sepal.Width)

## robust correlation
# for pearson, should be linear and bi-variate normal

# Spearman's Rank Correlation
# Kendall's Rank Correlation
cor.test(iris$Sepal.Length, iris$Sepal.Width, method = "kendall")
cor.test(iris$Sepal.Length, iris$Sepal.Width, method = "spearman")


# Linear regression
# x -> y
flr_beetle <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter8/Data/nelson.csv")
flr_beetle

ggplot() +
  geom_point(data = flr_beetle, aes(x = HUMIDITY, y = WEIGHTLOSS))

cor(flr_beetle$HUMIDITY, flr_beetle$WEIGHTLOSS)

# Fit a linear regression model
flr_beetle_lm <- lm(data = flr_beetle, WEIGHTLOSS ~ HUMIDITY)
summary(flr_beetle_lm)

# diagnostics
plot(flr_beetle_lm)

flr_beetle_new <- flr_beetle[-1,]


ggplot(data = flr_beetle, aes(x = HUMIDITY, y = WEIGHTLOSS)) +
  geom_point() +
  geom_smooth(method = "lm")


# multiple regression
bird_frag <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter9/Data/loyn.csv")
summary(bird_frag)

install.packages("GGally")
library(GGally)

ggpairs(bird_frag)

# try to transform our data
bird_frag_transform <- bird_frag

bird_frag_transform$AREA <- log10(bird_frag_transform$AREA)
bird_frag_transform$DIST <- log10(bird_frag_transform$DIST)
bird_frag_transform$LDIST <- log10(bird_frag_transform$LDIST)

ggpairs(bird_frag_transform)


bird_frag_lm <- lm(data = bird_frag, ABUND ~ log10(AREA) + YR.ISOL + log10(DIST) +
                     log10(LDIST) + GRAZE + ALT)
plot(bird_frag_lm)

summary(bird_frag_lm)


summary(lm(data = bird_frag, ABUND ~ log10(AREA) *log10(DIST)))
        