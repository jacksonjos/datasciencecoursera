pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        means <- 0
        sum_non_null_lines <- 0
        for (file in id) {
                file_name <- paste(directory, "/", paste(rep("0", (3-nchar(file))), collapse=''), file, ".csv", sep = "")
                data <- read.csv(file_name)
                means <- means + sum(data[1:nrow(data), pollutant], na.rm = TRUE)
                sum_non_null_lines <- sum_non_null_lines + sum(!is.na(data[1:nrow(data), pollutant]))
        } 
        means / sum_non_null_lines
        ##mean(means)

        ## fazer média aritmética das médias de cada arquivo e ver no que dá


        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)

        ## NOTE: Do not round the result!
}
