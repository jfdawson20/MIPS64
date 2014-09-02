`define SIZE 1024
module CustMem (
  input wire p_clk,
  input wire p_reset_l,
  input wire p_readRequest, 
  input wire p_writeRequest,
  input wire [63:0] p_Address,
  input wire [63:0] p_InputData, 
  
  output reg [63:0] p_OutputData,
  output wire p_MemWait
  );

  parameter filePath = "."; 
  reg [63:0] memory [`SIZE-1:0] ;
  integer i;
  //initial $readmemh("C:/Users/jdawson/Dropbox/FPGA/Processor/scripts/output.hex",memory);

  always @ (negedge p_reset_l, posedge p_clk) begin 
    if (~p_reset_l) begin
      $readmemh(filePath,memory);
      p_OutputData = 0; 
      
    end else if (p_clk) begin 
      if (p_readRequest) begin 
        p_OutputData = memory[p_Address];
        
      end else if (p_writeRequest) begin 
        memory[p_Address] = p_InputData; 
        
      end 
    end 
  end 

  /* assign memwait */
  assign p_MemWait = '0;
endmodule 
  
