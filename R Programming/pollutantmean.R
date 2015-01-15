pollutantmean <- function(directory, pollutant, id = 1:332) {
    #构造文件路径的集合
    base <- 1000
    baseid <- base + id
    filenames <- substr(paste(as.character(baseid),".csv",sep=""),2,8)
    filedirs <- paste(directory,filenames,sep="/")
    #循环各个文件组装结果
    datapollutantsum <- c()
    for(file in filedirs){
        data <- read.csv(file)
        datapollutant <- data[[pollutant]]
        datapollutantsum <- c(datapollutantsum,datapollutant)
    }
    mean(datapollutantsum,na.rm=TRUE)
}