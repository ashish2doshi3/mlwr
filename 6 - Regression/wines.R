##
## Step 1 - Collect Data
##
wine <- read.csv("whitewines.csv")

str(wine)

hist(wine$quality)
