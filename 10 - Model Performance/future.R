##
## Estimating Future Performance
##
credit <- read.csv("credit.csv")

# Random ids from 1 to 1000
random_ids <- order(runif(1000))

# Break up into 50% train 25% validate and 25% test
credit_train <- credit[random_ids[1:500],]
credit_test <- credit[random_ids[1:250],]
credit_validate <- credit[random_ids[1:250],]

library(caret)
# createDataPartition from caret package can split up data
in_train <- createDataPartition(credit$default, p = 0.75, list = FALSE)
credit_train <- credit[in_train,]
credit_test <- credit[-in_train,]

## Cross Validation
folds <- createFolds(credit$default, k = 10)
