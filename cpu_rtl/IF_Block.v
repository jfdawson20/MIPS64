`include "project_defs.vh"
module IF_Block (
  //globals
  input wire p_clk, 
  input wire p_reset_l,
  
  /* From previous stage */ 
  input wire [31:0] p_INST_MemDataIn,
  input wire p_INST_MemWait, 
  output reg [`WIDTH-1:0] p_IF_INST_MemAddress,
  output reg p_IF_INST_MemRead,
  
  /* To IF_PIPE */ 
  output reg [`WIDTH-1:0] p_IF_Instruction,
  output reg [`WIDTH-1:0] p_PC_Counter
  );
	
  
  reg [`WIDTH-1:0] r_PC_Counter;
  reg [`WIDTH-1:0] r_PC_Addr; 
  reg w_pc_halt;
  
  /* signals used to halt PC counter */
  assign w_pc_halt = p_INST_MemWait;
  
  /* PC Counter */ 
  always @ (negedge p_reset_l, posedge p_clk) begin 
    if(~p_reset_l) begin 
      r_PC_Counter = 0;
      
    end else if (p_clk) begin
      if (~w_pc_halt) begin
        r_PC_Counter = r_PC_Counter + 4;
      end
    end 
	end
  
  /* assignments */ 
  assign p_IF_INST_MemAddress = r_PC_Counter; 
  assign p_IF_Instruction     = p_INST_MemDataIn; 
  
  //if not in reset, set memRead high to constantly ask for next
  //instruction
  assign p_IF_INST_MemRead = (p_reset_l) ? '1 : '0; 
  
  assign p_PC_Counter = r_PC_Counter;
	
endmodule 
