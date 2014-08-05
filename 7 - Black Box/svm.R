##
## Step 1 - Gather Data
##
letters <- read.csv("letterdata.csv")

##
## Step 2 - Prepare Data
##

# Data has mostly been prepared so
# split into train and test data
letters_train <- letters[1:16000, ]
letters_test  <- letters[16001:20000, ]
