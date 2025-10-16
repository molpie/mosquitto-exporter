FROM golang:1.24.9-alpine3.22 AS build

WORKDIR /go/src/app

## Download modules and store, this optimizes use of Docker image cache
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN make build

FROM alpine:3.22.2
LABEL source_repository="https://github.com/molpie/mosquitto-exporter"

COPY --from=build /go/src/app/bin/mosquitto_exporter /mosquitto_exporter
RUN apk --no-cache add ca-certificates tzdata
EXPOSE 9234

ENTRYPOINT ["/mosquitto_exporter"]
