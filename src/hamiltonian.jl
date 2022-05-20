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

function long_range(L::Int, power::Float64, on_site::Float64)
    hamiltonian_arr = Array{Float64}(undef, L, L) 
    
    for i in 1:L
        
        # long-range coupling
        for j in 1:L
            dist                 = min(abs(i-j), abs(L-i+j)) #pbc
            hamiltonian_arr[i,j] = dist^(-power)
        hamiltonian_arr[i,i] = on_site
        end
    end
    
    return hamiltonian_arr
end;