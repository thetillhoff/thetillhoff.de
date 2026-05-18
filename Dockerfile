FROM ghcr.io/thetillhoff/temingo:2.5.0 AS builder
COPY src src
RUN temingo

FROM caddy:2.11.2

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /workspace/output/ /usr/share/caddy/
