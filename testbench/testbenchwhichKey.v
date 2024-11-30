`timescale 1ns / 1ps

module whichKey_tb;

    // Entradas
    reg rst;
    reg [3:0] key_pressed;

    // Salidas
    wire is_number;
    wire is_op;
    wire is_c;
    wire is_equ;
    wire [1:0] operator;

    // Instancia del módulo bajo prueba (UUT)
    whichKey uut (
        .rst(rst),
        .key_pressed(key_pressed),
        .is_number(is_number),
        .is_op(is_op),
        .is_c(is_c),
        .is_equ(is_equ),
        .operator(operator)
    );

    // Procedimiento inicial
    initial begin
        $dumpfile("./testbench/out/testbenchwhichKey.vcd");
        $dumpvars(2);

        rst = 1;
        #10;
        rst =0;
        // Inicialización de la señal de entrada
        key_pressed = 4'b0000; // Prueba para el número 0
        #10;
        
        key_pressed = 4'b0001; // Prueba para el número 1
        #10;

        key_pressed = 4'b1010; // Prueba para el operador A
        #10;

        key_pressed = 4'b1011; // Prueba para el operador B
        #10;

        key_pressed = 4'b1100; // Prueba para el operador C
        #10;

        key_pressed = 4'b1101; // Prueba para el operador D (<=)
        #10;

        key_pressed = 4'b1110; // Prueba para el operador especial (*)
        #10;

        key_pressed = 4'b1111; // Prueba para el operador especial (#)
        #10;

        key_pressed = 4'b1001; // Prueba para el número 9
        #10;

        key_pressed = 4'b0101; // Prueba para el número 5
        #10;

        key_pressed = 4'b0111; // Prueba para el número 7
        #10;

        key_pressed = 4'b0000; // Prueba para restablecer a 0
        #10;

        // Finalización de la simulación
        #100 $finish;
    end

    // Monitor para observar señales en tiempo real
    

endmodule
