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

##
## Step 4 - Evaluate Performance
##

summary(ins_model)

##
## Step 5 - Improve Performance
##

# Add non-linear age to model
insurance$age2 <- insurance$age ^ 2

# BMI indicator 1 or 0 transformation
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0)

ins_model2 <- lm(charges ~ age + age2 + children + bmi + sex + bmi30*smoker + region, data = insurance)
summary(ins_model2)
