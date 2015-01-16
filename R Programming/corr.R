corr <- function(directory, threshold = 0) {
    fileframe <- complete(directory)
    base <- 1000
    corrs <- c()
    for(i in 1:nrow(fileframe)){
        if(fileframe[i,2] > threshold){
            baseid <- base + i
            filename <- substr(paste(as.character(baseid),".csv",sep=""),2,8)
            filedir <- paste(directory,filename,sep="/")
            data <- read.csv(filedir)
            datasulfate <- data$sulfate
            datanitrate <- data$nitrate
            flags <- !is.na(datasulfate) & !is.na(datanitrate)
            corrs <- c(corrs,cor(datanitrate[flags],datasulfate[flags]))
        }
    }
    corrs
}