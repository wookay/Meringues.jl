# module Meringues

struct Syrup
    starch::Expr
    slurry::Union{Nothing, Symbol}
end

function Base.:(==)(lhs::Syrup, rhs::Syrup)::Bool
    lhs.starch == rhs.starch && lhs.slurry === rhs.slurry
end

# module Meringues
