# syntax=docker/dockerfile:1

# build binary
FROM golang:1.17-alpine AS build-env
RUN apk --no-cache add build-base linux-headers
ADD . /src
WORKDIR /src
RUN go mod tidy
RUN go build -o /lukso-faucet

# final image ceration
FROM alpine
RUN apk --no-cache add libstdc++ libgcc
WORKDIR /app
COPY --from=build-env /lukso-faucet /app/lukso-faucet
EXPOSE 8080
ENTRYPOINT ["/app/lukso-faucet"]