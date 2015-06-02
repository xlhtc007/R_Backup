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

#Question 4




