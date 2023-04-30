module cv32e40p_lce_detector_dim #(
	parameter WWDL
) (
	input clk,
	input rst_n,
	input [4:0] dlt_i,
	input init_i,
	input decrement_i,
	output [4:0] counter_dim_o,
	output alarm_o
);
localparam WWDL_WITDH = $clog2(WWDL+1);	

reg[WWDL_WITDH-1 :0] reg_counter = dlt_i;

assign alarm_o = reg_counter=='0 ? '1 : '0;
assign counter_dim_o = reg_counter[4:0];

always_ff @ (posedge clk, negedge rst_n) begin
	if (~rst_n) begin
		reg_counter <= dlt_i;
	end else begin
		if (init_i) begin
			reg_counter <= dlt_i;
		end else begin
			if (decrement_i) begin
				if (reg_counter!='0) begin
					reg_counter <= reg_counter - 1;
				end
			end
		end
	end
end
endmodule

