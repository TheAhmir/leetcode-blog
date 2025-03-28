FROM julia:1.11-alpine

WORKDIR /app

COPY Project.toml Manifest.toml ./

RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate()'

COPY . .

# ENV PORT=9000

EXPOSE 8000

ENV JULIA_NUM_THREADS=2

CMD ["julia", "--project=.", "--startup-file=no", "server.jl"]
