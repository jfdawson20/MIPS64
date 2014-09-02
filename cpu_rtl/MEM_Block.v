`include "project_defs.vh"

module MEM_Block ( 
  /* From IE */
  input wire [`WIDTH-1:0] p_MEM_BranchAddress,
  input wire [`WIDTH-1:0] p_MEM_ALUResult,
  input wire [`WIDTH-1:0] p_MEM_WriteOut,
  input wire [`ADDR-1:0]  p_MEM_RegDest,
  input wire [`MEM_CTRL_SIZE-1:0] p_MEM_MEM_Ctrl_Bus,
  input wire p_MEM_ALUZero,
  
  /* To/From Memory */ 
  input wire               p_MEM_DataMemWait,
  input wire  [`WIDTH-1:0] p_MEM_ReadDataIn,
  output reg [`WIDTH-1:0] p_MEM_WriteDataOut,
  output reg [`WIDTH-1:0] p_MEM_Address,
  output reg              p_MEM_ReadData, 
  output reg [3:0]        p_MEM_WriteData,

  /* To WB Stage */
  output reg [`WIDTH-1:0] p_MEM_Data
	); 
	
  /* wire list */ 
  wire        w_MEM_ReadSignal; 
  wire        w_MEM_WriteSignal; 
  wire        w_MEM_BranchSignal; 
  wire [2:0]  w_MEM_BranchCode; 
  wire [3:0]  w_MEM_ReadType;
  wire [3:0]  w_MEM_WriteType;
  wire        w_MEM_LoadSign; 
  wire        w_MEM_LoadMemOp;
  wire        w_MEM_StoreMemOp; 
  wire [1:0]  w_MEM_WriteSize;
  
  /* Control Bus Decode */
  assign w_MEM_ReadSignal   = p_MEM_MEM_Ctrl_Bus[0];
  assign w_MEM_WriteSignal  = p_MEM_MEM_Ctrl_Bus[1];
  assign w_MEM_BranchSignal = p_MEM_MEM_Ctrl_Bus[2];
  assign w_MEM_BranchCode   = p_MEM_MEM_Ctrl_Bus[5:3];
  assign w_MEM_ReadType     = p_MEM_MEM_Ctrl_Bus[9:6];   //additional bits for unalligned data stuff
  assign w_MEM_WriteType    = p_MEM_MEM_Ctrl_Bus[13:10]; //additional bits for unalligned data stuff
  assign w_MEM_LoadSign     = p_MEM_MEM_Ctrl_Bus[14];
  assign w_MEM_LoadMemOp    = p_MEM_MEM_Ctrl_Bus[15];
  assign w_MEM_StoreMemOp   = p_MEM_MEM_Ctrl_Bus[16];
  
  /* Functional Assignments */
  /* Read Control */
  assign p_MEM_ReadData = w_MEM_ReadSignal;
  
  /* Write Control */
  assign p_MEM_WriteData[3]   = '0; /* Place Holder */
  assign p_MEM_WriteData[2:1] = w_MEM_WriteSize; 
  assign p_MEM_WriteData[0]   = w_MEM_WriteSignal;

  /* Load Data Control */
  always_comb begin 
    case(w_MEM_WriteType) 
      4'b0000 : /* lb - load byte */
        p_MEM_Data = {{56{p_MEM_ReadDataIn[7]}},p_MEM_ReadDataIn[7:0]};
      4'b0001 : /* lbu - load byte unsigned*/
        p_MEM_Data = {56'h00000000000000,p_MEM_ReadDataIn[7:0]};
      4'b0010 : /* ld - load doubleword */
        p_MEM_Data = p_MEM_ReadDataIn;
      4'b0011 : /* ldl - load doubleword left */
		    p_MEM_Data = p_MEM_ReadDataIn;
      4'b0100 : /* ldr - load doubleword right */
			  p_MEM_Data = p_MEM_ReadDataIn;
      4'b0101 : /* lwl - load word left */
			  p_MEM_Data = p_MEM_ReadDataIn;
      4'b0110 : /* lwr - load word right */
			  p_MEM_Data = p_MEM_ReadDataIn;
      4'b0111 : /* lh - load halfword */
        p_MEM_Data = {{48{p_MEM_ReadDataIn[15]}},p_MEM_ReadDataIn[15:0]};
      4'b1000 : /* lhu - load halfword unsigned */
        p_MEM_Data = {48'h000000000000,p_MEM_ReadDataIn[15:0]};
      4'b1001 : /* ll - load linked word */
			  p_MEM_Data = p_MEM_ReadDataIn;
      4'b1010 : /* lld - load linked doubleword */
			  p_MEM_Data = p_MEM_ReadDataIn;
      4'b1011 : /* lw - load word */
        p_MEM_Data = {32'h00000000,p_MEM_ReadDataIn[31:0]};
      4'b1100 : /* lwu load word unsigned */
        p_MEM_Data = {{32{p_MEM_ReadDataIn[31]}},p_MEM_ReadDataIn[31:0]};
      default : /* invalid load code */
        p_MEM_Data = 64'h0000000000000000;
    endcase
  end

  /* Store Data Control */
  always_comb begin 
    case(w_MEM_ReadType) 
      4'b0000 : /* sb - store byte */
        p_MEM_WriteDataOut = {56'h00000000000000,p_MEM_WriteOut[7:0]};
      4'b0001 : /* sh store half */
        p_MEM_WriteDataOut = {48'h000000000000,p_MEM_WriteOut[15:0]};
      4'b0010 : /* sw store word */
        p_MEM_WriteDataOut = {32'h0000000000,p_MEM_WriteOut[31:0]};
      4'b0011 : /* sd store doubleword */
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      4'b0100 : /* sdl store doubleword left */
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      4'b0101 : /* sdr store doubleword right */
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      4'b0110 : /* swl store word left */
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      4'b0111 : /* swr store word right */
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      4'b1000 : /* sc store conditional */
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      4'b1001 : /* scd store doubleword conditional*/
        p_MEM_WriteDataOut = p_MEM_WriteOut;
      default : /* invalid load code */
        p_MEM_WriteDataOut = 64'h0000000000000000;
    endcase     
  end
  
  /* Address Control */ 
  assign p_MEM_Address = p_MEM_ALUResult;
endmodule 
