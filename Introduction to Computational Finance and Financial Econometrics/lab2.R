# X ~ N(0.05, (0.10)^2)
mu_x = 0.05
sigma_x = 0.1

# Pr(X > 0.10)
1 - pnorm((0.1-mu_x)/sigma_x)
1 - pnorm(0.1,mean = mu_x, sd = sigma_x)

# Pr(X < -0.10)
pnorm((-0.1-mu_x)/sigma_x)
pnorm(-0.1,mean = mu_x, sd = sigma_x)

# Pr(-0.05 < X < 0.15)
pnorm((0.15-mu_x)/sigma_x) - pnorm((-0.05-mu_x)/sigma_x)
pnorm(0.15,mean = mu_x, sd = sigma_x) - pnorm(-0.05,mean = mu_x, sd = sigma_x)

# 1%, 5%, 95% and 99% quantile
qnorm(c(0.01,0.05,0.95,0.99),mean = mu_x, sd = sigma_x)



