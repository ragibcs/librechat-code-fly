FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# The attached-worker build is intentionally installed at runtime.
# Pairing/enrollment is performed from LibreChat's Code Environments UI.
RUN npm install -g @librechat/code@latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV NODE_ENV=production

ENTRYPOINT ["/entrypoint.sh"]
