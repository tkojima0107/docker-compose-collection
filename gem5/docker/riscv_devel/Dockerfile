FROM ubuntu:22.04

LABEL "maintainer"="Takuya Kojima (tkojima@hal.ipc.i.u-tokyo.ac.jp)"

ARG DEBIAN_FRONTEND=noninteractive
ARG PREREQUISITES="autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev"
# As of gem5 v24.0.0.1, executables for linux cannot be simulated with glibc 2.38 or later due to riscv_hwprobe system call.
ARG RELEASE_VERSION="2023.10.12"

WORKDIR /tmp

RUN apt update && \
	apt install -y $PREREQUISITES && \
	git clone https://github.com/riscv/riscv-gnu-toolchain -b ${RELEASE_VERSION} && \
	cd riscv-gnu-toolchain && \
	./configure --prefix=/opt/riscv --enable-multilib && \
	make -j$(nproc) && \
	make -j$(nproc) linux && \
	cd /tmp && \
	rm -rf /tmp/riscv-gnu-toolchain && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/riscv/bin:${PATH}"

WORKDIR /work

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
