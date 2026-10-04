FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       git \
       python3 \
       python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone the official Code Interpreter source.
RUN git clone --depth 1 \
    https://github.com/LibreChat-AI/code-interpreter.git \
    /app/code-interpreter

WORKDIR /app/code-interpreter

# Install repository dependencies if package.json exists.
RUN if [ -f package.json ]; then npm install; fi

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV NODE_ENV=production

ENTRYPOINT ["/entrypoint.sh"]
