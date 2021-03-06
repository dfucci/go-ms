FROM golang:1.9 as goimage
ENV SRC=/go/src/
RUN mkdir -p /go/src/
WORKDIR /go/src/go_docker
RUN git clone -b master — single-branch https://github.com/dfucci/go-ms.git  /go/src/go_docker/ \
&& CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -o bin/go_docker
FROM alpine:3.6 as baseimagealp
RUN apk add — no-cache bash
ENV WORK_DIR=/docker/bin
WORKDIR $WORK_DIR
COPY — from=goimage /go/src/go_docker/bin/ ./
ENTRYPOINT /docker/bin/go_docker
EXPOSE 8081
