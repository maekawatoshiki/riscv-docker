#/bin/sh -eux

export DOCKER_BUILDKIT=1

docker build -t riscv:latest -f Dockerfile .
docker run -v "$(pwd):/work" -w "/work" --rm -it riscv:latest
