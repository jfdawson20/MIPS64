`include "project_defs.vh"
module IE_Block ( 
    /* Data and Address */
    input wire [`WIDTH-1:0] p_IE_DataA,
    input wire [`WIDTH-1:0] p_IE_DataB,
    input wire [`WIDTH-1:0] p_IE_SignExtended, 
    input wire [`ADDR-1:0]  p_RegDestRT,
    input wire [`ADDR-1:0]  p_RegDestRD,
    
    /* Control Signals */
    input wire [`IE_CTRL_SIZE-1:0] p_IE_Ctrl_Bus,
    
    /* PC counter of current instruction, for branch ops */
    input wire [`WIDTH-1:0] p_IE_PC,
    
    output reg [`WIDTH-1:0] p_IE_BranchAddress,
    output reg [`WIDTH-1:0] p_IE_ALUResult, 
    output reg [`WIDTH-1:0] p_IE_WriteData, 
    output reg p_IE_ALUZero, 
    output reg p_IE_Overflow,
    output reg [`ADDR-1:0]  p_IE_WriteAddress
	);
	
    
    /* Wire List */
    /* Control Signals */
    wire [3:0] w_IE_ALUOP;
    wire w_IE_RegDest;
    wire w_IE_ALUSRC;
    wire w_IE_ShiftInputSwitch;
    wire w_IE_SHAMTSel;
    wire w_IE_BranchSel;
    wire w_IE_ReverseB;
    wire w_IE_DoubleOp; 
    wire w_IE_32OffsetShift;

    wire [`WIDTH-1:0] w_IE_ALUInputA;
    wire [`WIDTH-1:0] w_IE_ALUInputB;
    wire [4:0] w_SHAMT_IN;
    wire [`WIDTH-1:0] w_IE_ShiftedForBranch;

    /* Control Signal Decoding */
    assign w_IE_ALUOP            = p_IE_Ctrl_Bus[3:0];
    assign w_IE_RegDest          = p_IE_Ctrl_Bus[4];
    assign w_IE_ALUSRC           = p_IE_Ctrl_Bus[5];
    assign w_IE_ShiftInputSwitch = p_IE_Ctrl_Bus[6];
    assign w_IE_SHAMTSel         = p_IE_Ctrl_Bus[7];
    assign w_IE_BranchSel        = p_IE_Ctrl_Bus[8];
    assign w_IE_ReverseB         = p_IE_Ctrl_Bus[9];
    assign w_IE_DoubleOp         = p_IE_Ctrl_Bus[10];
    assign w_IE_32OffsetShift    = p_IE_Ctrl_Bus[11];

    /* Input A Mux */
	  assign w_IE_ALUInputA = (w_IE_ShiftInputSwitch) ? p_IE_DataB : p_IE_DataA;
    
    /* Input B Mux : B or Immediate */
    assign w_IE_ALUInputB = (w_IE_ALUSRC) ? p_IE_SignExtended : p_IE_DataB;

    /* Shift Mux */
    assign w_SHAMT_IN = (w_IE_SHAMTSel) ? p_IE_DataA[4:0] : p_IE_SignExtended[10:6];
    
    /* WB Address Mux */
    assign p_IE_WriteAddress = (w_IE_RegDest) ? p_RegDestRT : p_RegDestRD;

    /* ALU Component */

    alu IE_ALU (
      .p_ALUop      (w_IE_ALUOP),
      .p_SHAMT      (w_SHAMT_IN),
      .p_A          (w_IE_ALUInputA), 
      .p_B          (w_IE_ALUInputB),
      .p_DoubleOp   (w_IE_DoubleOp),
      .p_Shift32    (w_IE_32OffsetShift),
      .p_R          (p_IE_ALUResult),
      .p_zero       (p_IE_ALUZero), 
      .p_overflow   (p_IE_Overflow)
      ); 

    /* Branch Stuff */
    assign w_IE_ShiftedForBranch = w_IE_ShiftedForBranch << 2;

    addrDyn IE_BranchAddr(
      .p_CI     ('0),
      .p_A      (p_IE_PC),
      .p_B      (w_IE_ShiftedForBranch),
      .p_R      (p_IE_BranchAddress),
      .p_CO     (),
      .p_OVL    ()
      ); 
      
      
    /* Write Data */
    assign p_IE_WriteData = p_RegDestRD;
endmodule



