## Gem5 simulation environment with some external tools enabled

1. Clone the repository
2. Preparing the Docker images
There are two options to build the Docker images. The first option is to build the Docker images on your own. The second option is to pull the pre-built Docker images from Docker Hub.

## Option 1: Build the Docker images on your own

Just run the following command to build the Docker image.
```
docker-compose [--prfile riscv_devel] build
```
The profile option is optional. If you want to build the RISC-V cross compiling environment, you can add the profile option.

In addition, you can specify the gem5 version, ISA, and enable DRAMSim3 or Ramulator2 by setting the environment variables. The default values are as follows.

| Environment Variable | Default Value |
|----------------------|---------------|
| GEM5_VERSION         | v24.0.0.1    |
| ISA                  | X86          |
| ENABLE_DRAMSIM3      | 1 (enabled) |
| ENABLE_RAMULATOR2    | 1 (enabled) |

Thus, for RISC-V simulation and development, you can run the following command.
```
ISA=RISCV docker-compose --profile riscv_devel build
```

Please check gem5 repository for the available versions (tags).

## Option 2: Pull the pre-built Docker images from Docker Hub
Depending on the build configuration explained in the previous section,
you can pull the pre-built Docker images from Docker Hub.
```
docker pull tkojima0107/gem5:[GEN5_VERSION]_[ISA]
```
All of the pre-built Docker images are enabled with DRAMSim3 and Ramulator2.

If you want to pull the pre-built Docker images for RISC-V cross compiling environment, you can run the following command.
```
docker pull tkojima0107/riscv_devel:latest
```

After pulling the pre-built Docker images, you have to tag the images as follows to work with the docker-compose.
```
docker tag tkojima0107/gem5:[GEN5_VERSION]_[ISA] gem5:[GEN5_VERSION]_[ISA]
```
For the RISC-V cross compiling environment, you have to tag the images as follows.
```
docker tag tkojima0107/riscv_devel:latest riscv_devel:latest
```

3. Docker container run
```
[ISA=xxx] [GEM5_VERSION=xxx] docker-compose [--profile riscv_devel] up -d
```

4. Docker container attach
```
docker exec -it gem5_sim_container /bin/bash
```

Similary, you can attach to the RISC-V cross compiling environment by running the following command.
```
docker exec -it gem5_sim_container_riscv /bin/bash
```

5. Example of running gem5 simulation
```
cd /work
# for DRAMSim3
/opt/gem5/build/X86/gem5.opt /opt/gem5/configs/example/se_dramsim3.py
# for Ramulator2
/opt/gem5/build/X86/gem5.opt /opt/gem5/configs/example/se_ramulator2.py
```

The both config files are hard-coded to use X86 ISA.
If you want to run the simulation with RISC-V ISA,
you have to change the CPU model and comment out some lines related to connecting interrupt controller and memory port.

## Appendix

### Compiling an application binary for RISC-V in SE mode simulation
In the RISC-V cross compiling environment,
```
riscv64-unknown-elf-gcc -static -o hello hello.c
```


### Visualize DRAMSim3 output
```
python3 /opt/gem5/ext/dramsim3/DRAMsim3/scripts/plot_stats.py dramsim3.json
```