# Subsetting - quick review
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X
X[,1]
X[,"var1"]
X[1:2,"var2"]
# Logicals ands and ors
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]
# Dealing with missing values
X[which(X$var2 > 8),]
# Sorting
sort(X$var1)
sort(X$var1,decreasing=TRUE)
sort(X$var2,na.last=TRUE)
X[order(X$var1),]
X[order(X$var1,X$var3),]
# Ordering with plyr
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))
# Adding rows and columns
X$var4 <- rnorm(5)
X
Y <- cbind(X,rnorm(5))
Y



# Question 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/communitysurvey.csv",method="curl")
#list.files("./data")
dateDownloaded <- date()
communityData <- read.csv("./data/communitysurvey.csv",colClasses = "character")
agricultureLogical <- (communityData$ACR == "3") & (communityData$AGS == "6" )
which(agricultureLogical)









