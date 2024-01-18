
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -o main .

FROM alpine
COPY --from=builder /app/main /main
COPY --from=builder /app/profile.html /profile.html
COPY --from=builder /app/jeremypic.png /jeremypic.png
COPY --from=builder /app/jeremycoando_sre_devops_2023.pdf /jeremycoando_sre_devops_2023.pdf

# Expose the port the app runs on
EXPOSE 8080

# Run the binary
CMD ["/main"]
