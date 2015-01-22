rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    validOutcome <- c("heart attack","heart failure","pneumonia") == outcome
    if(!any(validOutcome)){
        stop("invalid outcome")
    }
    ## For each state, find the hospital of the given rank
    states <- unique(data$State)
    values <- c()
    for(state in states){
        validState <- data$State == state
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
            value <- NA
        }else{
            value <- hospitalValue[rank(outcomeValue) == num]
        }
        
        values <- rbind(values,list(hospital = value,state = state))
    }
    ## Return a data frame with the hospital names and the (abbreviated) state name
    as.data.frame(values)
}