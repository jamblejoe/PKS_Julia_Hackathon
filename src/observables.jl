"""
Module that computes observables.
"""


"""
Computes the inverse participation ratio for a given set of eigenstates
eigenstates - an array with the eigenvectors as columns 
returns a vector with ipr for each eigenstate
"""
function inverse_participation_ratio(eigenstates)
    # N number of components of eigenstates = number of sites
    # n_eigs number of eigenstates 
     N, n_eigs = size(eigenstates)
     #print( N, n_eigs)
     result = zeros(Float64, n_eigs)
     for i in 1:N
        for j in 1:n_eigs
            result[j] += abs(eigenstates[i,j])^4
        end
     end
     return result

end
"""
function energy_resolution(energies; boundaries, nbins=10)
    min_energy, max_energy = boundaries
    bin_size = (max_energy-min_energy)/(nbins-2)
    bins = []



end
"""
