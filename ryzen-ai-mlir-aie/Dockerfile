FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
# Install dependencies
RUN apt update && apt install -y \
	gcc-13 g++-13 wget bzip2 flex make unzip file git \
	clang clang-14 lld lld-14 \
	python3-venv python3-pip libxrender1 libxtst6 libxi6 virtualenv \
	libopencv-dev python3-opencv \
	libboost-all-dev uuid-dev libboost-program-options1.74.0 libboost-filesystem1.74.0

WORKDIR /tmp

RUN wget https://cmake.org/files/v3.30/cmake-3.30.5-linux-x86_64.sh \
	&& mkdir /opt/cmake \
	&& sh cmake-3.30.5-linux-x86_64.sh --prefix=/opt/cmake --skip-license \
	&& rm cmake-3.30.5-linux-x86_64.sh

ENV PATH /opt/cmake/bin:${PATH}


WORKDIR /root

ENV MLIR_AIE_SRC_DIR=/root/mlir-aie
ENV MLIR_AIE_INSTALL_DIR=/opt/mlir-aie
ENV IRONENV_PATH=${MLIR_AIE_INSTALL_DIR}/ironenv
ENV IRONENV_PYTHON=${IRONENV_PATH}/bin/python3
ENV IRONENV_PIP=${IRONENV_PATH}/bin/pip

RUN mkdir -p ${MLIR_AIE_INSTALL_DIR} \
	&& python3.12 -m venv ${MLIR_AIE_INSTALL_DIR}/ironenv \
	&& ${IRONENV_PYTHON} -m pip install --upgrade pip \
	&& git clone --recurse-submodules https://github.com/Xilinx/mlir-aie.git \
	&& cd ${MLIR_AIE_SRC_DIR} \
	&& ${IRONENV_PIP} install pre-commit \
	&& cd ${MLIR_AIE_INSTALL_DIR} \
	&& ${IRONENV_PIP} download mlir_aie -f https://github.com/Xilinx/mlir-aie/releases/expanded_assets/latest-wheels/ \
	&& unzip -q mlir_aie-*_x86_64.whl \
	&& cd ${MLIR_AIE_INSTALL_DIR}/mlir_aie/python \
	&& ${IRONENV_PIP} download aie_python_bindings -f https://github.com/Xilinx/mlir-aie/releases/expanded_assets/latest-wheels/ \
	&& unzip -q -o aie_python_bindings*.whl \
	&& rm -rf *.whl \
	&& cd ${MLIR_AIE_INSTALL_DIR} \
	&& ${IRONENV_PIP} download mlir -f https://github.com/Xilinx/mlir-aie/releases/expanded_assets/mlir-distro/ \
	&& unzip -q mlir-*_x86_64.whl \
	&& ${IRONENV_PIP} -q download llvm-aie -f https://github.com/Xilinx/llvm-aie/releases/expanded_assets/nightly \
	&& unzip -q llvm_aie*.whl \
	&& rm -rf mlir*.whl \
	&& rm -rf llvm_aie*.whl \
	&& export PEANO_INSTALL_DIR=`realpath llvm-aie` \
	&& cd ${MLIR_AIE_SRC_DIR}/ \
	&& ${IRONENV_PIP} install -r python/requirements.txt \
	&& ${IRONENV_PATH}/bin/pre-commit install \
	&& HOST_MLIR_PYTHON_PACKAGE_PREFIX=aie ${IRONENV_PYTHON} -m pip install -r python/requirements_extras.txt \
	&& ${IRONENV_PIP} install -r python/requirements_ml.txt \
	&& bash utils/env_setup.sh my_install/mlir_aie my_install/mlir \
	&& ${IRONENV_PYTHON} -m ipykernel install --user --name ironenv \
	&& venv_site_packages=`python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])'` \
	&& echo ${MLIR_AIE_INSTALL_DIR}/python > $venv_site_packages/mlir-aie.pth

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
