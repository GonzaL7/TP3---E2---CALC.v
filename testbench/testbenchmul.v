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

    // Señales para mul10k
    reg [3:0] in10k;
    wire [15:0] out10k;

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
        in10k = 0;

        // Esperar al inicio del reloj
        #10;

        // Prueba 1: Multiplicar por 10
        in10 = 4'd1; // 3 * 10 = 30
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd2;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd3;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd4;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd5;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd6;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd7;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd8;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;
        in10 = 4'd9;
        #10;
        $display("mul10: in10=%d, out10=%d", in10, out10);
        #10;


        // Prueba 2: Multiplicar por 100
        in100 = 4'd1;
        #10;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd2;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd3;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd4;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd5;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd6;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd7;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd8;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd9;
        $display("mul100: in100=%d, out100=%d", in100, out100);
        #10;
        in100 = 4'd10;
        $display("mul100: in100=%d, out100=%d", in100, out100);

        // Prueba 3: Multiplicar por 1000
        in1k = 4'd5; // 5 * 1000 = 5000
        #10;
        $display("mul1k: in1k=%d, out1k=%d (Esperado: 5000)", in1k, out1k);


        // Pruebas adicionales
        #10;
        in10 = 4'd9;  // 9 * 10 = 90
        in100 = 4'd2; // 2 * 100 = 200
        in1k = 4'd8;  // 8 * 1000 = 8000
        in10k = 4'd1; // 1 * 10000 = 10000
        #10;
        $display("mul10: in10=%d, out10=%d (Esperado: 90)", in10, out10);
        $display("mul100: in100=%d, out100=%d (Esperado: 200)", in100, out100);
        $display("mul1k: in1k=%d, out1k=%d (Esperado: 8000)", in1k, out1k);

        // Terminar la simulación
        #20;
        $finish;
    end
endmodule
