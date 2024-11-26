`timescale 1ns/10ps

module testbenchBoton;
// Variable RingCounter
reg clk, reset, enable;
wire C1, C2, C3, C4;

reg A, B, C, D;
wire boton;

deteccionBoton detectar(enable, C1, C2, C3, D, boton);
ring_counter4 select_col(clk, reset, enable, C1, C2, C3, C4);

initial begin
    enable = 0;
    A = 0;
    B = 0;
    C = 0;
    D = 0;
    clk = 0;
    reset = 1;
end

always
    #5 clk = ~clk;

initial begin
    // vvp nombre.out
    $dumpfile("SimulacionRingCounter.vcd"); 
    $dumpvars(1);

    #12 reset = 0;
    #10 enable = 1;

    #200 $finish;
end

endmodule
