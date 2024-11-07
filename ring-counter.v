module ring_counter4(
  input wire clk,
  input wire reset,
  input wire enable,
  output reg A,
  output reg B,
  output reg C,
  output reg D);
 
 
always @(posedge clk) begin
  if (reset) begin
    B = 0;
    C = 0;
    D = 0;
    A = 1;
  end
  else if (enable) begin
    if (A) begin
      A = 0;
      C = 0;
      D = 0;
      B = 1;
    end
    else if (B) begin
      A = 0;
      B = 0;
      D = 0;
      C = 1;
    end
    else if (C) begin
      A = 0;
      B = 0;
      C = 0;
      D = 1;
    end
    else if (D) begin
      B = 0;
      C = 0;
      D = 0;
      A = 1;
    end
  end
 
end
 
endmodule