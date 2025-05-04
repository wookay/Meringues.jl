module Recipe # Meringues

using ..Meringues: Syrup

function dissolve(sugar::Expr)::Syrup
    granules::Union{Symbol, Expr} = sugar.args[1]
    if granules isa Symbol
        granule = granules
        slurry = nothing
    elseif granules isa Expr
        @assert granules.head === :(::)
        (granule, slurry) = granules.args
    else
        granule = Expr(:block)
        slurry = nothing
    end
    starch = Expr(:->, granule, sugar.args[2])
    Syrup(starch, slurry)
end

function findall(sugar::Expr, rack::Vector{T})::Vector{T} where T <: NamedTuple
    f_expr = :(Base.findall)
    syrup = dissolve(sugar)
    find_expr = Expr(:call, f_expr, syrup.starch, rack)
    idxs::Vector{Int} = Core.eval(@__MODULE__, find_expr)
    return getindex(rack, idxs)
end

function _find(f_expr::Expr, sugar::Expr, rack::Vector{T})::Union{Nothing, T} where T <: NamedTuple
    syrup = dissolve(sugar)
    find_expr = Expr(:call, f_expr, syrup.starch, rack)
    idx::Union{Nothing, Int} = Core.eval(@__MODULE__, find_expr)
    if idx === nothing
        return nothing
    else
        return getindex(rack, idx)
    end
end

function findfirst(sugar::Expr, rack::Vector{T})::Union{Nothing, T} where T <: NamedTuple
    f_expr::Expr = :(Base.findfirst)
    return _find(f_expr, sugar, rack)
end

function findlast(sugar::Expr, rack::Vector{T})::Union{Nothing, T} where T <: NamedTuple
    f_expr::Expr = :(Base.findlast)
    return _find(f_expr, sugar, rack)
end

include("expr.jl")

end # module Meringues.Recipe
