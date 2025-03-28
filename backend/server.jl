using Genie
using DotEnv

DotEnv.load!()

include("src/backend.jl")

Genie.config.server_host = "0.0.0.0"
if "PORT" in keys(ENV)
    Genie.config.server_port = parse(Int, ENV["PORT"]) 
else
    Genie.config.server_port = 8000
end
Genie.config.run_as_server = true

up()
