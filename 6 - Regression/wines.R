##
## Step 1 - Collect Data
##
wine <- read.csv("whitewines.csv")

##
## Step 2 - Prepare Data
##
str(wine)

hist(wine$quality)

wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]

##
## Step 3 - Train Data
##

# Use rpart form install.packages("rpart")
# For fitting classification trees or regression trees
library(rpart)

m.rpart <- rpart(quality ~., data = wine_train)
m.rpart

# Plot using install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(m.rpart, digits = 3)

##
## Step 4 - Evaluate Performance
##

p.rpart <- predict(m.rpart, wine_test)
summary(p.rpart)

# Check correlation of predicted to actual
cor(p.rpart, wine_test$quality)

# Mean Absolute Error
MAE <- function(actual, predicted) {
        mean(abs(actual - predicted))
}

MAE(p.rpart, wine_test$quality)

##
## Step 5 - Improve Performance
##

# Use M5 algorithm from RWeka package
library(RWeka)

m.m5p <- M5P(quality ~., data = wine_train)
m.m5p
