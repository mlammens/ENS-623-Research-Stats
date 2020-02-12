# Meeting 9

# Let's do some clean up!
rm(list = ls())


(flip <- runif(1))

if(flip < 0.5){
  coin_flip <- "head"
} else {
  coin_flip <- "tail"
}
coin_flip


# Do this 100 times
all_flips <- c()

for (x in 1:100){

  # flip the coin
  flip <- runif(1)
  
  # determine if heads or tails
  if(flip < 0.5){
    coin_flip <- "head"
  } else {
    coin_flip <- "tail"
  }
  #print(coin_flip)
  
  # add this flip to the all_flips vector
  all_flips <- c(all_flips, coin_flip)
  
}

# Count the heads
sum(all_flips == "head")

# Calculate the probability of heads
sum(all_flips == "head") / length(all_flips)

# Binomial data
num_heads <- c(45, 51, 53, 50, 55, 50, 53, 40, 50, 45, 48, 47, 51, 53)

hist(num_heads, breaks = 15)

# M&Ms
mms_tots <- c(57, 60, 53, 57, 55, 56, 57, 54)

mean(mms_tots)

# mean without using the mean function
sum(mms_tots) / length(mms_tots)

# variation

# range
max(mms_tots) - min(mms_tots)

# standard deviation
sd(mms_tots)

# variance
var(mms_tots)
sqrt(var(mms_tots))

# Variance "by hand"
# x_i - x_bar
mms_tots - mean(mms_tots)
sum(mms_tots - mean(mms_tots))

# abs deviation
sum(abs(mms_tots - mean(mms_tots)))

# sum of squared deviation
sum((mms_tots - mean(mms_tots))^2)

# variance = mean sum of squared deviation
sum((mms_tots - mean(mms_tots))^2) / (length(mms_tots) - 1)

# standard deviation from variance
sqrt(sum((mms_tots - mean(mms_tots))^2) / (length(mms_tots) - 1))


# Back to probability

# think about your bag of m&ms

(p_red <- 8/57)
(p_green <- 13/57)

# p of red or green
(8+13)/57
p_red + p_green

# In general, if your asking prob of event a OR event b, you can add them
# if they are independent


# Prob red and a green? -> 0

# Sampling with replacement
# - draw and mm, then put it back, draw another
# p(green, then blue)
(13/57)*(12/57)

# Sampling without replacement
# - draw and mm, eat it, draw another
(13/57)*(12/56)


# Draw a random bag of m&ms using the companies stated frequencies
mm_colors <- c("blue", "brown", "green", "orange", "red", "yellow")
mm_probs <- c(.23, .14, .16, .20, .13, .14)

# I want to sample a new bag of m&ms
new_bag <- sample(x = mm_colors, size = 57, replace = TRUE, prob = mm_probs)
new_bag

table(new_bag)

# get a new bag count
new_bag_counts <- c(sum(new_bag == "blue"),
                    sum(new_bag == "brown"),
                    sum(new_bag == "green"),
                    sum(new_bag == "orange"),
                    sum(new_bag == "red"),
                    sum(new_bag == "yellow"))
new_bag_counts


my_bag <- c(12, 6, 13, 13, 8, 5)
sum(my_bag)

# compare random bag to my_bag
new_bag_counts == my_bag
all(new_bag_counts == my_bag)


