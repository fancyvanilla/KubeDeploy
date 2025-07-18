FROM golang:alpine
WORKDIR /app
COPY . .
RUN go build -o server main.go
CMD ["./server"]
EXPOSE 8080