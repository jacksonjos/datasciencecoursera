corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        corr_vector <- c()
        for (file_name in list.files(directory)) {
                data <- read.csv(paste(directory, "/", file_name, sep = ""))
                if (sum(complete.cases(data)) > threshold) {
                        corr_vector <- append(corr_vector, cor(data[,"nitrate"], data[,"sulfate"], use = "complete.obs"))
                }
        } 
        corr_vector
}
