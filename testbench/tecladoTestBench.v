`timescale 1ns / 1ps

module teclado_tb;
  // Inputs to the teclado module
  reg enable;
  reg clk;
  reg reset;
  reg [3:0] filas;

  // Outputs from the teclado module
  wire [3:0] columnas;
  wire button_pressed;
  wire [4:0] indice_boton;
  wire [2:0] columna_actual;
  wire [2:0] fila_actual;

  // Instantiate the teclado module
  teclado uut (
    .enable(enable),
    .clk(clk),
    .reset(reset),
    .filas(filas),
    .columnas(columnas),
    .indice_boton(indice_boton),
    .columna_actual(columna_actual),
    .fila_actual(fila_actual),
    .button_pressed(button_pressed)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns clock period
  end

  // Test sequence
  initial begin
    // Initialize inputs
    $dumpfile("WavesTeclado.vcd");
    $dumpvars(2);
    enable = 0;
    reset = 1;
    filas = 4'b0000;

    // Wait for global reset
    #20;
    reset = 0;

    // Enable the module
    enable = 1;

    // Test case 1: No button pressed
    filas = 4'b0000;
    #50;
    $display("Test 1: No button pressed");
    $display("indice_boton = %b, columna_actual = %b, fila_actual = %b, button_pressed = %b", 
             indice_boton, columna_actual, fila_actual, button_pressed);

    // Test case 2: Button in column 1, row 1 pressed
    filas = 4'b0001; // Row 1 active
    #50;
    $display("Test 2: Button in column 1, row 1 pressed");
    $display("indice_boton = %b, columna_actual = %b, fila_actual = %b, button_pressed = %b", 
             indice_boton, columna_actual, fila_actual, button_pressed);

    // Test case 3: Button in column 2, row 2 pressed
    filas = 4'b0010; // Row 2 active
    #50;
    $display("Test 3: Button in column 2, row 2 pressed");
    $display("indice_boton = %b, columna_actual = %b, fila_actual = %b, button_pressed = %b", 
             indice_boton, columna_actual, fila_actual, button_pressed);

    // Test case 4: Button in column 3, row 3 pressed
    filas = 4'b0100; // Row 3 active
    #50;
    $display("Test 4: Button in column 3, row 3 pressed");
    $display("indice_boton = %b, columna_actual = %b, fila_actual = %b, button_pressed = %b", 
             indice_boton, columna_actual, fila_actual, button_pressed);

    // Test case 5: Reset the system
    reset = 1;
    #20;
    reset = 0;
    #50;
    $display("Test 5: After reset");
    $display("indice_boton = %b, columna_actual = %b, fila_actual = %b, button_pressed = %b", 
             indice_boton, columna_actual, fila_actual, button_pressed);

    // End simulation
    $finish;
  end
endmodule
