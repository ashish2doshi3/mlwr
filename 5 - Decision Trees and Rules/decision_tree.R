##
## Step 1: Gather Data
##
credit <- read.csv("credit.csv")

##
## Step 2: Prepare data
##
table(credit$checking_balance)

# Set random seed
set.seed(1234)

# Randomize credit order
credit_rand <- credit[order(runif(length(credit[,1]))),]

# Split data for train/test
credit_train <- credit_rand[1:900,1]
credit_test <- credit_rand[901:1000,]
