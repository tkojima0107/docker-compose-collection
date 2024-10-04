FROM ubuntu:22.04

LABEL "maintainer"="Takuya Kojima (tkojima@hal.ipc.i.u-tokyo.ac.jp)"

ARG DEBIAN_FRONTEND=noninteractive
ARG PREREQUISITES="autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev"
ARG RELEASE_VERSION="2024.09.03"

WORKDIR /tmp

RUN apt update && \
	apt install -y $PREREQUISITES && \
	git clone https://github.com/riscv/riscv-gnu-toolchain -b ${RELEASE_VERSION} && \
	cd riscv-gnu-toolchain && \
	./configure --prefix=/opt/riscv --enable-multilib && \
	make -j$(nproc) && \
	cd /tmp && \
	rm -rf /tmp/riscv-gnu-toolchain && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/riscv/bin:${PATH}"

ENTRYPOINT ["/bin/bash"]