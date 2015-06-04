# This function reads the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
# in that state.
best <- function(state, outcome) {

        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", stringsAsFactors=FALSE, na.strings="Not Available")

        ## Check that state and outcome are valid
        # check if state exists and if it doesn't it calls stop("invalid state")
        if (state %in% data$State == FALSE) {
                stop("invalid state")
        }

        # possible outcomes
        # 11. Hospital 30-Day Death (Mortality) Rates from Heart Attack: Lists the risk adjusted rate (percentage) for each hospital.
        # 17. Hospital 30-Day Death (Mortality) Rates from Heart Failure: Lists the risk adjusted rate (percentage) for each hospital.
        # 23. Hospital 30-Day Death (Mortality) Rates from Pneumonia: Lists the risk adjusted rate (percentage) for each hospital.
        # removing exceding spaces around the words
        outcome <- gsub('^\\s+|\\s+$', "", tolower(outcome))
        outcome <- gsub('\\s+', " ", outcome)
        outcomes <- c(11,17,23)
        outcome_index <- NULL
        outcome_found = FALSE
        for (i in outcomes) {
                outcome_name <- gsub('.*from.', "", tolower(names(data)[i]))
                if (outcome == gsub('\\.|\\s+', " ", outcome_name)){
                        outcome_found = TRUE
                        outcome_index <- i
                        break
                }
        }
        # check if state exists and if it doesn't it calls stop("invalid outcome")
        if (outcome_found == FALSE) {
                stop("invalid outcome")
        }

        #  subset the set of hospitals to select just between those which criteria has non NA values
        new_data <- data[ which( !is.na(data[, outcome_index]) & (data[, "State"] == state)), ]
        #  get min(value) and its index to find the best hospital
        hospitals_min_mortality_list <- new_data[which(new_data[,outcome_index] == min(new_data[,outcome_index])),]
        sorted_hospitals_by_name <- hospitals_min_mortality_list[order("Hospital.Name"),]


        ## Return hospital name in that state with lowest 30-day death
        ## outcomes can be "heart attack", "heart failure", or "pneumonia"
        ## rate
        hospital <- sorted_hospitals_by_name[1,"Hospital.Name"]
        as.character(hospital)
}