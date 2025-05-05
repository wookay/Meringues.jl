# module Meringues.Recipe

# ≈  \approx<tab>
function Base.isapprox(lhs::Syrup, rhs::Syrup)::Bool
    lhs.slurry === rhs.slurry &&
    lhs.starch ≈ rhs.starch
end

function Base.isapprox(lhs::Expr, rhs::Expr)::Bool
    left  = copy(lhs)
    right = copy(rhs)
    remove_linenums!(left) == remove_linenums!(right)
end


# Recipe.remove_linenums!
#
# from julia/base/expr.jl
function remove_linenums!(@nospecialize ex)
    if ex isa Expr
        if ex.head === :block || ex.head === :quote
            # remove line number expressions from metadata (not argument literal or inert) position
            filter!(ex.args) do x
                isa(x, Expr) && x.head === :line && return false
                isa(x, LineNumberNode) && return false
                return true
            end
        ### macrocall case
        elseif ex.head === :macrocall
            ex.args = map(ex.args) do subex
                isa(subex, LineNumberNode) ? nothing : subex
            end
        end
        for subex in ex.args
            subex isa Expr && remove_linenums!(subex)
        end
    elseif ex isa CodeInfo
        ex.debuginfo = Core.DebugInfo(ex.debuginfo.def) # TODO: filter partially, but keep edges
    end
    return ex
end

# Recipe.remove_argument_names
function remove_argument_names(lnn::LineNumberNode)::LineNumberNode
    lnn
end
function remove_argument_names(ex::Expr)::Expr
    if ex.head === :call
        exprs = map(ex.args[2:end]) do subex
            if subex isa Expr && subex.head === :(::) && length(subex.args) == 2
                Expr(:(::), subex.args[end])
            else
                subex
            end
        end
        Expr(:call, ex.args[1], exprs...)
    elseif ex.head === :block
        exprs = map(remove_argument_names, ex.args)
        Expr(:block, exprs...)
    else
        ex
    end
end

# module Meringues.Recipe
