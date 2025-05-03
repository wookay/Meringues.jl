module test_meringues_recipe

using Test
using Meringues # Recipe Syrup

sugar::Expr = :( article -> article.title )
syrup = Recipe.dissolve(sugar)
@test syrup ≈ Syrup(:( article -> article.title ), nothing)

struct Article
end

sugar::Expr = :( article::Article -> article.title )
syrup = Recipe.dissolve(sugar)
@test syrup.starch isa Expr
@test syrup.slurry === :Article
@test syrup ≈ Syrup(:( article -> article.title ), :Article)

end # module test_meringues_recipe
