FROM ubuntu:22.04

RUN apt -y update && apt install -y git
RUN git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts /OpenROAD-flow-scripts
RUN /OpenROAD-flow-scripts/etc/DependencyInstaller.sh
RUN /OpenROAD-flow-scripts/build_openroad.sh --nice


 