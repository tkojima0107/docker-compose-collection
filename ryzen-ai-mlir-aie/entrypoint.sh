#!/bin/bash

# Start-up message
echo """
========================================
Welcome to the MLIR-AIE Docker container
========================================
"""

# Setting up XRT
source /opt/xilinx/xrt/setup.sh

# Setting up Vitis tools
export XILIINX_LOC=/tools/Xilinx/Vitis/${VITIS_VERSION}
if [ ! -d ${XILIINX_LOC} ]; then
	echo -e "\033[31mERROR\033[m: Xilinx Vitis not found at ${XILIINX_LOC}"
fi
export AIETOOLS_ROOT=${XILIINX_LOC}/aietools
export PATH=${PATH}:${AIETOOLS_ROOT}/bin

# Activating Iron environment
source ${IRONENV_PATH}/bin/activate

# Setting up MLIR-AIE
source ${MLIR_AIE_SRC_DIR}/utils/env_setup.sh ${MLIR_AIE_INSTALL_DIR}/mlir_aie ${MLIR_AIE_INSTALL_DIR}/mlir ${MLIR_AIE_INSTALL_DIR}/llvm-aie

if [ $# -eq 0 ]; then
	/bin/bash
else
	exec "$@"
fi