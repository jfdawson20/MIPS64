`include "project_defs.vh"
module IF_Block (
  /* Globals */
  input wire p_clk, 
  input wire p_rst_l,
  
  /* Coprocessor 0 Interface  */
  input wire [`WIDTH-1:0] p_IF_ExceptionAddress, 
  input wire              p_IF_ExceptionSrc, 
  
  /* Branch/Jump Interface */ 
  input wire [`WIDTH-1:0] p_IF_BranchAddress, 
  input wire              p_IF_PCSrc,
  
  /* Instruction Memory Interface*/ 
  input wire [31:0]       p_IF_INST_MemDataIn,
  input wire              p_IF_INST_MemWait, 
  output reg [`WIDTH-1:0] p_IF_INST_MemAddress,
  output reg              p_IF_INST_MemRead,
  
  /* To IF_PIPE */ 
  output reg [31:0]       p_IF_Instruction,
  output reg [`WIDTH-1:0] p_IF_PC_Counter,
  output reg              p_IF_Stall
  );
	
  /* Wire and Register List */
  reg [`WIDTH-1:0]  r_IF_PC_Counter;
  wire              w_IF_pc_halt;
  wire [`WIDTH-1:0] w_IF_PCSrc_i;
  wire [`WIDTH-1:0] w_IF_PCExeSrc_i;
  wire [`WIDTH-1:0] w_IF_NextPC_i;
  
  /* signals used to halt PC counter */
  assign w_IF_pc_halt = p_IF_INST_MemWait;
  
  /* PC Adder */
  assign w_IF_NextPC_i = r_IF_PC_Counter + 4; 
  
  /* PC Register */ 
  always @ (negedge p_rst_l, posedge p_clk) begin 
    if(~p_rst_l) begin 
      r_IF_PC_Counter = 0;
      
    end else if (p_clk) begin
      if (~w_IF_pc_halt) begin
        r_IF_PC_Counter = w_IF_PCExeSrc_i;
        
      end
    end 
	end
  
  /* w_PCSrc_i Mux  */
  assign w_IF_PCSrc_i = (p_IF_PCSrc) ? p_IF_BranchAddress : w_IF_NextPC_i ; 
  
  /* w_PC_ExeSrc_i */
  assign w_IF_PCExeSrc_i = (p_IF_ExceptionSrc) ? p_IF_ExceptionAddress : w_IF_PCSrc_i;
  
  /* Memory Interface assignments */ 
  assign p_IF_INST_MemAddress = r_IF_PC_Counter; 
  assign p_IF_Instruction     = p_IF_INST_MemDataIn; 
  
  /* if not in reset, set memRead high to constantly ask for next instruction */
  assign p_IF_INST_MemRead = (p_rst_l) ? '1 : '0; 
  
  /* assign current instruction PC Counter value */
  assign p_IF_PC_Counter = r_IF_PC_Counter;
	
endmodule 
