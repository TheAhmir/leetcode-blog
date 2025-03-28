using Pkg, JSON
using Genie, Genie.Requests

include("./utils/functions.jl")

Genie.config.cors_allowed_origins = ["*"]

root_dir = abspath(@__DIR__, "..")  # Get project root from src/
posts_dir = joinpath(root_dir,"src", "posts")

posts = load_posts()

route("/") do
    "Hello World LEAH"
end


route("/posts") do
    return json(posts)
end

route("/posts/:post_id") do
    return json(posts[payload(:post_id)])
end
