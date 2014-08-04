##
## Step 1 - Collect Data
##
concrete <- read.csv("concrete.csv")
str(concrete)

##
## Step 2 - Prepare Data
##

# Normalize function
normalize <- function(x) {
        return ((x - min(x)) / (max(x) - min(x)))
}

concrete_norm <- as.data.frame(lapply(concrete, normalize))
summary(concrete_norm$strength)

concrete_train <- concrete_norm[1:773, ]
concrete_test <- concrete_norm[774:1030, ]

##
## Step 3 - Train Data
##

# Use install.packages("neuralnet")

library(neuralnet)

concrete_model <- neuralnet(strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age, data = concrete_train)
plot(concrete_model)
