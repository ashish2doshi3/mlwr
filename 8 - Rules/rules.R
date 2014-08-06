##
## Step 1 - Gather Data
##

# install.packages("arules")
# To read in sparse matrix data
library(arules)
groceries <- read.transactions("groceries.csv", sep = ",")

##
## Step 2 - Explore/Prepare Data
##

summary(groceries)

# inspect from arules
inspect(groceries[1:5])

# itemFrequency for first three items (columns)
itemFrequency(groceries[, 1:3])

# Plot with min 10% frequency
itemFrequencyPlot(groceries, support = 0.1)

# Plot top N items
itemFrequencyPlot(groceries, topN = 20)

# Visualize entire matrix
# all columns for first 5 transactions
image(groceries[1:5])

# Or sample random 100 transactions
image(sample(groceries, 100))
