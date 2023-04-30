start_gui
open_hw_manager
connect_hw_server -url localhost:3121 -allow_non_jtag
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/210276AEF6A5B]
set_property PARAM.FREQUENCY 3750000 [get_hw_targets */xilinx_tcf/Digilent/210276AEF6A5B]
open_hw_target
current_hw_device [get_hw_devices xc7a200t_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7a200t_0] 0]
set_property PROBES.FILE {core-v-mcu_lce_demo.ltx} [get_hw_devices xc7a200t_0]
set_property FULL_PROBES.FILE {core-v-mcu_lce_demo.ltx} [get_hw_devices xc7a200t_0]
set_property PROGRAM.FILE {core-v-mcu_lce_demo.bit} [get_hw_devices xc7a200t_0]

program_hw_devices [get_hw_devices xc7a200t_0]
refresh_hw_device [lindex [get_hw_devices xc7a200t_0] 0]

display_hw_ila_data [ get_hw_ila_data hw_ila_data_1 -of_objects [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]]

set_property TRIGGER_COMPARE_VALUE eq1'bR [get_hw_probes i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/rst_ni -of_objects [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]]
run_hw_ila [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]

set_property CONTROL.TRIGGER_POSITION 8 [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]
run_hw_ila [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]
wait_on_hw_ila [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]
display_hw_ila_data [upload_hw_ila_data [get_hw_ilas -of_objects [get_hw_devices xc7a200t_0] -filter {CELL_NAME=~"i_core_v_mcu/i_soc_domain/fc_subsystem_i/lFC_CORE/ila_instr_instrlce_pc_rst_0"}]]
