// Copyright 2018 Robert Balas <balasr@student.ethz.ch>
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Top level wrapper for a verilator RI5CY testbench
// Contributor: Robert Balas <balasr@student.ethz.ch>

module tb_top_verilator
    #(parameter INSTR_RDATA_WIDTH = 128,
      parameter RAM_ADDR_WIDTH = 22,
      parameter BOOT_ADDR  = 'h80)
    (input logic clk_i,
     input logic  rst_ni,
     input logic  fetch_enable_i,
     output logic tests_passed_o,
     output logic tests_failed_o);

    // cycle counter
    int unsigned            cycle_cnt_q;
    int unsigned            wait_two_cycles;
    int unsigned            count_instr_exec;

    // testbench result
    logic                   exit_valid;
    logic [31:0]            exit_value;

    integer 				extracted_code_file;
    integer 				alarm_file;
    integer                 final_cycle_file;
    integer                 final_addr_file;
	integer					delay_linear_dump;
	integer					rtl_id;
    
    `define MAX_BB_LEN 20
    `define LCE_DETECTOR

    // we either load the provided firmware or execute a small test program that
    // doesn't do more than an infinite loop with some I/O
    initial begin: load_prog
        automatic logic [2047:0] firmware;
        automatic int prog_size = 6;


        if($value$plusargs("firmware=%s", firmware)) begin
            if($test$plusargs("verbose"))
                $display("[TESTBENCH] %t: loading firmware %0s ...",
                         $time, firmware);
            $readmemh(firmware, cv32e40p_tb_wrapper_i.ram_i.dp_ram_i.mem);
            
            
            if($test$plusargs("lce_delay")) begin
                extracted_code_file = $fopen("extracted_code.txt","w"); // open_mem_dump
                $fclose(extracted_code_file);
            end

            final_cycle_file = $fopen("final_cycle_log.txt","w"); // open_mem_dump
            $fclose(final_cycle_file);
            
            final_addr_file = $fopen("final_addr_log.txt","w"); // open_mem_dump
            $fclose(final_addr_file);

            `ifdef LCE_DETECTOR
            alarm_file = $fopen("lce_detector_alarm_log.txt","w"); // open_mem_dump
            $fclose(alarm_file);
            `endif
            
        end else begin
            $display("No firmware specified");
            $finish;
        end
    end

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if($value$plusargs("lce_delay=%d", delay_linear_dump)) begin
            extracted_code_file = $fopen("extracted_code.txt", "a"); // open_mem_dump
            $fdisplay(extracted_code_file, "%u\n", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.instr_rdata_i);
			if(cycle_cnt_q >= delay_linear_dump) begin			
                force cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.prefetch_buffer_i.instruction_obi_i.resp_rdata_o[6]=1'b0;force cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.prefetch_buffer_i.instruction_obi_i.resp_rdata_o[4:2]=3'b101; //This line will be automatically changes
			end
            $fclose(extracted_code_file);
        end
    end


    // abort after n cycles, if we want to
    always_ff @(posedge clk_i, negedge rst_ni) begin
        automatic int maxcycles;
        if (~rst_ni) begin
            cycle_cnt_q <= 0;
            wait_two_cycles <= 2;
        end else begin
            if (wait_two_cycles > 0) begin
                wait_two_cycles <= wait_two_cycles - 1;
            end else begin
                cycle_cnt_q     <= cycle_cnt_q + 1;
                if($value$plusargs("maxcycles=%d", maxcycles)) begin
                    if (cycle_cnt_q >= maxcycles) begin
                        // we $finish instead of $fatal because riscv-compliance
                        // interprets the return error code as total failure, which
                        // we don't want
                        final_cycle_file = $fopen("final_cycle_log.txt", "w");
                        $fdisplay(final_cycle_file, "%0d", cycle_cnt_q);
                        $fclose(final_cycle_file);

                        final_addr_file = $fopen("final_addr_log.txt", "w");
                        $fdisplay(final_addr_file, "%0d", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.pc_if_o);
                        $fclose(final_addr_file);

                        $finish("Simulation aborted due to maximum cycle limit");
                    end
                end
            end
        end
        if (cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.instr_valid_id_o) begin
            count_instr_exec <= count_instr_exec + 1;
        end
    end

    // check if alarm is raise
    `ifdef LCE_DETECTOR
    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (cv32e40p_tb_wrapper_i.cv32e40p_core_i.lce_detector_i.alarm_o) begin
            
            alarm_file = $fopen("lce_detector_alarm_log.txt", "w");
            $fdisplay(alarm_file, "%0d", cycle_cnt_q);
            $fclose(alarm_file);

            final_cycle_file = $fopen("final_cycle_log.txt", "w");
            $fdisplay(final_cycle_file, "%0d", cycle_cnt_q);
            $fclose(final_cycle_file);

            final_addr_file = $fopen("final_addr_log.txt", "w");
            $fdisplay(final_addr_file, "%0d", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.pc_if_o);
            $fclose(final_addr_file);

            $display("%m @ %0t: LCE DETECTOR ALARM IS RAISE", $time);
            $finish;
        end
end
`endif

// check if we succeded
always_ff @(posedge clk_i, negedge rst_ni) begin
    if (tests_passed_o) begin
        final_cycle_file = $fopen("final_cycle_log.txt", "w");
        $fdisplay(final_cycle_file, "%0d", cycle_cnt_q);
        $fclose(final_cycle_file);

        final_addr_file = $fopen("final_addr_log.txt", "w");
        $fdisplay(final_addr_file, "%0d", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.pc_if_o);
        $fclose(final_addr_file);

			$display("%m @ %0t / %0d instr exec: ALL TESTS PASSED", $time, count_instr_exec);
			$finish;
		end
		if (tests_failed_o) begin
            final_cycle_file = $fopen("final_cycle_log.txt", "w");
            $fdisplay(final_cycle_file, "%0d", cycle_cnt_q);
            $fclose(final_cycle_file);

            final_addr_file = $fopen("final_addr_log.txt", "w");
            $fdisplay(final_addr_file, "%0d", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.pc_if_o);
            $fclose(final_addr_file);

			$display("%m @ %0t / %0d instr exec: TEST(S) FAILED!", $time, count_instr_exec);
			$finish;
		end
		if (exit_valid) begin
            if (exit_value == 0) begin
                final_cycle_file = $fopen("final_cycle_log.txt", "w");
                $fdisplay(final_cycle_file, "%0d", cycle_cnt_q);
                $fclose(final_cycle_file);

                final_addr_file = $fopen("final_addr_log.txt", "w");
                $fdisplay(final_addr_file, "%0d", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.pc_if_o);
                $fclose(final_addr_file);

				$display("%m @ %0t / %0d instr exec: EXIT SUCCESS", $time, count_instr_exec);
			    $finish;
            end else begin
                final_cycle_file = $fopen("final_cycle_log.txt", "w");
                $fdisplay(final_cycle_file, "%0d", cycle_cnt_q);
                $fclose(final_cycle_file);

                final_addr_file = $fopen("final_addr_log.txt", "w");
                $fdisplay(final_addr_file, "%0d", cv32e40p_tb_wrapper_i.cv32e40p_core_i.if_stage_i.pc_if_o);
                $fclose(final_addr_file);

				$display("%m @ %0t / %0d instr exec: EXIT FAILURE: %d", exit_value, $time, count_instr_exec);
			    $finish;
           end
		end
    end


    // wrapper for cv32e40p, the memory system and stdout peripheral
    cv32e40p_tb_wrapper
        #(
        `ifdef LCE_DETECTOR
          .MAX_BB_LEN(`MAX_BB_LEN),                                                    
        `endif 
          .INSTR_RDATA_WIDTH (INSTR_RDATA_WIDTH),
          .RAM_ADDR_WIDTH    (RAM_ADDR_WIDTH),
          .BOOT_ADDR         (BOOT_ADDR),
          .PULP_CLUSTER      (0),
          .FPU               (0),
          .PULP_ZFINX        (0),
          .DM_HALTADDRESS    (32'h1A110800)
         )
    cv32e40p_tb_wrapper_i
        (.clk_i          ( clk_i          ),
         .rst_ni         ( rst_ni         ),
         .fetch_enable_i ( fetch_enable_i ),
         .tests_passed_o ( tests_passed_o ),
         .tests_failed_o ( tests_failed_o ),
         .exit_valid_o   ( exit_valid     ),
         .exit_value_o   ( exit_value     ));

endmodule // tb_top_verilator
