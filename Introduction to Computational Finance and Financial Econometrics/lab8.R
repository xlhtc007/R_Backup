# Load the relevant packages
library("zoo")

# Load the working environment
load(url("http://s3.amazonaws.com/assets.datacamp.com/course/compfin/lab9.RData"))

# Explore the data set
head(returns_df)
tail(returns_df)

# Timeplots with stocks on individual graphs
my.panel <- function(...) {
    lines(...)
    abline(h=0)
}
plot(returns_df, lwd=2, panel=my.panel, col="blue")

# Timeplots with stocks on same graph
plot(returns_df, plot.type = "single", main="Returns", col=1:4, lwd=2)
abline(h=0)
legend(x="bottomleft", legend=colnames(returns_df), col=1:4, lwd=2)

# Parameters CER model
mu_hat_month <- apply(returns_df, 2, mean)
mu_hat_month
sigma2_month <- apply(returns_df, 2, var)

sigma2_month
sigma_month <- apply(returns_df, 2, sd)

sigma_month
cov_mat_month <- var(returns_df)
cov_mat_month
cor_mat_month <- cor(returns_df)

cor_mat_month

# Pairwise scatterplots
pairs(coredata(returns_df), col = "blue", pch = 16)

