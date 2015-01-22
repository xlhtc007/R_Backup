best <- function(state, outcome) {
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
    ## Return hospital name in that state with lowest 30-day death rate
    dataSub <- data[validState,]
    i <- c(11,17,23)[validOutcome]
    validRate <- dataSub[i] != "Not Available"
    rsIndex <- dataSub[i] == min(dataSub[i][validRate],na.rm = TRUE)
    rs <- sort(dataSub["Hospital.Name"][rsIndex])
    rs[[1]]
}