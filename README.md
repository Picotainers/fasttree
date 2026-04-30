# fasttree

Minimal container for FastTree.

## Quick Usage

```bash
docker run --rm docker.io/picotainers/fasttree:latest -help
```

## Usage

```bash
docker run --rm -v "$(pwd):/data" -w /data docker.io/picotainers/fasttree:latest -nt alignment.fasta > tree.nwk
```

## Building

```bash
docker build -t docker.io/picotainers/fasttree:latest .
```
