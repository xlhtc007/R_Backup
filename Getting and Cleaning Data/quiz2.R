# R HDF5 package
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("data/example.h5")
created
# Create groups
created = h5createGroup("data/example.h5","foo")
created = h5createGroup("data/example.h5","baa")
created = h5createGroup("data/example.h5","foo/foobaa")
h5ls("data/example.h5")
# Write to groups
A = matrix(1:10,nr=5,nc=2)
h5write(A, "data/example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "data/example.h5","foo/foobaa/B")
h5ls("data/example.h5")
# Write a data set
df = data.frame(1L:5L,seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "data/example.h5","df")
h5ls("data/example.h5")
# Reading data
readA = h5read("data/example.h5","foo/A")
readB = h5read("data/example.h5","foo/foobaa/B")
readdf= h5read("data/example.h5","df")
readA
# Writing and reading chunks
h5write(c(12,13,14),"data/example.h5","foo/A",index=list(1:3,1))
h5read("data/example.h5","foo/A")

# Getting data off webpages - readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode
# Parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# GET from the httr package
library(httr)
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)



# Question 1
library(httr)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")
# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "cff3697e52526ad8e0e4",
                   secret = "ce7c1381672086143e7ca11e7fd50c368d593e3a")
# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

# Question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

# Question 5
con = url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
sstData = readLines(con)
close(con)
substrrs <- substr(sstData, 29,32)
subdouble <- as.double(substrrs[5:length(substrrs)])
sum(subdouble)

