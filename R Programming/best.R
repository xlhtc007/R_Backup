best <- function(state, outcome) {
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    if(!any(data$State == state)){
        stop("invalid state")
    }
    if(!any(c("heart attack","heart failure","pneumonia") == outcome)){
        stop("invalid outcome")
    }
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
}