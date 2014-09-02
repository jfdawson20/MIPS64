
`include "project_defs.vh"

module MEM_WB_PIPE ( 
  /* globals */
  input wire p_clk, 
  input wire p_reset_l,
  
  /* From previous stage */ 
  input wire [`WIDTH-1:0] p_MEM_MemData, 
  input wire [`WB_CTRL_SIZE-1:0] p_MEM_WB_Ctrl_Bus,
  input wire [`WIDTH-1:0] p_MEM_ALUResult,
  input wire [`ADDR-1:0]  p_MEM_RegDest,
  
  /* To WB Block */
  output reg [`WIDTH-1:0] p_WB_MemData,
  output reg [`WIDTH-1:0] p_WB_ALUResult,
  output reg [`ADDR-1:0]  p_WB_RegDest,
  output reg [`WB_CTRL_SIZE-1:0] p_WB_WB_Ctrl_Bus,
  
  /* Control Signals */
  input wire p_MEM_WB_Flush,
  input wire p_MEM_WB_Stall
  
	); 
	
  
  /* Pipeline Stage Register(s) */
  always @ (negedge p_reset_l, posedge p_MEM_WB_Flush, posedge p_clk) begin 
    if(~p_reset_l | p_MEM_WB_Flush) begin 
      p_WB_MemData      = 0;
      p_WB_WB_Ctrl_Bus  = 0;
      p_WB_RegDest      = 0;
      p_WB_ALUResult    = 0;

    end else if (p_clk) begin 
      if (~p_MEM_WB_Stall) begin 
        p_WB_MemData      = p_MEM_MemData;
        p_WB_RegDest      = p_MEM_RegDest;
        p_WB_ALUResult    = p_MEM_ALUResult;
        p_WB_WB_Ctrl_Bus  = p_MEM_WB_Ctrl_Bus;
        
      end 
    end 
  end
	
endmodule 