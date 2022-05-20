"""
Module that computes observables.
"""

module Observables
export inverse_participation_ratio

"""
Computes the inverse participation ratio for a given eigenstate
eigenstate - a vector with complex entries
"""
function inverse_participation_ratio(eigenstate)
     result = 0.0
     for i in eigenstate
        result += abs(i)^4
     end
     return result

end

end