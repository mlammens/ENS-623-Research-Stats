# Meeting 14 - ANCOVA, GLM, Frequencies

# Multiple linear regression - C3 plants
c3_plants <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter9/Data/paruelo.csv")
summary(c3_plants)

library(ggplot2)
#install.packages("GGally")
library(GGally)

ggpairs(c3_plants)

# Scale transform lat and lon
c3_plants$LAT <- as.numeric(scale(c3_plants$LAT, scale = FALSE))
c3_plants$LONG <- as.numeric(scale(c3_plants$LONG, scale = FALSE))

c3_plants$C3_LOG <- log10(c3_plants$C3 + 0.1)

ggpairs(c3_plants)


# Run a regression
c3_plants_lm <- lm(data = c3_plants, C3_LOG ~ LAT + LONG)
summary(c3_plants_lm)

c3_plants_lm_int <- lm(data = c3_plants, C3_LOG ~ LAT * LONG)
summary(c3_plants_lm_int)

# Model selection by AIC
AIC(c3_plants_lm)
AIC(c3_plants_lm_int)

# Model selection by "reduction in residual squares"
# some times called selection by log-likelihood
anova(c3_plants_lm_int, c3_plants_lm)


# ANCOVA
fruitfly <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter15/Data/partridge.csv")
summary(fruitfly)

# Boxplot
ggplot(data = fruitfly, aes(x = TREATMENT, y = LONGEV)) +
  geom_boxplot()

# Scatter plot
ggplot(data = fruitfly, aes(x = THORAX, y = LONGEV)) +
  geom_point()

ggplot(data = fruitfly, aes(x = THORAX, y = LONGEV, color = TREATMENT)) +
  geom_point() +
  geom_smooth(method = "lm")


# Run an ANCOVA
fruitfly_ancova <- lm(data = fruitfly, LONGEV ~ TREATMENT * THORAX)

summary(fruitfly_ancova)
anova(fruitfly_ancova)

fruitfly_ancova_2 <- lm(data = fruitfly, LONGEV ~ TREATMENT + THORAX)
summary(fruitfly_ancova_2)


# GLM
spiders <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter17/Data/polis.csv")
spiders

# Make plot
ggplot(data = spiders, aes(x = RATIO, y = PA)) +
  geom_point()

# make an lm model
spiders_lm <- lm(data = spiders, PA ~ RATIO)
summary(spiders_lm)
plot(spiders_lm)

ggplot(data = spiders, aes(x = RATIO, y = PA)) +
  geom_point() +
  geom_smooth(method = "lm")

# glm model
spiders_glm <- glm(data = spiders, PA ~ RATIO, family = binomial)
summary(spiders_glm)

# make a plot with glm
ggplot(data = spiders, aes(x = RATIO, y = PA)) +
  geom_point() +
  geom_smooth(method = "glm", method.args = list(family = "binomial"))


# chi-squared / frequency analysis
trees <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter16/Data/roberts.csv")

head(trees)


# make a contingency table
trees_xtab <- table(trees$POSITION, trees$DEAD)
trees_xtab

chisq.test(trees_xtab)
