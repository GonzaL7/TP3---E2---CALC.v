`timescale 1ns / 1ps

module tb_multiplicadores;

    // Señales para mul10
    reg clk;
    reg [3:0] in10;
    wire [13:0] out10;

    // Señales para mul100
    reg [3:0] in100;
    wire [13:0] out100;

    // Señales para mul1k
    reg [3:0] in1k;
    wire [13:0] out1k;

    // Instanciar los módulos
    mul10 uut_mul10 (
        .clk(clk),
        .in10(in10),
        .out10(out10)
    );

    mul100 uut_mul100 (
        .clk(clk),
        .in100(in100),
        .out100(out100)
    );

    mul1k uut_mul1k (
        .clk(clk),
        .in1k(in1k),
        .out1k(out1k)
    );

    // Generación de la señal de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Prueba principal
    initial begin
        // Inicialización
        in10 = 0;
        in100 = 0;
        in1k = 0;

        // Esperar al inicio del reloj
        #10;

        // Pruebas para mul10
        $display("Pruebas para mul10");
        for (integer i = 1; i <= 9; i = i + 1) begin
            in10 = i;
            #10;
            $display("mul10: in10=%d, out10=%d (Esperado: %d)", in10, out10, i * 10);
        end

        // Pruebas para mul100
        $display("\nPruebas para mul100");
        for (integer i = 1; i <= 9; i = i + 1) begin
            in100 = i;
            #10;
            $display("mul100: in100=%d, out100=%d (Esperado: %d)", in100, out100, i * 100);
        end

        // Pruebas para mul1k
        $display("\nPruebas para mul1k");
        for (integer i = 1; i <= 9; i = i + 1) begin
            in1k = i;
            #10;
            $display("mul1k: in1k=%d, out1k=%d (Esperado: %d)", in1k, out1k, i * 1000);
        end

        // Finalizar simulación
        $display("\nPruebas completas.");
        #20;
        $finish;
    end

endmodule
