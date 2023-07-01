FROM ubuntu:20.04

ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH

WORKDIR $RISCV

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates tzdata sudo locales \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'Asia/Tokyo' >/etc/timezone

RUN apt install -y --no-install-recommends \
      autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
      gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev git

RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain

WORKDIR $RISCV/riscv-gnu-toolchain

RUN ./configure \
      --prefix=$RISCV \
      --with-arch=rv32imfd \
      --with-abi=ilp32 \
      --enable-multilib
RUN make -j

