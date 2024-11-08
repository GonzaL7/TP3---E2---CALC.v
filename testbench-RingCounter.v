// Autor: @SantinoAggosti
`timescale 1ns/10ps
 
module testbenchRing;
 
reg clk, reset, enable;
wire A, B, C, D;
 
ring_counter4 select_col(clk, reset, enable, A, B, C, D);
 
initial begin
    clk = 0;
    reset = 1;
    enable = 0;
end
 
always
    #5 clk = ~clk;
 
initial begin
    // vvp nombre.out
    // Aca le pongo el nombre a mi archivo VCD - Se lo voy a dar a mi simulador
    $dumpfile("sim2.vcd"); 
    $dumpvars(1);
 
    #12 reset = 0;
    #10 enable = 1;
 
    #200 $finish;
  end
  
  endmodule