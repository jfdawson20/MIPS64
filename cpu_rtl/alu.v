
`include "project_defs.vh"

module alu (
  input  wire [3:0]        p_ALUop,
  input  wire [4:0]        p_SHAMT,
  input  wire              p_DoubleOp,
  input  wire              p_Shift32,
  input  wire [`WIDTH-1:0] p_A, 
  input  wire [`WIDTH-1:0] p_B,
  output reg  [`WIDTH-1:0] p_R,
  output reg  p_zero, 
  output reg  p_overflow
  
  );  
 
/*--------------------------------------------------------*/
/*                  Arithmetic Block                      */
/*--------------------------------------------------------*/

  //wirelist 
  reg [`WIDTH-1:0] w_arithR;
  wire [`WIDTH-1:0] w_addrR;
  wire w_carryout; 
  wire w_addrOVL;
  reg [`WIDTH-1:0] w_ToBorNot;

  //module instantiation
  addrDyn IE_Addr0 (
    .p_CI       (p_ALUop[1]),
    .p_A        (p_A),
    .p_B        (w_ToBorNot),
    .p_R        (w_addrR),
    .p_DoubleOp (p_DoubleOp),
    .p_CO       (w_carryout),
    .p_OVL      (w_addrOVL)
  );
  
  /* Main Logic Block */ 
  always_comb begin 

    /* check and invert be given ALUopt[1] (used for subtraction) */    
    case(p_ALUop[1])
      1'b0    : w_ToBorNot = p_B;
      1'b1    : w_ToBorNot = ~p_B;
      default : w_ToBorNot = p_B;
    endcase
    
    w_arithR = w_addrR;
    p_zero   = (w_arithR == 0) ? '1 : '0; 
    
    /* overflow logic */ 
    case(p_ALUop[1:0])
      2'b00   : p_overflow = w_addrOVL;
      2'b01   : p_overflow = w_carryout;
      2'b10   : p_overflow = w_addrOVL;
      2'b11   : p_overflow = ~w_carryout;
      default : p_overflow = '0;
    endcase 
  end 
  
  /*--------------------------------------------------------*/
  /*                  Logic Block                           */
  /*--------------------------------------------------------*/
  
  reg [`WIDTH-1:0] w_logicalR;

  always_comb begin
    case(p_ALUop[1:0]) 
      2'b00   : w_logicalR = (p_A & p_B); 
      2'b01   : w_logicalR = (p_A | p_B);
      2'b10   : w_logicalR = (p_A ^ p_B);
      2'b11   : w_logicalR = ~(p_A | p_B);
		default   : w_logicalR = 0;
    endcase
  end 
  
  
  /*--------------------------------------------------------*/
  /*                  Shift Block                           */
  /*--------------------------------------------------------*/
  reg [`WIDTH-1:0] w_shiftR;
  wire w_ShiftAmount; 
  
  /* added support for + 32 sign extension */
  always_comb begin
    case(p_Shift32) 
      1'b0    : w_ShiftAmount = (p_SHAMT);     
      1'b1    : w_ShiftAmount = (p_SHAMT + 32);
      default : w_ShiftAmount = (p_SHAMT); 
      
    case(p_ALUop[1:0])
      //left logical 
      2'b00   : w_shiftR = p_A <<  w_ShiftAmount;  
      //left arithmetic 
      2'b01   : w_shiftR = p_A <<< w_ShiftAmount; 
      //right logical 
      2'b10   : w_shiftR = p_A >>  w_ShiftAmount; 
      //right arithmetic
      2'b11   : w_shiftR = $signed(p_A) >>> w_ShiftAmount; 
      default : w_shiftR = p_A;
    endcase
  end 
  
  /*--------------------------------------------------------*/
  /*                  Compare Block                         */
  /*--------------------------------------------------------*/
  reg [`WIDTH-1:0] w_compR;
  reg [2:0] w_signs;
  
  always_comb begin 
    w_signs[2] = p_A[`WIDTH-1];
    w_signs[1] = p_B[`WIDTH-1];
    w_signs[0] = w_arithR[`WIDTH-1];
    
    case(p_ALUop[1:0])
      2'b00   : w_compR = 64'h0000000000000000; 
      2'b01   : w_compR = 64'h0000000000000000;
      2'b10   : 
        case(w_signs)
          3'b000  : w_compR = 64'h0000000000000000; 
          3'b001  : w_compR = 64'h0000000000000001; 
          3'b110  : w_compR = 64'h0000000000000000; 
          3'b111  : w_compR = 64'h0000000000000001; 
          3'b100  : w_compR = 64'h0000000000000001;
          3'b101  : w_compR = 64'h0000000000000001;
          3'b010  : w_compR = 64'h0000000000000000;
          3'b011  : w_compR = 64'h0000000000000000;
          default : w_compR = 46'h0000000000000000; 
        endcase
      2'b11   : 
        case(w_carryout)
          1'b0    : w_compR = 64'h0000000000000001; 
          1'b1    : w_compR = 64'h0000000000000000; 
          default : w_compR = 64'h0000000000000000; 
        endcase
      default : w_compR = 64'h0000000000000000; 
    endcase
  end 
  
  /*--------------------------------------------------------*/
  /*                  Output Logic                          */
  /*--------------------------------------------------------*/
  always_comb begin
    case(p_ALUop[3:2]) 
        2'b00   : p_R = w_logicalR;  
        2'b01   : p_R = w_arithR;
        2'b10   : p_R = w_compR; 
        2'b11   : p_R = w_shiftR;
        default : p_R = 0;
    endcase
  end 
endmodule 

