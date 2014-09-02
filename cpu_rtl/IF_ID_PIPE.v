
`include "project_defs.vh"
module IF_ID_PIPE (
  /* globals */
  input wire p_clk, 
  input wire p_reset_l,
  
  /* From previous stage */   
  input wire [`WIDTH-1:0] p_IF_ID_IN_Instruction,
  input wire [`WIDTH-1:0] p_IF_PC_Counter,
  /* To ID_Block */ 
  output reg [`WIDTH-1:0] p_IF_ID_OUT_Instruction, 
  output reg [`WIDTH-1:0] p_ID_PC_Counter,
  /* Control Signals */ 
  input wire p_IF_ID_Stall, 
  input wire p_IF_ID_Flush
  
  );
  
  
  /* Pipeline Stage Register(s) */
  always @ (negedge p_reset_l, posedge p_IF_ID_Flush, posedge p_clk) begin 
    if(~p_reset_l | p_IF_ID_Flush) begin 
      p_IF_ID_OUT_Instruction = 0; 
      p_ID_PC_Counter = 0;
    end else if (p_clk) begin 
      if (~p_IF_ID_Stall) begin 
        p_IF_ID_OUT_Instruction = p_IF_ID_IN_Instruction;
        p_ID_PC_Counter         = p_IF_PC_Counter;
        
      end 
    end 
  end
      
endmodule 
