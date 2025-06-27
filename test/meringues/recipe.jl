using Jive
# syntax: type declarations on global variables are not yet supported
@If VERSION >= v"1.8" module test_meringues_recipe

using Test
using Meringues # Recipe Syrup

sugar::Expr = :( article -> article.title )
syrup = Recipe.dissolve(sugar)
@test syrup ≈ Syrup(:( article -> article.title ), nothing)

struct Article
end

sugar::Expr = :( article::Article -> article.title )
syrup = Recipe.dissolve(sugar)
@test Base.remove_linenums!(syrup.starch) == Base.remove_linenums!(:( article -> article.title ))
@test syrup.slurry === :Article
@test syrup ≈ Syrup(:( article -> article.title ), :Article)

sugar::Expr = :( article::Article -> article.title == "Hello" )
articles = [
    (; title = "Hello", tags = ("h",) ),
    (; title = "Old",   tags = ("o",) ),
    (; title = "World", tags = ("w",) ),
]
@test Recipe.findfirst(sugar, articles) == (; title = "Hello", tags = ("h",) )
@test Recipe.findlast(sugar, articles)  == (; title = "Hello", tags = ("h",) )
@test Recipe.findall(sugar, articles)   == [(; title = "Hello", tags = ("h",) )]

no_sugar = :( article -> article.title == "NO SUGAR" )
@test Recipe.findfirst(no_sugar, articles) === nothing
@test Recipe.findlast(no_sugar, articles)  === nothing
@test isempty(Recipe.findall(no_sugar, articles))

end # module test_meringues_recipe
