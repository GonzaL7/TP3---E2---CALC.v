`timescale 1ns/1ps

module traduccion_tb;

// Declaración de señales
reg [5:0] input_teclado;    // Entrada del teclado
reg key_detect;             // Señal para detectar la tecla presionada
wire [3:0] traduccion;      // Salida traducida

// Instancia del módulo a probar
traduccion uut (
    .input_teclado(input_teclado),
    .key_detect(key_detect),
    .traduccion(traduccion)
);

// Estímulos iniciales
initial begin
    // Inicializamos señales
    key_detect = 0;
    input_teclado = 6'b000000;

    // Caso 1: Presionar tecla "1"
    #10 input_teclado = 6'b000000; key_detect = 1;
    #10 key_detect = 0;

    // Caso 2: Presionar tecla "2"
    #10 input_teclado = 6'b000001; key_detect = 1;
    #10 key_detect = 0;

    // Caso 3: Presionar tecla "3"
    #10 input_teclado = 6'b000010; key_detect = 1;
    #10 key_detect = 0;

    // Caso 4: Presionar tecla "A"
    #10 input_teclado = 6'b000011; key_detect = 1;
    #10 key_detect = 0;

    // Caso 5: Presionar tecla "*"
    #10 input_teclado = 6'b1100; key_detect = 1;
    #10 key_detect = 0;

    // Caso 6: Presionar tecla "=" (D)
    #10 input_teclado = 6'b1111; key_detect = 1;
    #10 key_detect = 0;

    // Caso 7: Presionar tecla no definida
    #10 input_teclado = 6'b101100; key_detect = 1;
    #10 key_detect = 0;

    // Finaliza la simulación
    #50 $stop;
end

// Monitor para ver las señales
initial begin
    $monitor($time, " input_teclado=%b, key_detect=%b, traduccion=%b", input_teclado, key_detect, traduccion);
end

endmodule
