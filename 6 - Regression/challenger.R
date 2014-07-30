launch <- read.csv("challenger.csv")
# b = cov(x, y) / var(x)
b <- cov(launch$temperature, launch$distress_ct) / var(launch$temperature)
a <- mean(launch$distress_ct) - b * mean(launch$temperature)
