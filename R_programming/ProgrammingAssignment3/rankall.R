rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", stringsAsFactors=FALSE, na.strings="Not Available")

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

        data <- data[ which( !is.na(data[, outcome_index])), ]

        # do ordering on data frame lines
        new_data <- data[ order(data[, "State"], data[, outcome_index], data[, "Hospital.Name"]), ]
        states <- unique(new_data[, "State"], na.rm=TRUE)
        states <- states[!is.na(states)]
        df <- data.frame(hospital=character(), state=character(), stringsAsFactors=FALSE)

        index <- num
        if (num == "best") {
                index <- 1      
        }
        for (state in states) {
                ## For each state, find the hospital of the given rank
                hospitals_state  <- new_data[ which(new_data[, "State"] == state), ]
                if (num == "worst") {
                        index <- nrow(hospitals_state)
                }
                line_vector <- c(hospitals_state[index, "Hospital.Name"], state)

                df[nrow(df)+1, ] <- line_vector
        }
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        df
}