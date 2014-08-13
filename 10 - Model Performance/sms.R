sms_results <- read.csv("sms_results.csv")
head(sms_results)

head(subset(sms_results, actual_type != predict_type))

# Cross table output to find meaningful error rate
library(gmodels)

CrossTable(sms_results$actual_type, sms_results$predict_type)

# Calculate accuracy
# (TP + TN) / (TP + TN + FP + FN)
accuracy <- (154 + 1202) / (154+ 1202 + 5 + 29)

# Calculate error rate
# (FP + FN) / (TP + TN + FP + FN)
# or 1 - accuracy
error_rate <- (5 + 29) / (154 + 1202 + 5 + 29)

##
## Other Measures
##

# Use caret package from install.packages("caret")
library(caret)

confusionMatrix(sms_results$predict_type,sms_results$actual_type, positive = "spam")

## Kappa Statistic
# Poor agreement = Less than 0.20
# Fair agreement = 0.20 to 0.40
# Moderate agreement = 0.40 to 0.60
# Good agreement = 0.60 to 0.80
# Very good agreement = 0.80 to 1.00

# Using CrossTable output

# Pr(a) proportion of actual
pr_a <- 0.865 + 0.111

# Pr(e) expected
# Pr(actual_type is ham) * Pr(predicted_type is ham)
# Pr(actual_type is spam) * Pr(predicted_type is spam)
pr_e <- 0.868 * 0.886 + 0.132 * 0.114

# Calculate kappa
k <- (pr_a - pr_e) / (1 - pr_e)

# Using Visualizing Categorical Data package
# install.packages("vcd")
library(vcd)
Kappa(table(sms_results$actual_type, sms_results$predict_type))

# Using Inter-Rater Reliability package
# install.packages("irr")
library(irr)
kappa2(sms_results[1:2])
