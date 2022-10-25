# Linear code extraction

This git folder complete the article **Linear Code Extraction: Practice, Countermeasures, Proof-of-Concept on RISC-V**. It provides a simulation framework to simulate the execution of a code on core, and a FPGA-based proof of concept. Both are independent.

The chosen core is the cv32e40p, 4-stage in-order 32-bit RISC-V, representative of small ISA RISC-V cores and provided by [OpenHW Group](https://www.openhwgroup.org/).

The unprotected and protected cv32e40p descriptions are available in a [second git folder](https://github.com/anonymous-submission002/cv32e40p_rtl).

## Functional simulation framework

The **simulation** folder contains the simulation framework implemented to simulate the execution of a code on a the cv32e40p core. Linear Code Extraction can be performed during the execution. Countermeasures can be individually added to the core. This framework is based on the functional verification framework [CORE-V-VERIF](https://github.com/openhwgroup/core-v-verif) provided by OpenHW group. Codes executed are mainly taken from the free and open source benchmark suite [Embench](https://github.com/embench/embench-iot).

## FPGA-based proof of concept

The **fpga** folder contains the necessary to reproduce FPGA-based proof-of-concept of the Linear Code Extraction and the countermeasures. Firstly, an editing [CORE-V MCU](https://github.com/openhwgroup/core-v-mcu) microcontroller provided by OpenHW Group, is available. Secondly, a guide explains step-by-step methodology to perform a Linear Code Extraction on the microcontroller in the FPGA.
