vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu -sv "+incdir+../../../../openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_instr_instrlce_pc_rst/hdl/verilog" \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu "+incdir+../../../../openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_instr_instrlce_pc_rst/hdl/verilog" \
"../../../../openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_instr_instrlce_pc_rst/sim/ila_instr_instrlce_pc_rst.v" \

vlog -work xil_defaultlib \
"glbl.v"

