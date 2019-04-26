# Meeting 12 - ANOVA

# Aldrin in wolf creek
aldrin <- read.csv("https://bit.ly/2DXjm59")
summary(aldrin)

# perform a linear model on our aldrin data set
aldrin_lm <- lm(data = aldrin, aldrin~depth)
aldrin_lm <- lm(aldrin$aldrin~aldrin$depth)

boxplot(aldrin$aldrin ~ aldrin$depth)

# Get ANOVA table
anova(aldrin_lm)

# Post-hoc multiple comparisons
TukeyHSD(aov(data = aldrin, aldrin~depth))
plot(TukeyHSD(aov(data = aldrin, aldrin~depth)))


# Nested ANOVA

# Density dependent grazing effects of sea urchins on algea - Andrew and Underwood 1993

algae_density <- read.csv("https://bit.ly/2Dpwr5B")

# data conversions to do an ANOVA
algae_density$PATCH <- factor(algae_density$PATCH)
algae_density$QUAD <- factor(algae_density$QUAD)

summary(algae_density)

# Make a box plot
library(ggplot2)
ggplot(data = algae_density, aes(x = TREAT, y = ALGAE)) +
  geom_boxplot() +
  theme_bw()

library(dplyr)
algae_density_agg <-
  algae_density %>%
  group_by(TREAT, PATCH) %>%
  summarise(ALGAE_QUAD_MEAN = mean(ALGAE))
algae_density_agg

ggplot(data = algae_density_agg, aes(x = TREAT, y = ALGAE_QUAD_MEAN)) +
  geom_boxplot() +
  theme_bw()

# How do we even do a nested ANOVA?
algae_density_aov <- aov(data = algae_density, ALGAE ~ TREAT + Error(PATCH))
summary(algae_density_aov)

# Error of pseudo replication !!! 
# Hulbert 1984 
summary(aov(data = algae_density, ALGAE ~ TREAT))

# Factorial ANOVA - Multi-way ANOVA - Two-way ANOVA

# effects of densiy and season on limpet reproduction
limpets <- read.csv(file = "https://bit.ly/2UCV7x2")

summary(limpets)

limpets$DENSITY <- factor(limpets$DENSITY)
summary(limpets)


# plots
ggplot(data = limpets) +
  geom_boxplot(aes(x = DENSITY, y = EGGS))

ggplot(data = limpets) +
  geom_boxplot(aes(x = SEASON, y = EGGS))

ggplot(data = limpets) +
  geom_boxplot(aes(x = DENSITY, y = EGGS, fill = SEASON))

# 2-way anova
limpets_lm <- lm(data = limpets, EGGS ~ SEASON * DENSITY)
anova(limpets_lm)

# Drop the non-sig interaction term
limpets_lm <- lm(data = limpets, EGGS ~ SEASON + DENSITY)
anova(limpets_lm)

anova(lm(data = limpets, EGGS ~ SEASON))

# Same as above, but further down the shore line
limpets1 <- read.csv("https://bit.ly/2DyOB50")
summary(limpets1)

# Convert density to a factor
limpets1$DENSITY <- factor(limpets1$DENSITY)
summary(limpets1)

# Plot this
ggplot(data = limpets1) +
  geom_boxplot(aes(x = DENSITY, y = EGGS, fill = SEASON))


limpets1_lm <- lm(data = limpets1, EGGS ~ SEASON * DENSITY)
anova(limpets1_lm)

summary(limpets1_lm)
