from scipy import spatial

def make_adj_matrix(points):
    return spatial.distance.squareform(spatial.distance.pdist(points))