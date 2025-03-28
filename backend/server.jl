using Genie

include("src/backend.jl")

Genie.config.server_host = "0.0.0.0"
Genie.config.server_port = get(ENV, "PORT", "8000") |> parse(Int)
Genie.config.run_as_server = true

up()
