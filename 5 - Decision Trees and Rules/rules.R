##
## Step 1: Collect Data
##
mushrooms <- read.csv("mushrooms.csv", stringsAsFactors = TRUE)

##
## Step 2: Prepare Data
##

str(mushrooms)

# Drop veil_type since it does not vary and won't provide value
mushrooms$veil_type <- NULL

# Check distribution of classification
table(mushrooms$type)

##
## Step 3: Train
##

# Use RWeka from install.packages("RWeka") for 1R
library(RWeka)

mushroom_1R <- OneR(type ~ ., data = mushrooms)

##
## Step 4: Evaluate Performance
##

summary(mushrooms_1R)

##
## Step 5: Improve Performance
##

# RIPPER algorithm
mushroom_JRip <- JRip(type ~ ., data = mushrooms)
mushroom_JRip
