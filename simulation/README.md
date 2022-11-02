# Simulation framework

The simulation framework is based on the functional verification framework [CORE-V-VERIF](https://github.com/openhwgroup/core-v-verif). CORE-V-VERIF was edited to simulate the performing of a Linear Code Extraction on a protected or unprotected cv32e40p core.


## Organization

The framework is organized from 3 folders :
- **core-v-verif** : edited core-v-verif project to simulate execution.
- **scripts** : scripts to run execution simulations and analysed their outputs.
- **log** : destination of simulation output analysis


## Getting Started

### Installation

To simulate code execution, please follow these instructions :

1. Verify your python modules
   ```sh
   cd core-v-verif/bin
   pip install -r requirements.txt
   ```

2. Install a [CORE-V RISC-V toolchain](https://www.embecosm.com/resources/tool-chain-downloads/#corev). The recommended installation path is `/opt/corev`. Set RISCV shell variable to your toolchain and add its `bin` folder to your `PATH`.
   ```sh
   export RISCV=/opt/corev
   export PATH="/opt/corev/bin:$PATH"
   ```

3. Install [Verilator](https://veripool.org/guide/latest/install.html).

4. Your setup is ready ! Visit [README](scripts/README.md) in `scripts` folder to simulate code execution
   ```sh
   cd scripts
   ```
