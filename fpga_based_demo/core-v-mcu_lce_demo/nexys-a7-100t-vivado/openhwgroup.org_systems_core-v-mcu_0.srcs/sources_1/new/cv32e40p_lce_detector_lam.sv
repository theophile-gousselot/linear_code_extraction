module cv32e40p_lce_detector_lam #(
	parameter WWDL
) (
	input clk,
	input rst_n,
	input [4:0] dlt_i,
	input [31:0] pc_i,
	output [4:0] counter_lam_o,
	output alarm_o
);
localparam WWDL_WITDH = $clog2(WWDL+1);	

reg[WWDL_WITDH-1 :0] reg_counter = dlt_i;
reg[31 :0] reg_last_pc = pc_i;

assign alarm_o = reg_counter=='0 ? '1 : '0;
assign counter_lam_o = reg_counter[4:0];

always_ff @ (posedge clk, negedge rst_n) begin
	if (~rst_n) begin
		reg_counter <= dlt_i;
	end else begin
		if (pc_i == reg_last_pc + 4 ) begin
            if (reg_counter!='0)
                reg_counter <= reg_counter - 1;
            else
                reg_counter <= reg_counter;
		end else begin
			if (pc_i != reg_last_pc)
			    reg_counter <= dlt_i;
			else
                reg_counter <= reg_counter;
		end
		reg_last_pc <= pc_i;
	end
end
endmodule

