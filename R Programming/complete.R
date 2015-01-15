complete <- function(directory, id = 1:332) {
    #initialize the file directory set
    base <- 1000
    baseid <- base + id
    filenames <- substr(paste(as.character(baseid),".csv",sep=""),2,8)
    filedirs <- paste(directory,filenames,sep="/")
    #loop the file set and form the data 
    rs <- NULL
    for(i in 1:length(filedirs)){
        data <- read.csv(filedirs[[i]])
        datasulfate <- data$sulfate
        datanitrate <- data$nitrate
        datanitratesub <- datanitrate[!is.na(datasulfate)]
        datanitratesubrs <- datanitratesub[!is.na(datanitratesub)]
        rs <- rbind(rs,c(i,length(datanitratesubrs)))
    }
    rs
}