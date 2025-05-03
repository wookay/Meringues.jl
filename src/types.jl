# module Meringues

struct Syrup
    starch::Expr
    slurry::Union{Nothing, Symbol}
end

function Base.:(==)(lhs::Syrup, rhs::Syrup)::Bool
    lhs.starch == rhs.starch && lhs.slurry === rhs.slurry
end

# ≈  \approx<tab>
function Base.isapprox(lhs::Syrup, rhs::Syrup)::Bool
    lhs.starch ≈ rhs.starch && lhs.slurry === rhs.slurry
end

function Base.isapprox(lhs::Expr, rhs::Expr)::Bool
    Base.remove_linenums!(lhs) == Base.remove_linenums!(rhs)
end

# module Meringues
