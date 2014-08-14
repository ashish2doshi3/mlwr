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

# 10 folds is standard number of splits
folds <- createFolds(credit$default, k = 10)

library(caret)
library(C50)
library(irr)

set.seed(123)
folds <- createFolds(credit$default, k = 10)

cv_results <- lapply(folds, function(x){
        credit_train <- credit[x,]
        credit_test <- credit[-x,]
        credit_model <- C5.0(default ~., data = credit_train)
        credit_pred <- predict(credit_model, credit_test)
        credit_actual <- credit_test$default
        kappa <- kappa2(data.frame(credit_actual, credit_pred))$value
        return(kappa)
})

str(cv_results)
mean(unlist(cv_results))
