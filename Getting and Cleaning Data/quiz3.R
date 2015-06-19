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


# Start with reshaping
library(reshape2)
head(mtcars)
# Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
tail(carMelt,n=3)
# Casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData
# Averaging values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)
# Another way - split
spIns =  split(InsectSprays$count,InsectSprays$spray)
spIns
# Another way - apply
sprCount = lapply(spIns,sum)
sprCount
# Another way - combine
unlist(sprCount)
sapply(spIns,sum)
# Another way - plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
# Creating a new variable
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)

# Completed Managing Data Frames with dplyr - Basic Tools
library(dplyr)
chicago <- readRDS("chicago.rds")
dim(chicago)
head(select(chicago, 1:5))
names(chicago)[1:3]
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
chic.f <- filter(chicago, pm25tmean2 > 30)
head(select(chic.f, 1:3, pm25tmean2), 10)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(select(chic.f, 1:3, pm25tmean2, tmpd), 10)
# arrange
# Reordering rows of a data frame (while preserving corresponding 
# order of other columns) is normally a pain to do in R.
chicago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)
chicago <- arrange(chicago, desc(date))
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)
# rename
# Renaming a variable in a data frame in R is surprising hard to do!
head(chicago[, 1:5], 3)
chicago <- rename(chicago, dewpoint = dptp,
                  pm25 = pm25tmean2)
head(chicago[, 1:5], 3)

chicago <- mutate(chicago,
                  pm25detrend=pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))
# group_by
# Generating summary statistics by stratum
chicago <- mutate(chicago,
                  tempcat = factor(1 * (tmpd > 80),
                                   labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2),
          no2 = median(no2tmean2))
chicago <- mutate(chicago,
                  year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2, na.rm = TRUE),
          no2 = median(no2tmean2, na.rm = TRUE))


# Peer review data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)
names(reviews)
names(solutions)
# Merging data - merge()
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)
# Default - merge all common column names
intersect(names(solutions),names(reviews))
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)
# Using join in the plyr package
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)
# If you have multiple data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)

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

# Question 3
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
download.file(fileUrl1, destfile="./data/datagdp.csv",method="curl")
download.file(fileUrl2, destfile="./data/dataedu.csv",method="curl")
gdpsraw <- read.csv("./data/datagdp.csv",stringsAsFactors=FALSE, header=FALSE)
gdps <- gdpsraw[6:195,c(1,2,4,5)]
names(gdps) <- c("CountryCode","Ranking","Economy","gdp")
gdps$Ranking <- as.integer(gdps$Ranking)
edus <- read.csv("./data/dataedu.csv")
head(gdps,10)
head(edus,10)
#mergedcsv = merge(gdps,edus,by.x="countrycode",by.y="CountryCode",all=TRUE)
joincsv <- arrange(join(gdps,edus),desc(Ranking))
nrow(joincsv)
joincsv[13,]


# Question 4
hiOECD <- joincsv[joincsv$Income.Group == "High income: OECD",]
hinonOECD <- joincsv[joincsv$Income.Group == "High income: nonOECD",]
meanhi <- mean(hiOECD$Ranking, na.rm = TRUE)
meanhinon <- mean(hinonOECD$Ranking, na.rm = TRUE)
meanhi
meanhinon

# Question 5
quantile(joincsv$Ranking,probs=c(0.2,0.4,0.6,0.8))
# Make table
table(joincsv$Ranking,useNA="ifany")
jointable <- table(joincsv$Ranking,joincsv$Income.Group)
names(jointable)



