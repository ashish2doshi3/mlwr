##
## Step 1 - Gather Data
##
insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)

##
## Step 2 - Prepare Data
##
summary(insurance)

hist(insurance$charge)

# Check correlations among features
cor(insurance[c("age", "bmi", "children", "charges")])

# Scatter Plot Matrix
pairs(insurance[c("age", "bmi", "children", "charges")])

# Use psych package for further info
library(psych)
pairs.panels(insurance[c("age", "bmi", "children", "charges")])

##
## Step 3 - Train
##

# lm() from stats package built in
ins_model <- lm(charges ~ age + children + bmi + sex + smoker + region, data = insurance)
