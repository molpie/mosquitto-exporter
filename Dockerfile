FROM scratch
LABEL source_repository="https://github.com/jryberg/mosquitto-exporter"

COPY mosquitto_exporter /mosquitto_exporter

EXPOSE 9234

ENTRYPOINT [ "/mosquitto_exporter" ]
