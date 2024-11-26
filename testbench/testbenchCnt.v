`timescale 1ns / 1ps

module testbenchCnt;
// Señales del testbench
reg clkU;
reg rst_cntU;
reg numU;
wire cnt_outU;

cnt cnt_u(clkU, rst_cntU, numU,cnt_outU);

initial begin
    clkU <= 0;       
    rst_cntU <= 0; 
    numU <= 0;
end

always begin
    #5 clkU <= ~clkU;
end

initial begin
    $dumpfile("out_cnt.vcd");
    $dumpvars(2);

    #10 rst_cntU <= 1;
    #10 rst_cntU <= 0;

    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;

    #10 rst_cntU <= 1;
    #10 rst_cntU <= 0;

    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;
    #10 numU <= 1;
    #10 numU <= 0;

    #100 
    $finish;
end



endmodule