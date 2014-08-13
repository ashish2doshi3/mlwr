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
