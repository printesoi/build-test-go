# syntax = docker/dockerfile:1.3

# First stage: install ca certificates (we need this since AWS SDK needs the
# CA certificates to verify requests
FROM alpine:3 as alpine

RUN apk add -U --no-cache ca-certificates

# Second stage: builder
FROM golang:1.22 AS builder

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download

# Copy the code into the container
COPY . .

RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    go build -v -o /build/build-test .

FROM scratch

COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /build/build-test /usr/local/bin/

# Command to run
ENTRYPOINT ["/usr/local/bin/build-test"]
