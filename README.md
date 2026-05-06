# fasttree
Small source-built container for `fasttree`.

## Quick Usage

```bash
# Pull the image
docker pull docker.io/picotainers/fasttree:latest

# Run the tool
docker run --rm docker.io/picotainers/fasttree:latest -help
```

## Usage with input files

```bash
docker run --rm -v "$(pwd):/data" docker.io/picotainers/fasttree:latest -help
```
