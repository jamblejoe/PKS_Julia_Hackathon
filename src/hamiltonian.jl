using Random, LinearAlgebra

function simple_hamiltonian(L, hopping, width, onsite)
    hamiltonian_arr = zeros(L,L)

    for i in 1:L
        # diagonal
        hamiltonian_arr[i,i] = randn()*width + onsite

        # off-diagonal
        hamiltonian_arr[i, (i+1)%L+1] = hopping
        hamiltonian_arr[(i+1)%L+1, i] = hopping
    end
    return hamiltonian_arr
end

