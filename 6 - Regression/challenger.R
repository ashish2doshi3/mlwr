launch <- read.csv("challenger.csv")
# b = cov(x, y) / var(x)
b <- cov(launch$temperature, launch$distress_ct) / var(launch$temperature)
a <- mean(launch$distress_ct) - b * mean(launch$temperature)


##
## Correlations
##
r <- cov(launch$temperature, launch$distress_ct) / (sd(launch$temperature) * sd(launch$distress_ct))

# Build in correlation
r <- cor(launch$temperature, launch$distress_ct)
