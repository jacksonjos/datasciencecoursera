from math import log, sqrt

def  purity(groundtruthAssignment, algorithmAssignment):

    purity = 0.0

    c_t = {}
    n = len(groundtruthAssignment)

    for k in range(n):
        i = algorithmAssignment[k]
        j = groundtruthAssignment[k]
        if c_t.has_key(i) is False:
            c_t[i] = {'t' + str(j): 1.}
        elif c_t[i].has_key('t' + str(j)) is False:
            c_t[i]['t' + str(j)] = 1.
        else:
            c_t[i]['t' + str(j)] += 1.
    # TODO  
    # Compute the purity
    for key in c_t:
        purity += max(c_t[key].values())

    purity /= n

    return purity 


def NMI(groundtruthAssignment, algorithmAssignment):

    NMI = 0
    # TODO
    # Compute the NMI
    n = len(groundtruthAssignment)

    indexes = {}
    index = 0
    for k in range(len(groundtruthAssignment)):
        i = algorithmAssignment[k]
        j = groundtruthAssignment[k]
        if indexes.has_key(i) is False:
            indexes[i] = index
            index += 1
        if indexes.has_key(j) is False:
            indexes[j] = index
            index += 1

    c_t_matrix = [[0]*len(indexes) for i in indexes]

    for k in range(len(groundtruthAssignment)):
        i = algorithmAssignment[k]
        j = groundtruthAssignment[k]
        c_t_matrix[indexes[i]][indexes[j]] += 1

    sum_c = [0]*len(indexes)
    sum_t = [0]*len(indexes)
    prob = [[0]*len(indexes) for i in indexes]
    for i in range(len(indexes)):
        for j in range(len(indexes)):
            sum_c[i] += c_t_matrix[i][j]
            sum_t[j] += c_t_matrix[i][j]
            prob[i][j] = c_t_matrix[i][j] / float(n)

    prob_c = [0]*len(indexes)
    prob_t = [0]*len(indexes)
    for i in range(len(indexes)):
        prob_c[i] = sum_c[i] / float(n)
        prob_t[i] = sum_t[i] / float(n)

    i_ct = 0
    for i in range(len(indexes)):
        for j in range(len(indexes)):
            # If probability prob[i][j] is zero we don't use it. Otherwise, we get log(0)
            if prob[i][j] != 0:
                i_ct += prob[i][j] * log(prob[i][j] / (prob_c[i] * prob_t[j]))

    h_c = 0
    for p_ci in prob_c:
        if p_ci > 0:
            h_c -= p_ci*log(p_ci)

    h_t = 0
    for p_ti in prob_t:
        if p_ti > 0:
            h_t -= p_ti*log(p_ti)

    NMI = i_ct/sqrt(h_c * h_t)

    return NMI

