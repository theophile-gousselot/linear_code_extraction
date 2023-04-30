// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Tue Mar  7 15:34:30 2023
// Host        : jason running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/theophile/these/these_theophile_gousselot/lce/fpga/demonstrator/vivado_projects/build/core-v-mcu-nexys-video_ila-instr_rdata_vio-rst/nexys-a7-100t-vivado/openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_cpu_reset/ila_cpu_reset_stub.v
// Design      : ila_cpu_reset
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2022.1" *)
module ila_cpu_reset(clk, probe0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0]" */;
  input clk;
  input [0:0]probe0;
endmodule
