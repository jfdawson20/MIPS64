`include "project_defs.vh"
`default_nettype none

module MIPS64(
   /* globals */
	input wire p_clk,
	input wire p_rst_l,
	
	/* Instruction memory interface */
	input  wire [31:0]        p_INST_MemDataIn,
	input  wire               p_INST_MemWait,
	output reg [`WIDTH-1:0]   p_INST_MemAddress,
	output reg                p_INST_MemRead,
	
	/* Data Memory Interface */
	input  wire [`WIDTH-1:0]  p_DATA_MemDataIn,
	input  wire               p_DATA_MemWait,
	output reg [`WIDTH-1:0]   p_DATA_MemDataOut,
  output reg [`WIDTH-1:0]   p_DATA_MemAddress,
	output reg                p_DATA_MemRead,
  output reg [3:0]          p_DATA_MemWrite
 	);
	
    /* IF */
    wire [`WIDTH-1:0] w_IF_Instruction;
    wire [`WIDTH-1:0] w_IF_PC_Counter;
   
    IF_Block IF_Logic (
      .p_clk                  (p_clk), 
      .p_reset_l              (p_rst_l),
      .p_IF_ExceptionAddress  (64'h0000000000000000),
      .p_IF_ExceptionSRC      ('0),
      .p_IF_BranchAddress     (64'h0000000000000000),
      .p_IF_PCSrc             ('0),
      .p_INST_MemDataIn       (p_INST_MemDataIn),
      .p_INST_MemWait         (p_INST_MemWait), 
      .p_IF_INST_MemAddress   (p_INST_MemAddress),
      .p_IF_INST_MemRead      (p_INST_MemRead),
      .p_IF_Instruction       (w_IF_Instruction),
      .p_PC_Counter           (w_IF_PC_Counter),
      .p_IF_Stall             ()
    );

    /* IF_ID Pipeline Register Block */
    wire [`WIDTH-1:0] w_IF_ID_Instruction;
    wire [`WIDTH-1:0] w_ID_PC_Counter;

    IF_ID_PIPE IF_ID_Regs (
      .p_clk                    (p_clk), 
      .p_reset_l                (p_rst_l),
      .p_IF_ID_IN_Instruction   (w_IF_Instruction),
      .p_IF_PC_Counter          (w_IF_PC_Counter),
      .p_IF_ID_OUT_Instruction  (w_IF_ID_Instruction),  
      .p_ID_PC_Counter          (w_ID_PC_Counter),
      .p_IF_ID_Stall            ('0), 
      .p_IF_ID_Flush            ('0)
    );

    /* IF_ID Pipeline Register Block */
    wire [`WIDTH-1:0] w_ID_DataA;
    wire [`WIDTH-1:0] w_ID_DataB;
    wire [`WIDTH-1:0] w_ID_SignExtend;
    wire [4:0] w_ID_RT_RegDest;
    wire [4:0] w_ID_RD_RegDest;
    wire [31:0] w_ID_IE_Ctrl_Bus;
    wire [31:0] w_ID_MEM_Ctrl_Bus;
    wire [31:0] w_ID_WB_Ctrl_Bus;
    
    /* wb signals */ 
    wire [`WIDTH-1:0] w_WB_WriteData;
    wire w_WB_WriteEn;
    wire [4:0] w_WB_DestAddress;

    ID_Block ID_Logic (
      .p_clk                (p_clk), 
      .p_reset_l            (p_rst_l),  
      .p_ID_IN_Instruction  (w_IF_ID_Instruction), 
      .p_DataA              (w_ID_DataA),
      .p_DataB              (w_ID_DataB),
      .p_SignExtended       (w_ID_SignExtend),
      .p_RT_RegDest         (w_ID_RT_RegDest),
      .p_RD_RegDest         (w_ID_RD_RegDest),
      .p_WB_Data            (w_WB_WriteData),
      .p_WB_Addr            (w_WB_DestAddress),
      .p_WB_WE              (w_WB_WriteEn),
      .p_IE_Ctrl_Bus        (w_ID_IE_Ctrl_Bus), 
      .p_MEM_Ctrl_Bus       (w_ID_MEM_Ctrl_Bus), 
      .p_WB_Ctrl_bus        (w_ID_WB_Ctrl_Bus) 
    );
	
    /*  */
    wire [`WIDTH-1:0] w_IE_DataA;
    wire [`WIDTH-1:0] w_IE_DataB;
    wire [`WIDTH-1:0] w_IE_SignExtend;
    wire [`WIDTH-1:0] w_IE_PC_Counter;
    wire [4:0] w_IE_RT_RegDest;
    wire [4:0] w_IE_RD_RegDest;
    wire [31:0] w_IE_IE_Ctrl_Bus;
    wire [31:0] w_IE_MEM_Ctrl_Bus;
    wire [31:0] w_IE_WB_Ctrl_Bus;

    wire [`WIDTH-1:0] w_IE_BranchAddress;
    wire w_IE_ALUZero;
    wire w_IE_ALUOverflow;
    wire [`WIDTH-1:0] w_IE_ALUResult;
    wire [4:0] w_IE_WriteAddress;
    wire [`WIDTH-1:0] w_IE_WriteData;

    ID_IE_PIPE ID_IE_Regs (
       .p_clk             (p_clk), 
       .p_reset_l         (p_rst_l), 
       .p_ID_DataA        (w_ID_DataA),
       .p_ID_DataB        (w_ID_DataB),
       .p_ID_SignExtend   (w_ID_SignExtend),
       .p_ID_RegDestRT    (w_ID_RT_RegDest),
       .p_ID_RegDestRD    (w_ID_RD_RegDest),
       .p_ID_PC_Counter   (w_ID_PC_Counter),
       .p_ID_IE_Ctrl_Bus  (w_ID_IE_Ctrl_Bus),
       .p_ID_MEM_Ctrl_Bus (w_ID_MEM_Ctrl_Bus),
       .p_ID_WB_Ctrl_Bus  (w_ID_WB_Ctrl_Bus),
       .p_IE_DataA        (w_IE_DataA),
       .p_IE_DataB        (w_IE_DataB),
       .p_IE_SignExtend   (w_IE_SignExtend),
       .p_IE_RegDestRT    (w_IE_RT_RegDest),
       .p_IE_RegDestRD    (w_IE_RD_RegDest),
       .p_IE_PC_Counter   (w_IE_PC_Counter),
       .p_IE_IE_Ctrl_Bus  (w_IE_IE_Ctrl_Bus),
       .p_IE_MEM_Ctrl_Bus (w_IE_MEM_Ctrl_Bus),
       .p_IE_WB_Ctrl_Bus  (w_IE_WB_Ctrl_Bus),
       .p_ID_IE_Stall     ('0), 
       .p_ID_IE_Flush     ('0) 
    );


    IE_Block IE_Logic (
        .p_IE_DataA         (w_IE_DataA),
        .p_IE_DataB         (w_IE_DataB),
        .p_IE_SignExtended  (w_IE_SignExtend), 
        .p_RegDestRT        (w_IE_RT_RegDest),
        .p_RegDestRD        (w_IE_RD_RegDest),
        .p_IE_Ctrl_Bus      (w_IE_IE_Ctrl_Bus),
        .p_IE_PC            (w_IE_PC_Counter),
        .p_IE_BranchAddress (w_IE_BranchAddress),
        .p_IE_ALUResult     (w_IE_ALUResult), 
        .p_IE_WriteData     (w_IE_WriteData),
        .p_IE_ALUZero       (w_IE_ALUZero), 
        .p_IE_Overflow      (w_IE_ALUOverflow),
        .p_IE_WriteAddress  (w_IE_WriteAddress)
    );
    
    /* Mem */
    wire [`WIDTH-1:0] w_MEM_BranchAddress;
    wire [`WIDTH-1:0] w_MEM_ALUResult;
    wire [4:0] w_MEM_RegDest;
    wire [31:0] w_MEM_MEM_Ctrl_bus;
    wire [31:0] w_MEM_WB_Ctrl_bus;
    wire w_MEM_ALUZero;
    wire [`WIDTH-1:0] w_MEM_WriteData;
    wire [`WIDTH-1:0] w_MEM_DataFromMem;

    IE_MEM_PIPE IE_MEM_Regs (
        .p_clk               (p_clk), 
        .p_reset_l           (p_rst_l),
        .p_IE_BranchAddress  (w_IE_BranchAddress),
        .p_IE_WriteOut       (w_IE_WriteData),
        .p_IE_ALUResult      (w_IE_ALUResult),
        .p_IE_RegDest        (w_IE_WriteAddress),
        .p_IE_MEM_Ctrl_Bus   (w_IE_MEM_Ctrl_Bus),
        .p_IE_WB_Ctrl_Bus    (w_IE_WB_Ctrl_Bus),
        .p_IE_ALUZero        (w_IE_ALUZero),
        .p_MEM_BranchAddress (w_MEM_BranchAddress),
        .p_MEM_ALUResult     (w_MEM_ALUResult),
        .p_MEM_RegDest       (w_MEM_RegDest),
        .p_MEM_MEM_Ctrl_Bus  (w_MEM_MEM_Ctrl_bus),
        .p_MEM_WB_Ctrl_Bus   (w_MEM_WB_Ctrl_bus),
        .p_MEM_WriteOut      (w_MEM_WriteData),
        .p_MEM_ALUZero       (w_MEM_ALUZero),
        .p_IE_MEM_Stall      ('0), 
        .p_IE_MEM_Flush      ('0)
    );
    
    MEM_Block ME_Logic ( 
      .p_MEM_BranchAddress  (w_MEM_BranchAddress),
      .p_MEM_ALUResult      (w_MEM_ALUResult),
      .p_MEM_WriteOut       (w_MEM_WriteData),
      .p_MEM_RegDest        (w_MEM_RegDest),
      .p_MEM_MEM_Ctrl_Bus   (w_MEM_MEM_Ctrl_bus),
      .p_MEM_ALUZero        (w_MEM_ALUZero),
      .p_MEM_DataMemWait    (p_DATA_MemWait),
      .p_MEM_ReadDataIn     (p_DATA_MemDataIn),
      .p_MEM_WriteDataOut   (p_DATA_MemDataOut),
		  .p_MEM_Address        (p_DATA_MemAddress),
      .p_MEM_ReadData       (p_DATA_MemRead), 
      .p_MEM_WriteData      (p_DATA_MemWrite),
      .p_MEM_Data           (w_MEM_DataFromMem)      
    );
    
    /* WB */
    
    wire [4:0]        w_WB_RegDest;
    wire [`WIDTH-1:0] w_WB_DataFromMem;
    wire [`WIDTH-1:0] w_WB_ALUResult;
    wire [31:0]       w_WB_WB_Ctrl_bus;
  
    
    MEM_WB_PIPE MEM_WB_REGS ( 
      .p_clk              (p_clk), 
      .p_reset_l          (p_rst_l),
      .p_MEM_MemData      (w_MEM_DataFromMem), 
      .p_MEM_WB_Ctrl_Bus  (w_MEM_WB_Ctrl_bus),
      .p_MEM_ALUResult    (w_MEM_ALUResult),
      .p_MEM_RegDest      (w_MEM_RegDest),
      .p_WB_MemData       (w_WB_DataFromMem),
      .p_WB_ALUResult     (w_WB_ALUResult),
      .p_WB_RegDest       (w_WB_RegDest),
      .p_WB_WB_Ctrl_Bus   (w_WB_WB_Ctrl_bus),
      .p_MEM_WB_Flush     ('0),
      .p_MEM_WB_Stall     ('0)
    );
    
    
    WB_Block WB_Logic ( 
      .p_WB_MemData        (w_WB_DataFromMem),
      .p_WB_ALUResult      (w_WB_ALUResult),
      .p_WB_RegDestIN      (w_WB_RegDest),
      .p_WB_PC_4           (64'h0000000000000000),
      .p_WB_Ctrl_Bus       (w_WB_WB_Ctrl_bus),
      .p_WB_WritebackData  (w_WB_WriteData),
      .p_WB_RegDestOUT     (w_WB_DestAddress),
      .p_RegWrite          (w_WB_WriteEn)    
    );

endmodule 







