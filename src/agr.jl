using Statistics
# This is averaged over the spectrum but not yet disorder
function agr(evals::Vector{Float64})
    ratios = Vector{Float64}(undef, length(evals)-2)
    for i in 1:length(evals)-2
        level1 = evals[i+1] - evals[i]
        level2 = evals[i+2] - evals[i+1]
        if level1 < level2
            ratios[i] = level1/level2
        else
            ratios[i] = level2/level1
        end
    end
    return mean(ratios)
end
