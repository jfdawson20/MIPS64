
`include "project_defs.vh"
module IE_MEM_PIPE (
  /* globals */
  input wire p_clk, 
  input wire p_reset_l,
  
  /* From previous stage */   
  input wire [`WIDTH-1:0] p_IE_BranchAddress,
  input wire [`WIDTH-1:0] p_IE_ALUResult,
  input wire [`ADDR-1:0]  p_IE_RegDest,
  input wire [`WIDTH-1:0] p_IE_WriteOut,
  input wire [`MEM_CTRL_SIZE-1:0] p_IE_MEM_Ctrl_Bus,
  input wire [`WB_CTRL_SIZE-1:0] p_IE_WB_Ctrl_Bus,
  input wire p_IE_ALUZero,
  
  /* To MEM_Block */ 
  output reg [`WIDTH-1:0] p_MEM_BranchAddress,
  output reg [`WIDTH-1:0] p_MEM_ALUResult,
  output reg [`ADDR-1:0]  p_MEM_RegDest,
  output reg [`MEM_CTRL_SIZE-1:0] p_MEM_MEM_Ctrl_Bus,
  output reg [`WB_CTRL_SIZE-1:0] p_MEM_WB_Ctrl_Bus,
  output reg [`WIDTH-1:0] p_MEM_WriteOut,
  output reg p_MEM_ALUZero,
	
  /* Control Signals */ 
  input wire p_IE_MEM_Stall, 
  input wire p_IE_MEM_Flush
  
  );
  
  
  /* Pipeline Stage Register(s) */
  always @ (negedge p_reset_l, posedge p_IE_MEM_Flush, posedge p_clk) begin 
    if(~p_reset_l | p_IE_MEM_Flush) begin 
      p_MEM_BranchAddress   = 0;
      p_MEM_ALUResult       = 0;
      p_MEM_RegDest         = 0;
      p_MEM_MEM_Ctrl_Bus    = 0;
      p_MEM_WB_Ctrl_Bus     = 0;
      p_MEM_ALUZero         = 0;
      p_MEM_WriteOut        = 0;
      
    end else if (p_clk) begin 
      if (~p_IE_MEM_Stall) begin 
          p_MEM_BranchAddress   = p_IE_BranchAddress;
          p_MEM_ALUResult       = p_IE_ALUResult;
          p_MEM_RegDest         = p_IE_RegDest;
          p_MEM_MEM_Ctrl_Bus    = p_IE_MEM_Ctrl_Bus;
          p_MEM_WB_Ctrl_Bus     = p_IE_WB_Ctrl_Bus;
          p_MEM_ALUZero         = p_IE_ALUZero;
          p_MEM_WriteOut        = p_IE_WriteOut;
      end 
    end 
  end
      
endmodule 
