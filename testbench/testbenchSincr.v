module testbenchSincr ;

reg clk;          // Reloj
reg key_press;    // Entrada de la tecla
wire key_detect;    // Señal de detección de flanco
reg rst;

sincronize sincronize_u(clk,key_press, key_detect,rst); 

initial begin
    clk <= 0;       
    key_press <= 0; 
    rst <= 1;
end

always begin
    #5 clk <= ~clk;
end

initial begin
    $dumpfile("Out.vcd");
    $dumpvars(2);
    #10 rst <= 0;
    #25 key_press <= 1;
    #30 key_press <= 0;
    #200 
    $finish;
end


endmodule