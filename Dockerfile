FROM scratch
LABEL source_repository="https://github.com/jryberg/mosquitto-exporter"

COPY  mosquitto-exporter /mosquitto_exporter

EXPOSE 9234

ENTRYPOINT ["/mosquitto_exporter"]
