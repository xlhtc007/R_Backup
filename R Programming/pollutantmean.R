pollutantmean <- function(directory, pollutant, id = 1:332) {
    #initialize the file directory set
    base <- 1000
    baseid <- base + id
    filenames <- substr(paste(as.character(baseid),".csv",sep=""),2,8)
    filedirs <- paste(directory,filenames,sep="/")
    #loop the file set and form the data 
    datapollutantsum <- c()
    for(file in filedirs){
        data <- read.csv(file)
        datapollutant <- data[[pollutant]]
        datapollutantsum <- c(datapollutantsum,datapollutant)
    }
    mean(datapollutantsum,na.rm=TRUE)
}