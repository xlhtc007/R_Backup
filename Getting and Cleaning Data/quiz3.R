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


# Getting the data from the web
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")
# Look at a bit of the data
head(restData,n=3)
tail(restData,n=3)
summary(restData)
str(restData)
# Quantiles of quantitative variables
quantile(restData$councilDistrict,na.rm=TRUE)
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))
# Make table
table(restData$zipCode,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)
# Check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
# Row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
# Values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]
# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt
# Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt
ftable(xt)
# Size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")

# Creating sequences
s1 <- seq(1,10,by=2)
s2 <- seq(1,10,length=3)
x <- c(1,3,8,25,100); seq(along = x)
# Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
# Creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)
# Creating categorical variables
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)
# Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
# Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
# Levels of factor variables
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac = factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")
as.numeric(yesnofac)
# Cutting produces factor variables
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)







# Question 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/communitysurvey.csv",method="curl")
#list.files("./data")
dateDownloaded <- date()
communityData <- read.csv("./data/communitysurvey.csv",colClasses = "character")
agricultureLogical <- (communityData$ACR == "3") & (communityData$AGS == "6" )
which(agricultureLogical)

# Question 2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl,destfile="./data/jeff.jpg",method="curl")
library(jpeg)
jeffpic <- readJPEG("./data/jeff.jpg",native=TRUE)
quantile(jeffpic,probs=c(0.3,0.8))




