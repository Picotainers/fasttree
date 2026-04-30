FROM debian:bookworm-slim

ARG FASTTREE_VERSION=v2.2.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gcc \
    make \
    libc6-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN set -eux; \
    curl -fsSL "https://raw.githubusercontent.com/morgannprice/fasttree/${FASTTREE_VERSION}/FastTree.c" -o FastTree.c; \
    gcc -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm; \
    install -m 0755 FastTree /usr/local/bin/fasttree

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/fasttree"]
