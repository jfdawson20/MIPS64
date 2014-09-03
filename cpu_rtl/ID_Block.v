`include "project_defs.vh"
module ID_Block ( 
  /* globals */
  input wire p_clk, 
  input wire p_reset_l,  
  
  /* IF Signals */ 
  input wire [31:0] p_ID_IN_Instruction, 
  
  /* ID_EX Signals */
  output reg [`WIDTH-1:0] p_DataA,
  output reg [`WIDTH-1:0] p_DataB,
  output reg [`WIDTH-1:0] p_SignExtended,
  output reg [`ADDR-1:0]  p_RT_RegDest,
  output reg [`ADDR-1:0]  p_RD_RegDest,
  
 
  /* WB Signals */
  input wire [`WIDTH-1:0] p_WB_Data,
  input wire [`ADDR-1:0]  p_WB_Addr,
  input wire p_WB_WE,
  
  /* Output Control Signals */
  output reg [`IE_CTRL_SIZE-1:0]  p_IE_Ctrl_Bus, 
  output reg [`MEM_CTRL_SIZE-1:0] p_MEM_Ctrl_Bus, 
  output reg [`WB_CTRL_SIZE-1:0]  p_WB_Ctrl_bus 
	);
	
  /* Wire List */ 
  wire [5:0]       w_OpCode; 
  wire [`ADDR-1:0] w_AddrA;
  wire [`ADDR-1:0] w_AddrB; 
  wire [15:0]      w_immediate; 
  wire [5:0]       w_funct;
  wire [`WIDTH-1:0] w_immed_extended;
  
  /* Instruction Field Decode */ 
  assign w_OpCode     = p_ID_IN_Instruction[31:26];
  assign w_AddrA      = p_ID_IN_Instruction[25:21];
  assign w_AddrB      = p_ID_IN_Instruction[20:16];
  assign w_immediate  = p_ID_IN_Instruction[15:0];
  assign w_funct      = p_ID_IN_Instruction[4:0];
  
	/* Register Instance */
  
  registers ID_REGBLK0 (
		.p_clk(p_clk),
		.p_din(p_WB_Data),
		.p_dout1(p_DataA),
		.p_dout2(p_DataB),
		.p_readaddr1(w_AddrA),
		.p_readaddr2(w_AddrB),
		.p_rst_l(p_reset_l),
		.p_we(p_WB_WE),
		.p_writeaddr(p_WB_Addr)
	);
  
  /* controller instance */
  controller ID_CTRL ( 
    .p_OpCode     (w_OpCode),
    .p_FUNCT      (w_funct),
    .p_BranchType (w_AddrB),
    .IE_Control   (p_IE_Ctrl_Bus), 
    .MEM_Control  (p_MEM_Ctrl_Bus), 
    .WB_Control   (p_WB_Ctrl_bus)
  );
  
  /* Sign Extend Immediate Value */
  assign w_immed_extended = {{48{w_immediate[15]}},w_immediate};
  
  /* port Assignments */
  assign p_SignExtended = w_immed_extended ;
  assign p_RT_RegDest   = p_ID_IN_Instruction[20:16];
  assign p_RD_RegDest   = p_ID_IN_Instruction[15:11];
endmodule 