module test_meringues_expr

using Test
using Meringues # Recipe ≈(::Expr, ::Expr)

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
