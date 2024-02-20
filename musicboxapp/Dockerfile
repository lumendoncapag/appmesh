FROM golang:1.15.0-alpine3.12

RUN mkdir /app
COPY go.mod /app/
COPY go.sum /app/
COPY main.go /app/
WORKDIR /app

RUN go build -o main .

CMD ["/app/main"]