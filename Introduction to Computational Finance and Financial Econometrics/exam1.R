rs1 <- (109.04-105.06)/105.06
rs2 <- (29.49-28.64)/28.64
rc1 <- log(1+rs1)
rc2 <- log(1+rs2)
rsy1 <- (1+rs1)^12 - 1
rsy2 <- (1+rs2)^12 - 1
rcy1 <- log(1+rsy1)
rcy2 <- log(1+rsy2)
10000 * (rsy1 + 1)
10000 * (rsy2 + 1)
rsp <- 0.2*(rs1 + 1) + 0.8*(rs2 + 1) - 1
rcp <- 0.2*(rc1 + 1) + 0.8*(rc2 + 1) - 1

-1.645*0.05*100000
-1.645*0.09*100000
-(exp(qnorm(0.05,0.001,0.05))-1)*100000
-(exp(qnorm(0.05,0.01,0.09))-1)*100000

-(exp(qnorm(0.05,0.001*12,0.05*sqrt(12)))-1)*100000
-(exp(qnorm(0.05,0.01*12,0.09*sqrt(12)))-1)*100000

3/(1-0.45)
1.5^2/(1-0.45^2)
0.45*sqrt(1.5^2/(1-0.45^2))*sqrt(1.5^2*0.45^2/(1-0.45^2))
