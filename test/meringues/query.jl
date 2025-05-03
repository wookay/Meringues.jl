module test_meringues_query

using Test
using Meringues

a = (; title = "hello")

query::Expr = :( article -> article.title )

struct Article
end

query::Expr = :( article::Article -> article.title )

end # module test_meringues_query
