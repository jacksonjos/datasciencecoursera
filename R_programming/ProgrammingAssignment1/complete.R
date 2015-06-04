complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        complete_cases <- data.frame(id = numeric(), nobs = numeric())

        for (file in id) {
                file_name <- paste(directory, "/", paste(rep("0", (3-nchar(file))), collapse=''), file, ".csv", sep = "")
                data <- read.csv(file_name)
                complete_cases[nrow(complete_cases)+1, ] <- c(file, sum(complete.cases(data)))
        } 
        complete_cases
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
}
