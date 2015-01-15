pollutantmean <- function(directory, pollutant, id = 1:332) {
    #�����ļ�·���ļ���
    base <- 1000
    baseid <- base + id
    filenames <- substr(paste(as.character(baseid),".csv",sep=""),2,8)
    filedirs <- paste(directory,filenames,sep="/")
    #ѭ�������ļ���װ���
    datapollutantsum <- c()
    for(file in filedirs){
        data <- read.csv(file)
        datapollutant <- data[[pollutant]]
        datapollutantsum <- c(datapollutantsum,datapollutant)
    }
    mean(datapollutantsum,na.rm=TRUE)
}