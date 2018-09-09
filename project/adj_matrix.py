from scipy import spatial
from spatial.distance import squarelike, pdist

def make_adj_matrix(points):
    return squarelike(pdist(points))