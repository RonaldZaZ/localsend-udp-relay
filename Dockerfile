# --- builder ---
FROM alpine:3.20 AS builder
RUN apk add --no-cache git build-base linux-headers
WORKDIR /src
RUN git clone https://github.com/udp-redux/udp-broadcast-relay-redux.git .
RUN make

# --- runtime ---
FROM alpine:3.20
RUN adduser -D -H -s /sbin/nologin relay
WORKDIR /app
COPY --from=builder /src/udp-broadcast-relay-redux /usr/local/bin/udp-broadcast-relay-redux
USER relay
ENTRYPOINT ["/usr/local/bin/udp-broadcast-relay-redux"]
