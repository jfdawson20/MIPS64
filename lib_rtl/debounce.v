module debounce (
  input wire clk,
  input wire reset_n,
  input wire p_sigIn,
  output reg p_Debounced
  );
  
  reg [7:0] w_debounce_counter;
  reg w_sreset_counter;
  reg w_count_done; 
  
  //pcie 1 debounce counter 
  always_ff @(posedge w_sreset_counter, posedge clk) begin
	if(w_sreset_counter) begin 
		w_debounce_counter = 200; 
		w_count_done = '0; 
	end else if(clk) begin 
		if (w_debounce_counter == 0) begin 
			w_count_done = '1;
		end else 
			w_debounce_counter = w_debounce_counter - 1'b1;
		end
	end

  
  reg FF1, FF2;
  
  always_ff @(negedge reset_n, posedge clk) begin
	  if (~reset_n) begin 
      w_sreset_counter = '1;
		  FF1 = '1;
		  FF2 = '1;
		  p_Debounced = '1;
	  end else if (clk) begin 
		  FF2 = FF1;      
		  FF1 = p_sigIn; 
		  w_sreset_counter = FF1 ^ FF2; 
		  if(w_count_done) begin
				p_Debounced = FF2; 
		  end 
	  end 
  end  

endmodule 