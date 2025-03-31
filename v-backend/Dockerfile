FROM thevlang/vlang:latest


WORKDIR /app

COPY . .
ENV PORT=9000
EXPOSE 9000

ENTRYPOINT [ "v", "run", "server.v" ]
