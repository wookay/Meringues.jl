module test_meringues_syrup

using Test
using Meringues # Syrup

@test :( 1 + 2 ) == Expr(:call, :+, 1, 2)

maple_tree::Expr = :( 1 + 2 )
maple::Syrup = Syrup(maple_tree, nothing)
@test maple.starch == :( 1 + 2 )
@test maple.slurry === nothing
@test maple == Syrup(:( 1 + 2 ), nothing)

cocoa_powder = :( x -> x + 1 )
choco::Syrup = Syrup(cocoa_powder, nothing)
@test choco.starch ≈ :( x -> x + 1 )
@test choco ≈ Syrup(:( x -> x + 1 ), nothing)

end # module test_meringues_syrup
