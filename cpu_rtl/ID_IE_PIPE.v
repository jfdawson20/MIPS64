
`include "project_defs.vh"
module ID_IE_PIPE (
  /* globals */
  input wire p_clk, 
  input wire p_reset_l,
  
  /* From previous stage */   
  input wire [`WIDTH-1:0] p_ID_DataA,
  input wire [`WIDTH-1:0] p_ID_DataB,
  input wire [`WIDTH-1:0] p_ID_SignExtend,
  input wire [`ADDR-1:0]  p_ID_RegDestRT,
  input wire [`ADDR-1:0] p_ID_RegDestRD,
  input wire [`WIDTH-1:0] p_ID_PC_Counter,
  input wire [`IE_CTRL_SIZE-1:0] p_ID_IE_Ctrl_Bus,
  input wire [`MEM_CTRL_SIZE-1:0] p_ID_MEM_Ctrl_Bus,
  input wire [`WB_CTRL_SIZE-1:0] p_ID_WB_Ctrl_Bus,
  
  /* To IE_Block */ 
  output reg  [`WIDTH-1:0] p_IE_DataA,
  output reg  [`WIDTH-1:0] p_IE_DataB,
  output reg  [`WIDTH-1:0] p_IE_SignExtend,
  output reg  [`ADDR-1:0]  p_IE_RegDestRT,
  output reg  [`ADDR-1:0]  p_IE_RegDestRD,
  output reg  [`WIDTH-1:0] p_IE_PC_Counter,
  output reg  [`IE_CTRL_SIZE-1:0] p_IE_IE_Ctrl_Bus,
  output reg  [`MEM_CTRL_SIZE-1:0] p_IE_MEM_Ctrl_Bus,
  output reg  [`WB_CTRL_SIZE-1:0] p_IE_WB_Ctrl_Bus,
	
  /* Control Signals */ 
  input wire p_ID_IE_Stall, 
  input wire p_ID_IE_Flush
  
  );
  
  
  /* Pipeline Stage Register(s) */
  always @ (negedge p_reset_l, posedge p_ID_IE_Flush, posedge p_clk) begin 
    if(~p_reset_l | p_ID_IE_Flush) begin 
      p_IE_DataA        = 0;
      p_IE_DataB        = 0;
      p_IE_SignExtend   = 0;
      p_IE_RegDestRT    = 0;
      p_IE_RegDestRD    = 0;
      p_IE_IE_Ctrl_Bus  = 0;
      p_IE_MEM_Ctrl_Bus = 0;
      p_IE_WB_Ctrl_Bus  = 0;
      
    end else if (p_clk) begin 
      if (~p_ID_IE_Stall) begin 
          p_IE_DataA        = p_ID_DataA;
          p_IE_DataB        = p_ID_DataB;
          p_IE_SignExtend   = p_ID_SignExtend;
          p_IE_RegDestRT    = p_ID_RegDestRT;
          p_IE_RegDestRD    = p_ID_RegDestRD;
          p_IE_PC_Counter   = p_ID_PC_Counter;
          p_IE_IE_Ctrl_Bus  = p_ID_IE_Ctrl_Bus;
          p_IE_MEM_Ctrl_Bus = p_ID_MEM_Ctrl_Bus;
          p_IE_WB_Ctrl_Bus  = p_ID_WB_Ctrl_Bus;
      end 
    end 
  end
      
endmodule 
