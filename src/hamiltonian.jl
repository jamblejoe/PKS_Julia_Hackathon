using Random, LinearAlgebra

function nn_hamiltonian(L, hopping, onsite)
    hamiltonian_arr = zeros(L, L)

    for i in 1:L
        # diagonal
        hamiltonian_arr[i, i] = onsite

        # off-diagonal
        hamiltonian_arr[i, (i+1)%L+1] = hopping
        hamiltonian_arr[(i+1)%L+1, i] = hopping
    end
    return hamiltonian_arr
end

function simple_hamiltonian(L, hopping, width, onsite; disorder_type = "site")
    hamiltonian_arr = nn_hamiltonian(L, hopping, onsite)
    if disorder_type == "site"
        for i in 1:L
            # diagonal
            hamiltonian_arr[i, i] = randn() * width
        end
    elseif disorder_type == "hopping"
        for i in 1:L
            hopping_magnitude = randn() * width
            hamiltonian_arr[i, (i+1)%L+1] = hopping_magnitude 
            hamiltonian_arr[(i+1)%L+1, i] = hopping_magnitude 
        end
    else 
        print("no disorder has been implemented")
    end
    return hamiltonian_arr
end

function quasiperiodic_hamiltonian(L, period, hopping, width, onsite; qp_type = "site")
    hamiltonian_arr = nn_hamiltonian(L, hopping, onsite)
    if qp_type == "site"
        for i in 1:L
            # diagonal
            hamiltonian_arr[i, i] = cos(2*pi*period*i) * width
        end
    elseif qp_type == "hopping"
        for i in 1:L
            hopping_magnitude = hopping+ cos(2*pi*period*i)  * width
            hamiltonian_arr[i, (i+1)%L+1] = hopping_magnitude 
            hamiltonian_arr[(i+1)%L+1, i] = hopping_magnitude 
        end
    else 
        print("no disorder has been implemented")
    end
    return hamiltonian_arr
end

function long_range(L::Int, power::Number, on_site::Number)
    hamiltonian_arr = Array{Float64}(undef, L, L)

    for i in 1:L

        # long-range coupling
        for j in 1:L
            dist = min(abs(i - j), abs(L - i) + j, abs(L - j) + i) #pbc
            hamiltonian_arr[i, j] = dist^(-power)

            hamiltonian_arr[i, i] = on_site
        end
    end

    return hamiltonian_arr
end;

function add_onsite_disorder(hamiltonian_array::Array, disorder)
    L = size(hamiltonian_array)[0]
    disordered_arr = hamiltonian_array
    for i in 1:L
        disordered_arr[i, i] = disordered_arr[i, i] + disorder * randn()
    end
    return disordered_arr
end


