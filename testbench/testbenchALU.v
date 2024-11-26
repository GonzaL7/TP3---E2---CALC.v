`timescale 1ns / 1ps

module ALU_tb;

    // Entradas del DUT
    reg clk;
    reg clear;
    reg [15:0] num1;
    reg [15:0] num2;
    reg [1:0] op_selected;

    // Salida del DUT
    wire [16:0] number_out;

    // Instanciar el módulo ALU
    ALU dut (
        .clk(clk),
        .clear(clear),
        .num1(num1),
        .num2(num2),
        .op_selected(op_selected),
        .number_out(number_out),
        .special_signal(special_signal)        // Señal especial para indicar resta
    );

    // Generar el reloj
    always #5 clk = ~clk; // Periodo de 10 unidades de tiempo

    // Estímulos
    initial begin
        // Inicializar señales
        clk = 0;
        clear = 1;
        num1 = 0;
        num2 = 0;
        op_selected = 2'b00;

        // Ciclo de reinicio
        #100 clear = 0; 

        // Prueba 1: Suma (5 + 3)
        num1 = 16'd5;
        num2 = 16'd3;
        op_selected = 2'b01;
        @(posedge clk);  // Esperar un ciclo de reloj
        #100;  // Esperar un breve tiempo tras el flanco para observar la salida

        // Prueba 2: Resta (10 - 7)
        num1 = 16'd10;
        num2 = 16'd7;
        op_selected = 2'b10;
        @(posedge clk);
        #100;

        // Prueba 3: Suma grande (65535 + 1)
        num1 = 16'd65535;
        num2 = 16'd1;
        op_selected = 2'b01;
        @(posedge clk);
        #100;

        // Prueba 4: Resta negativa (5 - 10)
        num1 = 16'd26;
        num2 = 16'd16;
        op_selected = 2'b10;
        @(posedge clk);
        #100;

        // Prueba 4: Resta negativa (5 - 10)
        num1 = 16'd16;
        num2 = 16'd26;
        op_selected = 2'b10;
        @(posedge clk);
        #100;

        // Prueba 4: Resta negativa (5 - 10)
        num1 = 16'd26;
        num2 = 16'd16;
        op_selected = 2'b10;
        @(posedge clk);
        #100;

        // Prueba 5: Operación no definida
        op_selected = 2'b11;
        @(posedge clk);
        #100;

        // Finalizar simulación
        $finish;
    end

    // Monitor para observar los resultados
    initial begin
        $monitor("Time=%0t | Clear=%b | Num1=%d | Num2=%d | Op=%b | Result=%d | Sign=%d",
                 $time, clear, num1, num2, op_selected, number_out, special_signal);
    end

endmodule
