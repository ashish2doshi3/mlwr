##
## Create A Simple Tuned Model
##
library(caret)
set.seed(300)

credit <- read.csv("credit.csv")

# Simplest way to tune a learner using caret
# is use train() and pass learning method
# Here is the C5.0 decision tree
m <- train(default ~., data = credit, method = "C5.0")

# Now predict using chosen tuned prediction
p <- predict(m, credit)

table(p, credit$default)

# Any data pre-processing is applied to model from train()
# And predict() can be used to get predicted values and probabilities

head(p)

head(predict(m, credit, type = "prob"))

##
## Customizing Tuning Process
##

# Use trainControl() to get a set of config options for train()
# Here is 10 fold cross validation and oneSE for
# selecting optimal model
ctrl <- trainControl(method = "cv", number = 10, selectionFunction = "oneSE")

# Next create a grid of parameters to optimize
# Holding method to tree and winnow to false
grid <- expand.grid(.model = "tree", .trials = c(1, 5, 10, 15, 20, 25, 30, 35), .winnow = FALSE)

# Now train using customed tuning settings
set.seed(300)
m <- train(default ~., data = credit, method = "C5.0", metric = "Kappa", trControl = ctrl, tuneGrid = grid)

##
## Meta Learning - Ensembles
##

# Bagging - use ipred package
library(ipred)
set.seed(300)

# Create 25 decision trees
mybag <- bagging(default ~., data = credit, nbag = 25)

credit_pred <- predict(mybag, credit)
table(credit_pred, credit$default)

# Using caret package and treebag from ipred
library(caret)
set.seed(300)

ctrl <- trainControl(method = "cv", number = 10)
train(default ~., data = credit, method = "treebag", trControl = ctrl)

# Bagged SVM model using svmBag from caret package
bagctrl <- bagControl(fit = svmBag$fit, predict = svmBag$pred, aggregate = svmBag$aggregate)

# Actually performed just as good if not better
# Which differs from a worse output found in the book
svmbag <- train(default ~ ., data = credit, "bag", trControl = ctrl, bagControl = bagctrl)

##
## Random Forests
##

library(randomForest)
set.seed(300)

rf <- randomForest(default ~ ., data = credit)

# Using Caret package random forests
library(caret)
set.seed(300)

ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
grid_rf <- expand.grid(.mtry = c(2, 4, 8, 16))

m_rf <- train(default ~ ., data = credit, method = "rf",
              metric = "Kappa", trControl = ctrl,
              tuneGrid = grid_rf)

# Use C5.0 Decision Tree to compare with random forests
grid_c50 <- expand.grid(.model = "tree",
                        .trials = c(10, 20, 30, 40),
                        .winnow = "FALSE")
set.seed(300)
m_c50 <- train(default ~ ., data = credit, method = "C5.0",
               metric = "Kappa", trControl = ctrl, tuneGrid = grid_c50)
