## Gem5 simulation environment with some external tools enabled

### Usage

1. Clone the repository
2. Build the Docker images

Just run the following command to build the Docker image.
```
docker-compose [--prfile riscv_devel] build [-e GEM5_VERSION=xxx] [-e ISA=xxx] [-e ENABLE_DRAMSIM3=1] [-e ENABLE_RAMULATOR2=1]
```
The profile option is optional. If you want to build the RISC-V cross compiling environment, you can add the profile option.

In addition, you can specify the gem5 version, ISA, and enable DRAMSim3 or Ramulator2 by setting the environment variables or the above -e options. The default values are as follows.

| Environment Variable | Default Value |
|----------------------|---------------|
| GEM5_VERSION         | v24.0.0.1    |
| ISA                  | X86          |
| ENABLE_DRAMSIM3      | 1 (enabled) |
| ENABLE_RAMULATOR2    | 1 (enabled) |

Thus, for RISC-5 simulation and development, you can run the following command.
```
docker-compose --profile riscv_devel build -e ISA=riscv
```

Please check gem5 repository for the available versions (tags).


3. Docker container run
```
docker-compose [--profile riscv_devel] up -d [-e GEM5_VERSION=xxx] [-e ISA=xxx]
```

4. Docker container attach
```
docker exec -it gem5_sim_container /bin/bash
```

5. Run the simulation
```
cd /work
# for DRAMSim3
/opt/gem5/build/X86/gem5.opt /opt/gem5/configs/example/se_dramsim3.py
# for Ramulator2
/opt/gem5/build/X86/gem5.opt /opt/gem5/configs/example/se_ramulator2.py
```


6. Visualize DRAMSim3 output
```
python3 /gem5/ext/dramsim3/DRAMsim3/scripts/plot_stats.py dramsim3.json
```