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

# ≈
function Base.isapprox(lhs::Syrup, rhs::Syrup)::Bool
    Base.remove_linenums!(lhs.starch) == Base.remove_linenums!(rhs.starch) &&
    lhs.slurry === rhs.slurry
end

end # module Meringues.Recipe
