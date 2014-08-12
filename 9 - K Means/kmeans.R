##
## Step 1 - Collecting Data
##
teens <- read.csv("snsdata.csv")

str(teens)

##
## Step 2 - Prepare Data
##

# Look at gender split
table(teens$gender)

# Show NAs
table(teens$gender, useNA = "ifany")

# Look at age distribution
# Shows lots of NAs and a min of age 3 and max of age 106
summary(teens$age)

# Clean up age to exclude 20 and older and under 13
teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)
summary(teens$age)

##
## Dummy coding of missing ages
##

# Set binary value of female or not unknown gender
teens$female <- ifelse(teens$gender == "F" & !is.na(teens$gender), 1, 0)

# Set binary value of no gender or gender known
teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)

# Get mean age with NAs excluded
mean(teens$age, na.rm = TRUE)

# Even better get mean age by subgroup of gradyear
aggregate(data = teens, age ~ gradyear, mean, na.rm = TRUE)

# Use ave() to apply across vectors
ave_age <- ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = TRUE))

teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

##
## Step 3 - Train
##

# Using stats package
library(stats)

# Select 36 features to start out
interests <- teens[5:40]

# Normalize using zscore with scale()
interests_z <- as.data.frame(lapply(interests, scale))

# Randomly choose 5 clusters for k
teen_clusters <- kmeans(interests_z, 5)

##
## Step 4 - Evaluate Performance
##

# Check sizes of clusters
# [1]  5997  1016 21566   868   553
teen_clusters$size

# Examine cluster centroids
teen_clusters$centers

##
## Step 5 - Improve Performance
##

# Apply clusters back into data set
teens$cluster <- teen_clusters$cluster

teens[1:5, c("cluster", "gender", "age", "friends")]

# Shows mean age doesn't change much per cluster
#cluster      age
#1       1 17.06780
#2       2 17.11104
#3       3 17.30259
#4       4 16.86294
#5       5 17.35022
aggregate(data = teens, age ~ cluster, mean)

# Shows clusters are predictive of gender for the most part
#cluster    female
#1       1 0.8464232
#2       2 0.8021654
#3       3 0.6966058
#4       4 0.8375576
#5       5 0.7468354
aggregate(data = teens, female ~ cluster, mean)

# Check number of friends for clusters
aggregate(data = teens, friends ~ cluster, mean)
