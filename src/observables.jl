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


function binned_average(x::AbstractArray{<:Real, 1}, y::AbstractArray{<:Number, 1}, bins::AbstractArray{<:Real, 1})

    length(x)==length(y) || error("Dimensions don't match")

    first_x_in_bins_idx = findfirst(x -> x > bins[1], x)
    first_x = x[first_x_in_bins_idx]
    first_bin_idx = findfirst(x -> x > first_x, bins) - 1  # bins[first_bin_idx] < first_x < bins[first_bin_idx + 1]

    bin_idx = first_bin_idx
    binned_y = zeros(length(bins) - 1)
    num_vals = 0
    for (x_el, y_el) in zip(x[first_x_in_bins_idx:end], y[first_x_in_bins_idx:end])
        if x_el > bins[bin_idx + 1]
            binned_y[bin_idx] /= num_vals
            bin_idx += 1
            num_vals = 0
            if bin_idx == length(bins)
                break
            end
        end
        binned_y[bin_idx] += y_el
        num_vals += 1
    end
  
    return binned_y
end

function binned_average(x::AbstractArray{<:Real, 1}, y::AbstractArray{<:Number, 1}, minx::Real, maxx::Real, nbins::Integer)
    return binned_average(x, y, LinRange(minx, maxx, nbins))
end