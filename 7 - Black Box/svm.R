##
## Step 1 - Gather Data
##
letters <- read.csv("letterdata.csv")

##
## Step 2 - Prepare Data
##

# Data has mostly been prepared so
# split into train and test data
letters_train <- letters[1:16000, ]
letters_test  <- letters[16001:20000, ]

##
## Step 3 - Train
##

# SVM packages
# 1. e1071 - Award winning from Vienna University (C++)
# 2. klaR - SVMlight algrorithm
# 3. kernlab - Native R implementation good for starting out

# install.packages("kernlab")
library(kernlab)

letter_classifier <- ksvm(letter ~., data = letters_train, kernel = "vanilladot")
