`include "project_defs.vh"

module addrDyn(
  input  wire              p_CI,
  input  wire [`WIDTH-1:0] p_A,
  input  wire [`WIDTH-1:0] p_B,
  input  wire              p_DoubleOp, 
  output reg  [`WIDTH-1:0] p_R,
  output reg               p_CO,
  output reg               p_OVL
  ); 
  
  /* wire list */ 
  wire [`WIDTH:0] w_intermediateSum; 
  wire w_aSign; 
  wire w_bSign; 
  wire w_rSign; 
  
  /* calculate sum and carry out values */ 
  assign w_intermediateSum = p_A + p_B + p_CI; 
  assign p_R  = w_intermediateSum[`WIDTH-1:0];
  
  
  always_comb begin 
    case(p_DoubleOp) 
      1'b0 : 
        p_CO = w_intermediateSum[32]; //carryout in 32 bit mode 
        w_aSign = p_A[31];
        w_bSign = p_B[31];
        w_rSign = p_R[31];
        
      1'b1 : 
        p_CO = w_intermediateSum[`WIDTH]; //carryout in 64 bit mode 
        w_aSign = p_A[`WIDTH-1];
        w_bSign = p_B[`WIDTH-1];
        w_rSign = p_R[`WIDTH-1];
        
      default : 
        p_CO = w_intermediateSum[32]; //default to 32bit mode, this should never happen anyways 
        w_aSign = p_A[31];
        w_bSign = p_B[31];
        w_rSign = p_R[31];
  end 
  
  
  //calculate signed overflow, unsigned handled by carryout bit 
  assign p_OVL = (w_aSign != w_bSign) ? '0 : ((w_bSign == w_rSign) ? '0 : '1);
  
  
endmodule 