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
