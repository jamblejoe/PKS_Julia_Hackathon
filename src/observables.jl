"""
Module that computes observables.
"""


"""
Computes the inverse participation ratio for a given set of eigenstates
eigenstates - an array with the eigenvectors as columns 
returns a vector with ipr for each eigenstate
"""
function inverse_participation_ratio(eigenstates::AbstractArray{<:Number, 2})
    # N number of components of eigenstates = number of sites
    # n_eigs number of eigenstates 
    n_eigs = size(eigenstates,2)
    #print( N, n_eigs)
    #print(n_eigs,eigenstates)
    result = zeros(Float64, n_eigs)
    for (j, eigenstate) in enumerate(eachcol(eigenstates))
        result[j] = inverse_participation_ratio(eigenstate)
    end

    return result
end

function inverse_participation_ratio(eigenstate::AbstractArray{<:Number,1})
    return sum(x -> abs2(x)^2, eigenstate)
end

"""
Compute the q-th moment summed over all sites of a set of eigenstates. 
For q=2 the inverse participation ratio is recovered
"""
function wavefunction_moment(q::Number,eigenstates::AbstractArray{<:Number,2})
    # N number of components of eigenstates = number of sites
    # n_eigs number of eigenstates 
    N, n_eigs = size(eigenstates)
    #print( N, n_eigs)
    result = zeros(Float64, n_eigs)
    for (j, eigenstate) in enumerate(eachcol(eigenstates))
        result[j] = wavefunction_moment(q,eigenstate)
    end

    return result
end

function wavefunction_moment(q::Number,eigenstate::AbstractArray{<:Number,1})
    return sum(x -> abs2(x)^q, eigenstate)
end


function energy_resolution(energies, input, min_energy, max_energy; nbins=10)

    length(energies)==length(input) || error("Dimensions don't match")

    bin_size = (max_energy-min_energy)/(nbins)
    bins = LinRange(min_energy,max_energy,nbins)
    bins_counter = zeros(Int,nbins)
    result = zeros(nbins)

    en = energies[1]
    counter = 0
    for i in 1:length(energies)
        counter +=i
    end
end

