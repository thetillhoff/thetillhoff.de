FROM ghcr.io/thetillhoff/temingo:2.1.2 AS builder
COPY src src
RUN temingo

FROM caddy:2.10.2

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /workspace/output/ /usr/share/caddy/
