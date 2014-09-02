
`include "project_defs.vh"

module WB_Block ( 
  input wire [`WIDTH-1:0] p_WB_MemData,
  input wire [`WIDTH-1:0] p_WB_ALUResult,
  input wire [`ADDR-1:0]  p_WB_RegDestIN,
  input wire [`WIDTH-1:0] p_WB_PC_4,
  input wire [`WB_CTRL_SIZE-1:0] p_WB_Ctrl_Bus,
  
  output reg [`WIDTH-1:0] p_WB_WritebackData,
  output reg [`ADDR-1:0]  p_WB_RegDestOUT,
  output reg p_RegWrite
  

	); 
	
  /* wire list */
  wire w_StoreOp;
  wire w_LoadOp;
  wire w_JumpSel; 
  wire w_RegWrite;
  wire w_MemToReg; 
  
  wire [`WIDTH-1:0] w_WritebackData_i; 
  
  /* Decode control bus */ 
  assign w_StoreOp  = p_WB_Ctrl_Bus[4];
  assign w_LoadOp   = p_WB_Ctrl_Bus[3];
  assign w_JumpSel  = p_WB_Ctrl_Bus[2]; 
  assign w_RegWrite = p_WB_Ctrl_Bus[1];
  assign w_MemToReg = p_WB_Ctrl_Bus[0]; 
	
  /* Writeback Data Mux */ 
  assign w_WritebackData_i = (w_MemToReg) ? p_WB_ALUResult : p_WB_MemData;
  
  /* jump select mux */ 
  assign p_WB_WritebackData = (w_JumpSel) ? p_WB_PC_4 : w_WritebackData_i;
  
  /* WB Address Buffer */ 
  assign p_WB_RegDestOUT = p_WB_RegDestIN;
  
  /* WB Control Buffer */ 
  assign p_RegWrite = w_RegWrite;
endmodule 