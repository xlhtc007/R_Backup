# Fixing character vectors - tolower(), toupper()
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))
# Fixing character vectors - strsplit()
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]

# Quick aside - lists
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1]
mylist$letters
mylist[[1]]
# Fixing character vectors - sapply()
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

# Peer review data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)
# Fixing character vectors - sub()
names(reviews)
sub("_","",names(reviews))
# Fixing character vectors - gsub()
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)
# Finding values - grep(),grepl()
grep("Alameda",cameraData$intersection)
table(grepl("Alameda",cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
# More on grep()
grep("Alameda",cameraData$intersection,value=TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))
# More useful string functions
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffrey","Leek")
paste0("Jeffrey","Leek")
str_trim("Jeff      ")




# Question 1
communityData <- read.csv("./data/communitysurvey.csv",colClasses = "character")
splitnames = strsplit(names(communityData),"\\wgtp")
splitnames[123]

# Question 2
gdpsraw <- read.csv("./data/datagdp.csv",stringsAsFactors=FALSE, header=FALSE)
gdps <- gdpsraw[6:195,c(1,2,4,5)]
names(gdps) <- c("CountryCode","Ranking","Economy","gdp")
gdps$gdp <- gsub(",","",gdps$gdp)
mean(as.integer(gdps$gdp)) 

# Question 3
countryNames <- gdps$Economy
grep("^United",countryNames)

# Question 4
library(dplyr)
library(plyr)
gdpsraw <- read.csv("./data/datagdp.csv",stringsAsFactors=FALSE, header=FALSE)
gdps <- gdpsraw[6:195,c(1,2,4,5)]
names(gdps) <- c("CountryCode","Ranking","Economy","gdp")
gdps$Ranking <- as.integer(gdps$Ranking)
edus <- read.csv("./data/dataedu.csv")
joincsv <- join(gdps,edus)
specialnote <- joincsv$Special.Notes
length(grep("Fiscal year end: June 30",specialnote))

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
time2012 <- sampleTimes[grep("^2012",sampleTimes)]
length(time2012)
#time2012 <- gsub("-","",time2012)
date2012 <- wday(ymd(time2012))
length(grep("2",date2012))




