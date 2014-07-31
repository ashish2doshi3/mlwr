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

#
# Multiple Linear Regressions
#

# B = (Xt * X) **-1 * Xt * Y
reg <- function(x, y) {
        x <- as.matrix(x)
        x <- cbind(Intercept = 1, x)
        solve(t(x) %*% x) %*% t(x) %*% y
}

reg(y = launch$distress_ct, x = launch[3])[, 1]
reg(y = launch$distress_ct, x = launch[3:5])[, 1]
