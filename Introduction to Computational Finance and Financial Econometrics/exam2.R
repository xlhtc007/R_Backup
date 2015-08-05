ry_vpacx <- 0.0043*12
stdy_vpacx <- 0.0559*sqrt(12) 
sharp_ration_vpacx <- (ry_vpacx - 0.0008*12)/stdy_vpacx

ry_vbltx <- 0.0049*12
stdy_vbltx <- 0.029*sqrt(12)
sharp_ration_vbltx <- (ry_vbltx - 0.0008*12)/stdy_vbltx

ry_veiex <- 0.0128*12
stdy_veiex <- 0.0845*sqrt(12)
sharp_ration_veiex <- (ry_veiex - 0.0008*12)/stdy_veiex

(1-0.4)/(1.28-0.4)
0.6818*1.28+(1-0.6818)*0.4
w_vpacx <- 0.6818*(-1.2) + (1-0.6818)*0.23
w_vbltx <- 0.6818*1.29 + (1-0.6818)*0.87
w_veiex <- 0.6818*0.91 + (1-0.6818)*(-0.1)

(1-0.08)/(1.76-0.08)
0.55*1.7 + (1-0.55)*0.08
6.53*(1-0.08)/(1.76-0.08)

(exp(qnorm(0.05,0.004,0.0284))-1)*100000