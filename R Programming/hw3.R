library(datasets)
data(iris)
virginica <- iris$Species == "virginica"
mean(iris$Sepal.Length[virginica])


