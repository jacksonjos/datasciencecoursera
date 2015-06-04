# This function returns a character vector with the name
# of the hospital that has the ranking specified by the num argument
rankhospital <- function(state, outcome, num = "best") {
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

        if (num == "best") {
                num <- 1                
        }
        else if (num == "worst") {
                num <- nrow(new_data)       
        }
        else if (as.numeric(num) > nrow(new_data)) {
                # adiciona NA no nome do hospital e a sigla do estado correspondente
                return(NA)
        }

        # do ordering on data frame lines
        new_data <- new_data[order(new_data[, outcome_index], new_data[, "Hospital.Name"]), ]

        # learn how to change data frame variable name: to column type of disease name to 'Rate'
        # add data frame variable name called Rank and insert a number corresponding to its order
        colnames(new_data)[outcome_index] <- "Rate"
        new_data$Rank <- 1:nrow(new_data)

        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        new_data[num,"Hospital.Name"]
}