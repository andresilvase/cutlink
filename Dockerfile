FROM golang:1.23.2

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o app ./cmd

EXPOSE 1818

CMD ["./app"]