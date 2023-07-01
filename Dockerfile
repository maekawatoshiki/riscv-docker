FROM ubuntu:20.04

ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH

WORKDIR $RISCV

RUN apt update
RUN apt install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
RUN apt install -y git

RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain

RUN cd riscv-gnu-toolchain && ./configure --prefix=/opt/riscv --with-arch=rv32imfd --with-abi=ilp32 --enable-multilib && make -j

# WORKDIR /work

