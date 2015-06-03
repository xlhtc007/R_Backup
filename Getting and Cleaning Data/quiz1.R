if (!file.exists("data")){
    
    dir.create("data")
}
#Question 1-2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/communitysurvey.csv",method="curl")
#list.files("./data")
dateDownloaded <- date()
communityData <- read.csv("./data/communitysurvey.csv",colClasses = "character")
valData <- communityData$VAL
length(valData[valData=="24"])

fesData <- communityData$FES

#Question 3
library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./data/naturalGasAquisition.xlsx",method="curl")
dateDownloaded <- date()
dat <- read.xlsx("./data/naturalGasAquisition.xlsx",sheetIndex=1,colIndex=7:15,rowIndex=18:23,header=TRUE)
sum(dat$Zip*dat$Ext,na.rm=T) 

# example 1(Extract content by attributes)
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

#Question 4
library(XML)
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
doc <- xmlTreeParse("./data/getdata_data_restaurants.xml",useInternal=TRUE)
rootNode <- xmlRoot(doc)
names(rootNode)
#xmlSApply(rootNode,xmlValue)
zipValue <- xpathSApply(rootNode,"//zipcode",xmlValue)
zipRs <- zipValue[zipValue=="21231"]
length(zipRs)


# example2 (Reading Data From JSON)
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
myjson <- toJSON(iris,pretty = TRUE) 
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)

# Using data.table
library(data.table)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)
tables()
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]
DT[,c(2,3)]
DT[,list(mean(x),sum(z))]
DT[,table(y)]
DT[,w:=z^2]
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
DT[,a:=x>0]
DT[,b:= mean(x+w),by=a]

set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]

DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT, x)
DT['a']

DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))

#Question 5
#downloadFile <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile="./data/housing.csv",method="curl")
downloadFile <- "./data/getdata_data_ss06pid.csv"
DT <- fread(downloadFile)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
#system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
#system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))



