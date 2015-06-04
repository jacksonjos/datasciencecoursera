from utils import * 
from math import exp

def kernel(data, sigma):
    nData = len(data)
    Gram = [[0] * nData for i in range(nData)] 
    # TODO
    # Calculate the Gram matrix 
    sigma_square = pow(sigma, 2)

    for i in range(nData):
        Gram[i][i] = 1
        for j in range(i+1, nData):
            sum_squares = 0
            for k in range(len(data[i])):
                sum_squares += pow((data[i][k] - data[j][k]), 2)

            Gram[j][i] = exp( -(sum_squares/(2. * sigma_square)) )
            Gram[i][j] = exp( -(sum_squares/(2. * sigma_square)) )

    return Gram