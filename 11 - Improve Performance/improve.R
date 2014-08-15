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
