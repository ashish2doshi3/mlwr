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
