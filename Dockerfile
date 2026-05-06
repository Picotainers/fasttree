FROM debian:bookworm-slim AS builder

ARG FASTTREE_REF=v2.2.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gcc \
    libc6-dev \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/build
RUN set -eux; \
    curl -fsSL "https://raw.githubusercontent.com/morgannprice/fasttree/${FASTTREE_REF}/FastTree.c" -o FastTree.c; \
    gcc -O3 -finline-functions -funroll-loops -Wall -o fasttree FastTree.c -lm

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/build/fasttree /usr/local/bin/fasttree

RUN printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -e' \
    'if [ "${1:-}" = "fasttree" ]; then shift; fi' \
    'if [ "${1:-}" = "--help" ]; then set -- -help "${@:2}"; fi' \
    'exec /usr/local/bin/fasttree "$@"' \
    > /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["-help"]
