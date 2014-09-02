/*
Filename    : registers.v 
Author      : J. Dawson
Description : Dual port register block; 

*/
`include "project_defs.vh"

module registers (
	input wire p_rst_l,
	input wire p_clk, 
	input wire p_we, 
	input wire [`WIDTH-1:0] p_din,
	input wire [`ADDR-1:0]  p_writeaddr,
	input wire [`ADDR-1:0]  p_readaddr1,
   input wire [`ADDR-1:0]  p_readaddr2,	
	output reg [`WIDTH-1:0] p_dout1,
	output reg [`WIDTH-1:0] p_dout2
	
);
   
	reg [`BLOCKSIZE-1:0][`WIDTH-1:0] r_regBlock; 

	always_ff @(negedge p_rst_l, posedge p_clk) begin
		if (~p_rst_l) begin 
			r_regBlock <= 0;
		end else begin
			if (p_we) begin  
				r_regBlock[p_writeaddr] <= p_din;
		   end 	
		end
	end
	
	assign p_dout1 = r_regBlock[p_readaddr1];
	assign p_dout2 = r_regBlock[p_readaddr2];	
endmodule 
