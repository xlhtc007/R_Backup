rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    validState <- data$State == state
    if(!any(validState)){
        stop("invalid state")
    }
    validOutcome <- c("heart attack","heart failure","pneumonia") == outcome
    if(!any(validOutcome)){
        stop("invalid outcome")
    }
    ## Return hospital name in that state with the given rank 30-day death rate
    ##method 1:
#     dataSub <- data[validState,]
#     i <- c(11,17,23)[validOutcome]
#     outcomeValue <- as.numeric(dataSub[i][dataSub[i] != "Not Available"])
#     hospitalValue <- dataSub["Hospital.Name"][dataSub[i] != "Not Available"]
    
#     if(num == "best"){
#         num <- 1
#     }else if(num == "worst"){
#         num <- length(outcomeValue)
#     }
#     
#     if(num < 0 | num > length(outcomeValue)){
#         return(NA)
#     }
#     
#     value <- hospitalValue[rank(outcomeValue) == num]
    ##method 2:
    i <- c(11,17,23)[validOutcome]
    dataSub <- data[validState,][,c(2,i)]
    dataSub <- dataSub[dataSub[,2] != "Not Available",]
    dataSub <- dataSub[order(dataSub[,1]),]
    dataSub <- dataSub[order(as.numeric(dataSub[,2])),]
    
    if(num == "best"){
        num <- 1
    }else if(num == "worst"){
        num <- nrow(dataSub)
    }
    
    if(num < 0 | num > nrow(dataSub)){
        return(NA)
    }

    dataSub[num,1]
}