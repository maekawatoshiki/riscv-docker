#/bin/sh -eux

export DOCKER_BUILDKIT=1

docker build \
  -t riscv:latest \
  -f Dockerfile \
  .
docker run \
  --mount "type=bind,src=/etc/passwd,dst=/etc/passwd,readonly" \
  --mount "type=bind,src=/etc/group,dst=/etc/group,readonly" \
  -u $(id -u $USER) \
  -v "$(pwd):/work" \
  -w "/work" \
  --rm \
  -it \
  riscv:latest
