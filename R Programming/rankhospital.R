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
    dataSub <- data[validState,]
    i <- c(11,17,23)[validOutcome]
    outcomeValue <- as.numeric(dataSub[i][dataSub[i] != "Not Available"])
    hospitalValue <- dataSub["Hospital.Name"][dataSub[i] != "Not Available"]
    
    if(num == "best"){
        num <- 1
    }else if(num == "worst"){
        num <- length(outcomeValue)
    }
    
    if(num < 0 | num > length(outcomeValue)){
        return(NA)
    }
    
    value <- hospitalValue[rank(outcomeValue) == num]
    value
}