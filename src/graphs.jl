using LinearAlgebra
using Graphs

function chain_graph(n; periodic=true)
    """Generate a path grah with n vertices and periodic boundary condition"""
    cg = path_graph(n)
    if periodic
        add_edge!(cg, 1, n)
    end
    return cg
end


function hamiltonian_from_graph(graph::Graph, E::Vector{<:Number}, V::Vector{<:Number})
    """Generate a hopping hailtonian on graph with on site potentials E and hoppings given by V"""
    numv = nv(graph)
    v_mat = zeros(numv, numv)
    for (i, edge) in enumerate(edges(graph))
        v_mat[src(edge), dst(edge)] = V[i]
        v_mat[dst(edge), src(edge)] = V[i]
    end

    e_mat = diagm(E)
    return e_mat + v_mat
end

function hamiltonian_from_graph(graph::Graph, E::Number, V::Number)
    """Generate a hopping hailtonian on graph with on site potentials E and hoppings given by V"""
    return hamiltonian_from_graph(graph,
        fill(E, nv(graph)),
        fill(V, ne(graph)))
end

function hamiltonian_from_graph(graph::Graph, E::Vector{<:Number}, V::Number)
    """Generate a hopping hailtonian on graph with on site potentials E and hoppings given by V"""
    return hamiltonian_from_graph(graph,
        E,
        fill(V, ne(graph)))
end

function hamiltonian_from_graph(graph::Graph, E::Number, V::Vector{<:Number})
    """Generate a hopping hailtonian on graph with on site potentials E and hoppings given by V"""
    return hamiltonian_from_graph(graph,
        fill(E, nv(graph)),
        V)
end


# function hamiltonian_from_graph(graph::Graph, Eamplitude::Number=1, V::Number=1)
#     return hamiltonian_from_graph(graph,
#         Eamplitude * rand(nv(graph), type(Eamplitude)),
#         fill(ne(graph), V))
# end

# function hamiltonian_from_graph(graph::Graph, E::Number=1, Vamplitude::Number=1)
#     return hamiltonian_from_graph(graph,
#         fill(nv(graph), E),
#         Vamplitude * rand(ne(graph), type(Vamplitude)))
# end