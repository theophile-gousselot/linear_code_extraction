vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_instr_instrlce_pc_rst/hdl/verilog" \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_instr_instrlce_pc_rst/hdl/verilog" \
"../../../../openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_instr_instrlce_pc_rst/sim/ila_instr_instrlce_pc_rst.v" \

vlog -work xil_defaultlib \
"glbl.v"

