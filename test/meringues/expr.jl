module test_meringues_expr

using Test
using Meringues # Recipe ≈(::Expr, ::Expr)

expr = :( MIME"text/html" ) # line 6

ex = Base.remove_linenums!(copy(expr))
@test string(ex) == "MIME\"text/html\""
@test ex.args[2] == LineNumberNode(6, @__FILE__)
@test ex == Expr(:macrocall, Symbol("@MIME_str"), LineNumberNode(6, @__FILE__), "text/html")

ex = Recipe.remove_linenums!(copy(expr))
@test string(ex) == "MIME\"text/html\""
@test ex.args[2] === nothing
@test ex == Expr(:macrocall, Symbol("@MIME_str"), nothing, "text/html")

defs = quote
    Base.show(io::IO, m::MIME"text/html", dp::DatePicker)
    Base.get(dp::DatePicker)
    Bonds.initial_value(dp::DatePicker)
    Bonds.possible_values(dp::DatePicker)
    Bonds.transform_value(dp::DatePicker, val::Nothing)
    Bonds.transform_value(dp::DatePicker, val::Dates.TimeType)
    Bonds.transform_value(dp::DatePicker, val::String)
    Bonds.validate_value(dp::DatePicker, val::Union{Nothing, Dates.TimeType, String})
end
@test Recipe.remove_argument_names(defs) ≈ quote
    Base.show(::IO, ::MIME"text/html", ::DatePicker)
    Base.get(::DatePicker)
    Bonds.initial_value(::DatePicker)
    Bonds.possible_values(::DatePicker)
    Bonds.transform_value(::DatePicker, ::Nothing)
    Bonds.transform_value(::DatePicker, ::Dates.TimeType)
    Bonds.transform_value(::DatePicker, ::String)
    Bonds.validate_value(::DatePicker, ::Union{Nothing, Dates.TimeType, String})
end

end # module test_meringues_expr
