FROM golang
RUN mkdir /pgbouncer_exporter
ADD . /pgbouncer_exporter

WORKDIR /pgbouncer_exporter

RUN go get -u github.com/hungerstation/pgbouncer_exporter && \
 go get -u github.com/prometheus/promu && \
 go get -u honnef.co/go/tools/cmd/staticcheck

RUN /go//bin/promu build --prefix /pgbouncer_exporter

ENTRYPOINT ["./pgbouncer_exporter"]