FROM ghcr.io/gem5/ubuntu-22.04_all-dependencies:latest

LABEL "maintainer"="Takuya Kojima (tkojima@hal.ipc.i.u-tokyo.ac.jp)"
LABEL "description"="Docker image for gem5 with or without DRAMSim3, Ramulator2"

ARG BUILD_ISA=X86
ARG GEM5_VERSION=stable
ARG ENABLE_DRAMSIM3=1
ARG ENABLE_RAMULATOR2=1

RUN pip3 install numpy matplotlib

RUN cd /opt && \
	git clone https://github.com/gem5/gem5 && \
	cd gem5 && \
	git checkout ${GEM5_VERSION}


COPY ./ramulator2_files/ext_SConscript /tmp
COPY ./ramulator2_files/src_SConscript_patch /tmp
COPY ./ramulator2_files/gem5_example_config.yaml /tmp
COPY ./configs/se_dramsim3.py /tmp
COPY ./configs/se_ramulator2.py /tmp

RUN if [ ${ENABLE_DRAMSIM3} -eq 1 ]; then \
		cd /opt/gem5/ext/dramsim3/; \
		git clone  https://github.com/umd-memsys/DRAMsim3; \
		cd DRAMsim3; \
		mkdir build; \
		cd build; \
		cmake ..; \
		make -j$(nproc); \
		cp /tmp/se_dramsim3.py /opt/gem5/configs/example/; \
		cd /opt/gem5/; \
	fi && \
	if [ ${ENABLE_RAMULATOR2} -eq 1 ]; then \
		mkdir -p /opt/gem5/ext/ramulator2; \
		cd /opt/gem5/ext/ramulator2; \
		git clone https://github.com/CMU-SAFARI/ramulator2; \
		cd ramulator2; \
		mkdir build; \
		cd build; \
		cmake ..; \
		make -j$(nproc); \
		cp /tmp/ext_SConscript /opt/gem5/ext/ramulator2/SConscript; \
		cat /tmp/src_SConscript_patch >> /opt/gem5/src/mem/SConscript; \
		cp /opt/gem5/ext/ramulator2/ramulator2/resources/gem5_wrappers/* /opt/gem5/src/mem/; \
		cp /tmp/gem5_example_config.yaml /opt/gem5/ext/ramulator2/ramulator2/; \
		cp /tmp/se_ramulator2.py /opt/gem5/configs/example/; \
	fi && \
	cd /opt/gem5 && \
	scons build/${BUILD_ISA}/gem5.opt -j$(nproc) && \
	rm -f /tmp/*

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]




