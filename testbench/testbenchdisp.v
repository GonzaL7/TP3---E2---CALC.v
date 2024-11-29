`timescale 1ns / 1ps

module disp_tb;

    // Registros para las señales de entrada
    reg clk;
    reg reset;
    reg [15:0] save1;
    reg [15:0] save2;
    reg display_state;

    // Cables para las señales de salida
    wire [3:0] display_out;
    wire sync;

    // Instancia del módulo disp
    disp uut (
        .clk(clk),
        .reset(reset),
        .save1(save1),
        .save2(save2),
        .display_state(display_state),
        .display_out(display_out),
        .sync(sync)
    );

    // Generación del reloj
    always begin
        #5 clk = ~clk;  // Periodo de reloj de 10 unidades de tiempo
    end

    // Inicialización de señales y pruebas
    initial begin
        // Inicialización
        clk = 0;
        reset = 0;
        save1 = 16'h1234;   // Datos iniciales para save1
        save2 = 16'h5678;   // Datos iniciales para save2
        display_state = 0;  // Seleccionar save1 inicialmente

        // Reinicio del sistema
        #10 reset = 1;
        #10 reset = 0;

        // Prueba con save1
        display_state = 0; // Usar save1
        #100;  // Esperar algunos ciclos para verificar los estados

        // Prueba con save2
        display_state = 1; // Usar save2
        #100;  // Esperar algunos ciclos para verificar los estados

        // Finalizar simulación
        $finish;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time: %0t | reset: %b | display_state: %b | display_out: %h | sync: %b",
                 $time, reset, display_state, display_out, sync);
    end

endmodule
