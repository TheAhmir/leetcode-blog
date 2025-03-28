using Genie

include("src/backend.jl")

Genie.config.server_host = "0.0.0.0"
Genie.config.server_port = 8000
Genie.config.run_as_server = true

up()
