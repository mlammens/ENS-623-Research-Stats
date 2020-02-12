# Meeting 11 - CLT and Hypotheses

stdnorm_samp <- data.frame( samps = rnorm(n = 1000, mean = 0, sd = 1) )
mean(stdnorm_samp$samps)
sd(stdnorm_samp$samps)

library(ggplot2)

ggplot(data = stdnorm_samp, aes(x = samps)) +
  geom_histogram(aes(y = ..density..)) +
  geom_density(colour = "red", size = 2) +
  stat_function(fun = dnorm, colour = "blue", alpha = 0.6, size =2)


# Quantiles
?qnorm
qnorm(p = 0.025)
qnorm(p = 0.975)
qnorm(p = 0.5)

pnorm(q = -2)
pnorm(q = 1.96)
1 - pnorm(q = 1.96)


# Visualization of quantiles
ggplot(data = stdnorm_samp, aes(x = samps)) +
  coord_cartesian(xlim = c(-5,5), ylim = c(0, 0.4)) +
  stat_function(fun = dnorm, colour = "blue", size =2) +
  geom_vline(xintercept = c(-1.96, 1.96), size = 2) +
  theme_bw()


# Central Limit Theorem

## Challenge
# - take 100 samples of 10 observations from a standard normal dist
# - calculate the mean of each sample
# - plot the histogram of the means
samp_means <- c()
for(x in 1:100){
  samp_means <- c(samp_means, mean(rnorm(100)))
}
hist(samp_means)

# - after above, do the same, but increase the number of samples

# - after above, do the same, but increase the number of observations

ggplot(data = NULL) +
  geom_histogram(aes(x = rpois(100, lambda = 2)))

samp_means_pois <- c()
for(x in 1:100){
  samp_means_pois <- c(samp_means_pois,
                       mean(rpois(100, lambda = 2)))
}
hist(samp_means_pois)


# t_0.025
qt(p = 0.025, df = 99)
qt(p = 0.025, df = 9)

?qt

# mussles in intertidal
gastro <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter6/Data/ward.csv")

summary(gastro)

ggplot() +
  geom_boxplot(data = gastro, aes(x = ZONE, y = EGGS)) +
  theme_bw()


t.test(data = gastro, EGGS ~ ZONE, var.equal = TRUE)
pt(q = -5.3899, df = 77)

install.packages("dplyr")
library("dplyr")

gastro %>%
  group_by(ZONE) %>%
  summarise(Mean = mean(EGGS), Var = var(EGGS))
