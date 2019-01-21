FROM golang as builder

RUN go get -u github.com/prometheus/promu && \
 go get -u honnef.co/go/tools/cmd/staticcheck

RUN mkdir /go/src/pgbouncer_exporter

WORKDIR /go/src/pgbouncer_exporter

COPY *.go ./
COPY VERSION .
COPY .promu.yml .

RUN go get -d ./...

RUN /go/bin/promu build --prefix /pgbouncer_exporter

FROM debian

RUN apt-get update -yy && \
 apt-get install -yy postgresql-client

COPY --from=builder /pgbouncer_exporter/pgbouncer_exporter /pgbouncer_exporter

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]