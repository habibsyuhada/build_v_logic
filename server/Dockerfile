# Build from the MONOREPO ROOT (not server/), since server/ depends on the
# local workspace packages content_schema and sim_core:
#   docker build -f server/Dockerfile .

# Build stage
FROM dart:3.9 AS build

WORKDIR /app
# Only the workspace members server/ actually depends on, plus the
# workspace manifest itself — keeps the build context small without
# resorting to a synthetic pubspec.yaml (which would drift from the real
# one every time a dependency changes).
COPY pubspec.yaml pubspec.lock ./
COPY packages/content_schema packages/content_schema
COPY packages/sim_core packages/sim_core
COPY packages/shared_models packages/shared_models
COPY server server
RUN dart pub get

WORKDIR /app/server
RUN dart compile exe bin/main.dart -o bin/server

# Add a fallback for the copy of possibly missing directories.
RUN mkdir -p config web migrations content

# Final stage
FROM alpine:latest
WORKDIR /app

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/server/bin/server server

# Copy configuration files and resources
COPY --from=build /app/server/config/ config/
COPY --from=build /app/server/web/ web/
COPY --from=build /app/server/migrations/ migrations/
COPY --from=build /app/server/content/ content/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role
