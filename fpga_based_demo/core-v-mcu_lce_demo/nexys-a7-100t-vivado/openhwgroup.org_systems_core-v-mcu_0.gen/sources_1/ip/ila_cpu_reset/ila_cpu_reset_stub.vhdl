-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
-- Date        : Tue Mar  7 15:34:30 2023
-- Host        : jason running 64-bit Ubuntu 22.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/theophile/these/these_theophile_gousselot/lce/fpga/demonstrator/vivado_projects/build/core-v-mcu-nexys-video_ila-instr_rdata_vio-rst/nexys-a7-100t-vivado/openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/ila_cpu_reset/ila_cpu_reset_stub.vhdl
-- Design      : ila_cpu_reset
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_cpu_reset is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end ila_cpu_reset;

architecture stub of ila_cpu_reset is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2022.1";
begin
end;
