library(datasets)
data(iris)
virginica <- iris$Species == "virginica"
mean(iris$Sepal.Length[virginica])

tapply(iris$Sepal.Length, iris$Species, mean)

apply(iris[, 1:4], 2, mean)

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

