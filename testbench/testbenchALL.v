`timescale 1ns/1ps

module testbenchALL;

// Declaración de señales
reg clk;
reg reset;
reg enable;
reg [3:0] filas;
wire [3:0] columnas;

wire [15:0] res;  // Resultado de la ALU
wire [15:0] display_out;

// Instancia del módulo a testear
topLevel uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .filas(filas),
    .columnas(columnas)
);

// Generador de reloj
initial begin
    clk = 0;
    forever #10 clk = ~clk; // Periodo de 20 ns
end

// Estímulos iniciales
initial begin
    // Inicialización de señales
    $dumpfile("testbenchALL.vcd");
    $dumpvars(4);

    reset = 1;
    enable = 0;
    filas = 4'b0000;

    // Desactivamos reset después de unos ciclos de reloj
    #50 reset = 0;
    enable = 1;

    // Simulación de entrada del teclado (ejemplo para suma)
    #100 filas = 4'b0001; // Presionar tecla 1
    #20 filas = 4'b0010; // Presionar tecla 2
    #20 filas = 4'b1000; // Presionar tecla "+"
    #20 filas = 4'b0100; // Presionar tecla 3
    #20 filas = 4'b0000; // Presionar tecla "="

    // Simulación de entrada del teclado (ejemplo para resta)
    #100 filas = 4'b0001; // Presionar tecla 5
    #20 filas = 4'b0010; // Presionar tecla "-"
    #20 filas = 4'b0100; // Presionar tecla 2
    #20 filas = 4'b0000; // Presionar tecla "="

    // Finalizar simulación
    #500 $finish;
end

// Monitor para ver las señales clave
//initial begin
//    $monitor($time, " Reset=%b, Enable=%b, Filas=%b, Resultado=%h, Display=%h", reset, enable, filas, res, display_out);
//end

endmodule
