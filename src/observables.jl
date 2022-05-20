"""
Module that computes observables.
"""

module Observables
export inverse_participation_ratio

"""
Computes the inverse participation ratio for a given set of eigenstates
eigenstates - an array with the eigenvectors as columns 
returns a vector with ipr for each eigenstate
"""
function inverse_participation_ratio(eigenstates)
    # N number of components of eigenstates = number of sites
    # n_eigs number of eigenstates 
     N, n_eigs = size(eigenstates) result = zeros(Float64, N)
     for i in 1:N
        for j in 1:n_eigs
            result[j] += abs(eigenstates[i,j])^4
     end
     return result

end

end