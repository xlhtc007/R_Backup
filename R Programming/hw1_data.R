#initial
data <- read.csv("DataScientist-RPro/hw1_data.csv")

#Question 11
names(data)

#Question 12
data[1:2,]

#Question 13
dim(data)

#Question 14
data[152:153,]

dataOzone <- data$Ozone
#Question 15
dataOzone[47]

#Question 16
length(dataOzone[is.na(dataOzone)])

#Question 17
mean(dataOzone[!is.na(dataOzone)])

#Question 18
dataTemp <- data$Temp
dataSolarR <- data$Solar.R
dataSolarR_sub <- dataSolarR[dataOzone > 31 & dataTemp > 90]
mean(dataSolarR_sub[!is.na(dataSolarR_sub])

#Question 19
dataMonth <- data$Month
dataTemp[dataMonth == 6]

#Question 20
max(dataOzone[dataMonth == 5], na.rm = TRUE)


