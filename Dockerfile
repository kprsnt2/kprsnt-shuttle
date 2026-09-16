# Build stage
FROM rust:1.83-slim AS builder
WORKDIR /app

# Cache dependencies
COPY Cargo.toml ./
RUN mkdir src && echo "fn main() {}" > src/main.rs && cargo build --release && rm -rf src

# Copy source code and build
COPY src ./src
RUN touch src/main.rs && cargo build --release

# Runtime stage
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy compiled binary
COPY --from=builder /app/target/release/kprsnt-shuttle /app/kprsnt-shuttle

# Copy runtime assets needed by the app
COPY templates ./templates
COPY static ./static
COPY data ./data
COPY blog_data ./blog_data
COPY job_data ./job_data
COPY AI_Eco_Blogs ./AI_Eco_Blogs

# Cloud Run sets PORT automatically (defaults to 8080)
ENV PORT=8080
EXPOSE 8080

CMD ["/app/kprsnt-shuttle"]
