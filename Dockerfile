FROM golang:1.24.9-alpine3.22 AS build

WORKDIR /app

## Download modules and store, this optimizes use of Docker image cache
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN mkdir -p bin && CGO_ENABLED=0 go build -o bin/mosquitto_exporter -ldflags="-s -w -X main.Version=0.8.0" .

FROM alpine:3.22.2
LABEL source_repository="https://github.com/molpie/mosquitto-exporter"

COPY --from=build /app/bin/mosquitto_exporter /mosquitto_exporter
RUN apk --no-cache add ca-certificates tzdata
EXPOSE 9234

ENTRYPOINT ["/mosquitto_exporter"]
