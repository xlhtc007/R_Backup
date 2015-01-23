rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    validOutcome <- c("heart attack","heart failure","pneumonia") == outcome
    if(!any(validOutcome)){
        stop("invalid outcome")
    }
    ## For each state, find the hospital of the given rank
    i <- c(11,17,23)[validOutcome]
    states <- unique(data$State)
    dataSub <- data[,c(2,i)]
    values <- NULL
    value <- c()
    index <- c()
    for(state in states){
        validState <- data$State == state
        
        dataRs <- dataSub[validState,]
        dataRs <- dataRs[dataRs[,2] != "Not Available",]
        dataRs <- dataRs[order(dataRs[,1]),]
        dataRs <- dataRs[order(dataRs[,2]),]
        
        if(num == "best"){
            index <- 1
        }else if(num == "worst"){
            index <- nrow(dataRs)
        }else{
            index <- num
        }
        
        if(index < 0 | index > nrow(dataRs)){
            value <- NA
        }else{
            value <- dataRs[index,1]
        }
        values <- rbind(values,c(hospital = value,state = state))
    }
    ## Return a data frame with the hospital names and the (abbreviated) state name
    values <- values[order(values[,2]),]
    as.data.frame(values)
}