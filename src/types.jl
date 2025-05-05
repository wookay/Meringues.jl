# module Meringues

struct Syrup
    starch::Expr
    slurry::Union{Nothing, Symbol}
end

function Base.:(==)(lhs::Syrup, rhs::Syrup)::Bool
    lhs.slurry === rhs.slurry &&
    lhs.starch == rhs.starch
end

# module Meringues
