from utils import * 


def computeSSE(data, centers, clusterID):
    sse = 0 
    nData = len(data) 
    for i in range(nData):
        c = clusterID[i]
        sse += squaredDistance(data[i], centers[c]) 
        
    return sse 

def updateClusterID(data, centers):
    nData = len(data) 
    
    clusterID = [0] * nData

    # TODO
    # assign the closest center to each data point
    for i in range(len(clusterID)):
        min_square_distance_index = 0
        min_square_distance = squaredDistance(data[i], centers[0])
        for j in range(1, len(centers)):
            if min(squaredDistance(data[i], centers[j]), min_square_distance) < min_square_distance:
                min_square_distance_index = j
                min_square_distance = squaredDistance(data[i], centers[j])

        clusterID[i] = min_square_distance_index

    return clusterID

# K: number of clusters 
def updateCenters(data, clusterID, K):
    nDim = len(data[0])
    centers = [[0] * nDim for i in range(K)]

    elements_cluster = [0]*K

    # TODO recompute the centers based on current clustering assignment
    # If a cluster doesn't have any data points, in this homework, leave it to ALL 0s
    for i in range(len(clusterID)):
        elements_cluster[clusterID[i]] += 1
        for j in range(len(data[i])):
            centers[clusterID[i]][j] += data[i][j]

    for i in range(K):
        if elements_cluster[i] == 0:
            continue
        for j in range(len(centers[i])):
            centers[i][j] /= elements_cluster[i]

    return centers 

def kmeans(data, centers, maxIter = 100, tol = 1e-6):
    nData = len(data) 
    
    if nData == 0:
        return [];

    K = len(centers) 
    
    clusterID = [0] * nData
    
    if K >= nData:
        for i in range(nData):
            clusterID[i] = i
        return clusterID

    nDim = len(data[0]) 
    
    lastDistance = 1e100
    
    for iter in range(maxIter):
        clusterID = updateClusterID(data, centers) 
        centers = updateCenters(data, clusterID, K)
        
        curDistance = computeSSE(data, centers, clusterID) 
        if lastDistance - curDistance < tol or (lastDistance - curDistance)/lastDistance < tol:
            print "# of iterations:", iter 
            print "SSE = ", curDistance
            return clusterID
        
        lastDistance = curDistance
        
    print "# of iterations:", iter 
    print "SSE = ", curDistance
    return clusterID

