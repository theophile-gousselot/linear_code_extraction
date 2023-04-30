# Auto-generated project tcl file


create_project openhwgroup.org_systems_core-v-mcu_0 -force

set_property part xc7a100tcsg324-1 [current_project]




set_property verilog_define {PULP_FPGA_EMUL=1 } [get_filesets sources_1]
read_verilog -sv {../src/openhwgroup.org_ip_apb2apbcomp_0/apb2apbcomp.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb2per_0/apb2per.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/adv_timer_apb_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/comparator.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/lut_4x4.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/out_filter.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/up_down_counter.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/input_stage.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/prescaler.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/apb_adv_timer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/timer_cntrl.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_adv_timer_0/rtl/timer_module.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_fll_if_0/apb_fll_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_gpio_0/rtl/apb_gpio.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_i2cs_0/rtl/apb_i2cs.v}
read_verilog -sv {../src/openhwgroup.org_ip_apb_i2cs_0/rtl/apb_slv_interface.v}
read_verilog -sv {../src/openhwgroup.org_ip_apb_i2cs_0/rtl/FIFO_sync_256x8.v}
read_verilog -sv {../src/openhwgroup.org_ip_apb_i2cs_0/rtl/i2c_peripheral_interface.v}
read_verilog -sv {../src/openhwgroup.org_ip_apb_i2cs_0/rtl/i2c_peripheral_registers.v}
read_verilog -sv {../src/openhwgroup.org_ip_apb_i2cs_0/rtl/RAM_256x8_behavioral.v}
read_verilog -sv {../src/openhwgroup.org_ip_apb_node_0/src/apb_node.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_node_0/src/apb_node_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_timer_unit_0/rtl/apb_timer_unit.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_timer_unit_0/rtl/timer_unit.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_timer_unit_0/rtl/timer_unit_counter.sv}
read_verilog -sv {../src/openhwgroup.org_ip_apb_timer_unit_0/rtl/timer_unit_counter_presc.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_single_slice.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_ar_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_aw_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_b_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_r_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_slice.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_w_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_axi_slice_0/src/axi_slice_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/include/cv32e40p_apu_core_pkg.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/include/cv32e40p_fpu_pkg.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/include/cv32e40p_pkg.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_alu.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_alu_div.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_ff_one.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_popcnt.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_compressed_decoder.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_controller.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_cs_registers.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_decoder.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_int_controller.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_ex_stage.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_hwloop_regs.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_id_stage.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_if_stage.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_load_store_unit.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_mult.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_prefetch_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_prefetch_controller.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_obi_interface.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_aligner.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_sleep_unit.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_core.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_apu_disp.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_fifo.sv}
read_verilog -sv {../src/openhwgroup.org_ip_cv32e40p_0/openhwgroup_cv32e40p/rtl/cv32e40p_register_file_ff.sv}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/log_int_dc_slice.sv}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/log_int_dc_slice_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/dc_data_buffer.sv}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/dc_full_detector.v}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/dc_synchronizer.v}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/dc_token_ring_fifo_din.v}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/dc_token_ring_fifo_dout.v}
read_verilog -sv {../src/openhwgroup.org_ip_logint_dc_fifo_xbar_0/dc_token_ring.v}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/tcdm_interconnect_pkg.sv}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/addr_dec_resp_mux.sv}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/amo_shim.sv}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/xbar.sv}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/clos_net.sv}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/bfly_net.sv}
read_verilog -sv {../src/openhwgroup.org_ip_tcdm_interconnect_0/src/tcdm_interconnect.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_camera_0/rtl/camera_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_camera_0/rtl/camera_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/core/udma_ch_addrgen.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/core/udma_arbiter.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/core/udma_core.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/core/udma_rx_channels.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/core/udma_tx_channels.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/core/udma_stream_unit.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/udma_ctrl.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/udma_apb_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_clk_gen.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_event_counter.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_generic_fifo.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_tx_fifo.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_tx_fifo_mark.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_tx_fifo_dc.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/io_shiftreg.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/udma_dc_fifo.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/udma_clkgen.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_core_0/rtl/common/udma_clk_div_cnt.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_external_per_0/rtl/udma_external_per_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_external_per_0/rtl/udma_external_per_wrapper.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_external_per_0/rtl/udma_external_per_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_external_per_0/rtl/udma_traffic_gen_rx.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_external_per_0/rtl/udma_traffic_gen_tx.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_filter_0/rtl/udma_filter_au.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_filter_0/rtl/udma_filter_bincu.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_filter_0/rtl/udma_filter_rx_dataout.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_filter_0/rtl/udma_filter_tx_datafetch.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_filter_0/rtl/udma_filter_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_filter_0/rtl/udma_filter.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2c_0/rtl/udma_i2c_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2c_0/rtl/udma_i2c_bus_ctrl.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2c_0/rtl/udma_i2c_control.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2c_0/rtl/udma_i2c_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/i2s_clk_gen.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/i2s_rx_channel.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/i2s_tx_channel.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/i2s_ws_gen.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/i2s_clkws_gen.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/i2s_txrx.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/cic_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/cic_integrator.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/cic_comb.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/pdm_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/udma_i2s_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_i2s_0/rtl/udma_i2s_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_qspi_0/rtl/udma_spim_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_qspi_0/rtl/udma_spim_ctrl.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_qspi_0/rtl/udma_spim_txrx.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_qspi_0/rtl/udma_spim_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/sdio_crc7.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/sdio_crc16.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/sdio_txrx_cmd.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/sdio_txrx_data.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/sdio_txrx.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/udma_sdio_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_sdio_0/rtl/udma_sdio_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_uart_0/rtl/udma_uart_reg_if.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_uart_0/rtl/udma_uart_top.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_uart_0/rtl/udma_uart_rx.sv}
read_verilog -sv {../src/openhwgroup.org_ip_udma_uart_0/rtl/udma_uart_tx.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/binary_to_gray.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/cb_filter_pkg.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/cdc_2phase.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/cf_math_pkg.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/clk_div.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/delta_counter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/ecc_pkg.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/edge_propagator_tx.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/exp_backoff.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/fifo_v3.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/gray_to_binary.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/isochronous_spill_register.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/lfsr.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/lfsr_16bit.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/lfsr_8bit.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/mv_filter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/onehot_to_bin.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/plru_tree.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/popcount.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/rr_arb_tree.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/rstgen_bypass.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/serial_deglitch.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/shift_reg.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/spill_register.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_demux.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_filter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_fork.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_intf.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_join.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_mux.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/sub_per_hash.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/sync.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/sync_wedge.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/unread.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/addr_decode.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/cb_filter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/cdc_fifo_2phase.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/cdc_fifo_gray.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/counter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/ecc_decode.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/ecc_encode.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/edge_detect.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/lzc.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/max_counter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/rstgen.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_delay.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_fifo.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_fork_dynamic.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_xbar.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/fall_through_register.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/id_queue.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_to_mem.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_arbiter_flushable.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_omega_net.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_register.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/stream_arbiter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/clock_divider_counter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/find_first_one.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/generic_LFSR_8bit.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/generic_fifo.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/prioarbiter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/pulp_sync.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/pulp_sync_wedge.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/rrarbiter.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/clock_divider.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/fifo_v2.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/deprecated/fifo_v1.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/edge_propagator.sv}
read_verilog -sv {../src/pulp-platform.org__common_cells_1.20.0/src/edge_propagator_rx.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_generic_0/pulp_platform_tech_cells_generic/src/deprecated/pad_functional.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_generic_0/pulp_platform_tech_cells_generic/src/deprecated/pulp_clock_gating_async.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/deprecated/cluster_clk_cells_xilinx.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/deprecated/cluster_pwr_cells.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/deprecated/pulp_clk_cells_xilinx.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/deprecated/pulp_pwr_cells.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/deprecated/pulp_buffer.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/fpga/tc_clk_xilinx.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/fpga/tc_sram_xilinx.sv}
read_verilog -sv {../src/pulp-platform.org__tech_cells_xilinx_0/pulp_platform_tech_cells_generic/src/tc_pwr.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/eFPGA_wrapper.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/A2_design.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/a2_math_unit.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/bw_mac.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/bw_multiplier.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/mac_16bit.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/mac_32bit.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/mac_8bit.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/mac_4bit.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/mac_array.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/math_block.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_math_unit/rtl/tpram_wrap.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/baud_generator.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbaps.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbclp.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbfsr.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbmic.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbpif.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbpmu.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbrfu.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbrfuwff.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbrwf.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbsmc.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcbssc.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/fcb.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/ql_generic_gates.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/registers.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/serializer_deserializer.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/spi_master_top.v}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/SPI_slave.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_aff2.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_dff.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_rfm_f.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_rfm.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_rhw.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_rwhwsc.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_rw.sv}
read_verilog -sv {../src/quicklogic.com_ip_efpga_0/ql_fcb/rtl/qf_sff.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/l2_tcdm_demux.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/lint_2_apb.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/lint_2_axi.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/axi_2_lint/axi64_2_lint32.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/axi_2_lint/axi_read_ctrl.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/axi_2_lint/axi_write_ctrl.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/axi_2_lint/lint64_to_32.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/AddressDecoder_Req_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/AddressDecoder_Resp_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/ArbitrationTree_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/FanInPrimitive_Req_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/FanInPrimitive_Resp_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/MUX2_REQ_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/RequestBlock_L2_1CH.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/RequestBlock_L2_2CH.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/ResponseBlock_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/ResponseTree_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/RR_Flag_Req_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_L2/XBAR_L2.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/AddressDecoder_Req_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/AddressDecoder_Resp_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/ArbitrationTree_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/FanInPrimitive_Req_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/FanInPrimitive_Resp_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/MUX2_REQ_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/RequestBlock1CH_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/RequestBlock2CH_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/ResponseBlock_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/ResponseTree_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/RR_Flag_Req_BRIDGE.sv}
read_verilog -sv {../src/openhwgroup.org_ip_l2_tcdm_hybrid_interco_0/RTL/XBAR_BRIDGE/XBAR_BRIDGE.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_pkg.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_intf.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_atop_filter.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_burst_splitter.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_cdc.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_cut.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_delayer.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_demux.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_dw_downsizer.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_dw_upsizer.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_id_prepend.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_isolate.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_join.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_demux.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_join.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_mailbox.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_mux.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_regs.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_to_apb.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_to_axi.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_modify_address.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_mux.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_serializer.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_err_slv.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_dw_converter.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_multicut.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_to_axi_lite.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_lite_xbar.sv}
read_verilog -sv {../src/pulp-platform.org__axi_0.28.0/src/axi_xbar.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_pkg.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_cast_multi.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_classifier.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_divsqrt_multi.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_fma.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_fma_multi.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_noncomp.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_opgroup_block.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_opgroup_fmt_slice.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_opgroup_multifmt_slice.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_rounding.sv}
read_verilog -sv {../src/pulp-platform.org__fpnew_0/pulp_platform_fpnew/src/fpnew_top.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/control_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/div_sqrt_mvp_wrapper.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/div_sqrt_top_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/iteration_div_sqrt_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/norm_div_sqrt_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/nrbd_nrsc_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__fpu_div_sqrt_mvp_0/pulp_platform_fpu_div_sqrt_mvp/hdl/preprocess_mvp.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/debug_rom/debug_rom.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/debug_rom/debug_rom_one_scratch.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dm_pkg.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dm_csrs.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dmi_cdc.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dmi_jtag.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dmi_jtag_tap.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dm_mem.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dm_obi_top.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dm_sba.sv}
read_verilog -sv {../src/pulp-platform.org__riscv_dbg_0/pulp_platform_riscv_dbg/src/dm_top.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/pkg_soc_interconnect.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/lint_2_axi_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/contiguous_crossbar.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/interleaved_crossbar.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/tcdm_demux.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/boot_rom.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/l2_ram_multi_bank.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/lint_jtag_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/periph_bus_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_clk_rst_gen.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/clk_and_control.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_event_arbiter.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_event_generator.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_event_queue.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/tcdm_error_slave.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_interconnect.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_interconnect_wrap.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/soc_peripherals.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/udma_subsystem/udma_subsystem.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/fc/fc_demux.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/fc/fc_subsystem.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/fc/fc_hwpe.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/fc/cv32e40p_fp_wrapper.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/components/apb_soc_ctrl.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/components/pulp_interfaces.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/efpga_subsystem/efpga_subsystem.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/efpga_subsystem/A2_fifo.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/efpga_subsystem/A2_fifo_ctl.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/efpga_subsystem/A2_fifo_ram.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/efpga_subsystem/tcdm_interface.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/efpga_subsystem/apbt1_interface.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/top/pad_control.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/top/safe_domain.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/top/soc_domain.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/top/core_v_mcu.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/soc/clk_gen.sv}
source {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/ips/xilinx_clk_mngr.tcl}
source {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/ips/xilinx_interleaved_ram.tcl}
source {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/ips/xilinx_private_ram.tcl}
source {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/tcl/common.tcl}
source {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/tcl/flatten.tcl}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/cv32e40p_clock_gate.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/fpga_interleaved_ram.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/fpga_private_ram.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/fpga_slow_clk_gen.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/pad_functional_xilinx.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/pulp_clock_gating_xilinx.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/sram512x64.v}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/DW02_mac.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/simulation/pPLL02F.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/simulation/top.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/simulation/top1_wrapper.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/rtl/simulation/a2_bootrom.sv}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/core-v-mcu-nexys/rtl/core_v_mcu_nexys.v}
read_verilog -sv {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/xilinx/rtl/fpga_clk_gen.sv}
read_xdc {../src/openhwgroup.org_systems_core-v-mcu_0/emulation/core-v-mcu-nexys/constraints/core-v-mcu-pin-assignment.xdc}
read_mem {mem_init/boot.mem}

set_property include_dirs [list ../src/openhwgroup.org_ip_udma_qspi_0/rtl ../src/pulp-platform.org__common_cells_1.20.0/include ../src/pulp-platform.org__axi_0.28.0/include ../src/openhwgroup.org_systems_core-v-mcu_0/rtl/includes ../src/openhwgroup.org_systems_core-v-mcu_0/rtl/core-v-mcu/include/ .] [get_filesets sources_1]
set_property top core_v_mcu_nexys [current_fileset]
set_property source_mgmt_mode None [current_project]


