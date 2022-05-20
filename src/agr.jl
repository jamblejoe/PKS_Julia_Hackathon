using Statistics
function agr(eigvals::Vector{Float64})
    ratios = Vector{Float64}(undef, length(eigvals)-1)
    for i in 1:length(eigvals)-1
        level1 = eigvals[i]
        level2 = eigvals[i+1]
        if level1 < level2
            ratios[i] = level1/level2
        else
            ratios[i] = level2/level1
        end
    end
    return mean(ratios)
end
