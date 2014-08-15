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
