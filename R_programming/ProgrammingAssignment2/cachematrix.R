## Put comments here that give an overall description of what your
## functions do

# This function takes as input an non-singular square matrix 'X' and returns an matrix object 'X'
# which has some functions to calculate the inverse matrix of 'X'.
makeCacheMatrix <- function(X = matrix()) {
        A_inverse <- NULL
        set <- function() {
                X <<- y
                A_inverse <<- NULL
        }
        get <- function() X
        setinverse_matrix <- function(solve) A_inverse <<- solve
        getinverse_matrix <- function() A_inverse
        list(set = set, get = get, setinverse_matrix = setinverse_matrix, getinverse_matrix = getinverse_matrix)
}


# This method returns the inverse matrix of 'X'. If the inverse of 'X' hasn't been calculated the method
# calculate inverse of 'X', stores the inverse of 'X' and returns it.
# If the inverse of 'X' was already calculated the method just gets the inverse of 'X' stored and returns it.
cacheSolve <- function(X, ...) {
        ## Return a matrix that is the inverse of 'x'
        A_inverse <- X$getinverse_matrix()
        if(!is.null(A_inverse)) {
                message("getting cached data")
                return(A_inverse)
        }
        data <- X$get()
        A_inverse <- solve(data, ...)
        X$setinverse_matrix(A_inverse)
        A_inverse
}
