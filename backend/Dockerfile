FROM julia:1.11

WORKDIR /app

COPY Project.toml Manifest.toml ./

RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate()'

COPY . .

EXPOSE 8000

CMD ["julia", "--project=.", "server.jl"]
