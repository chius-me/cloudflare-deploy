FROM node:26.1.0-trixie

ARG WRANGLER_VERSION=latest

ENV CI=true \
    WRANGLER_SEND_METRICS=false \
    npm_config_update_notifier=false

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        curl \
        git \
        jq \
        openssh-client \
        pkg-config \
        python3 \
        unzip \
    && npm install -g "wrangler@${WRANGLER_VERSION}" corepack@latest \
    && corepack enable \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["wrangler", "--version"]
