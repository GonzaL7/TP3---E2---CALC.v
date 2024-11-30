`timescale 1ns / 1ps

module sincronize_tb;

    // Entradas
    reg clk;
    reg key_press;
    reg rst;

    // Salidas
    wire key_detect;

    // Instancia del módulo sincronize
    sincronize uut (
        .clk(clk),
        .key_press(key_press),
        .key_detect(key_detect),
        .rst(rst)
    );

    // Generador de reloj (50 MHz -> Periodo = 20 ns)
    always #10 clk = ~clk;

    // Procedimiento inicial
    initial begin
        $dumpfile("./testbench/out/testbenchsincronize.vcd");
        $dumpvars(2);

        // Inicialización de señales
        clk = 0;
        key_press = 0;
        rst = 1;  // Reset activo

        // Liberar reset después de 40 ns
        #40;
        rst = 0;

        // Simular flancos en la señal key_press
        #20 key_press = 1;  // Flanco ascendente
        #20 key_press = 0;  // Flanco descendente
        #30 key_press = 1;  // Flanco ascendente
        #30 key_press = 0;  // Flanco descendente
        #40 key_press = 1;  // Flanco ascendente
        #40 key_press = 0;  // Flanco descendente
        #50 key_press = 1;  // Flanco ascendente
        #50 key_press = 0;  // Flanco descendente


        // Reactivar reset
        #20 rst = 1;
        #20 rst = 0;

        // Simular más flancos en key_press
        #30 key_press = 1;  // Flanco ascendente
        #30 key_press = 0;  // Flanco descendente

        // Finalizar simulación
        #100 $finish;
    end

endmodule
