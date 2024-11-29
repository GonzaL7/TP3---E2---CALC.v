`timescale 1ns / 1ps

module topLevel_tb;

  // Entradas y salidas del DUT (Device Under Test)
  reg clk;
  reg reset;
  wire enableTECL;
  wire [3:0] filas;
  wire [3:0] columnas;
  wire [5:0] indice_boton;
  wire key_press;
  wire key_detect;
  wire [3:0] keyPressed;
  wire num;
  wire op;
  wire c;
  wire equ;
  wire [1:0] operator;
  wire cnt_out;

  // Instancia del módulo topLevel
  topLevel dut (
    .clk(clk),
    .reset(reset)
  );

  // Generador de reloj
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Reloj con periodo de 10 ns
  end

  // Estímulos iniciales
  initial begin
    // Inicialización
    reset = 1;
    #20;  // Espera para que se propague el reset
    reset = 0;

    // Simulación de filas del teclado
    // Sucesión de pulsaciones
    // Nota: deberás conectar los estímulos a las señales del DUT según sea necesario.
    #10 filas = 4'b0001;  // Primera fila activada
    #10 filas = 4'b0010;  // Segunda fila activada
    #10 filas = 4'b0100;  // Tercera fila activada
    #10 filas = 4'b1000;  // Cuarta fila activada
    #10 filas = 4'b0000;  // Ninguna fila activa

    // Termina la simulación
    #100;
    $finish;
  end

  // Monitoreo de señales clave
  initial begin
    $monitor("Time: %0d, keyPressed: %b, operator: %b, cnt_out: %b",
             $time, keyPressed, operator, cnt_out);
  end

endmodule