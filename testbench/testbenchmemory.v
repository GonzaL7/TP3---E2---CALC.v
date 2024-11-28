`timescale 1ns / 1ps

module memory_tb;

    // Entradas
    reg clk;
    reg [3:0] num;
    reg [15:0] res;
    reg [1:0] operator;
    reg clear_enable;
    reg equ_enable;
    reg [1:0] save_enable;
    reg op_enable;
    
    // Salidas
    wire [15:0] save1;
    wire [15:0] save2;
    wire [3:0] op_out;

    // Instancia del módulo memory
    memory uut (
        .clk(clk),
        .num(num),
        .res(res),
        .operator(operator),
        .clear_enable(clear_enable),
        .equ_enable(equ_enable),
        .save_enable(save_enable),
        .op_enable(op_enable),
        .save1(save1),
        .save2(save2),
        .op_out(op_out)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de reloj de 10 ns
    end

    // Proceso de prueba
    initial begin
        // Inicialización
        num = 4'b0000;
        res = 16'b0000000000000000;
        operator = 2'b00;
        clear_enable = 0;
        equ_enable = 0;
        save_enable = 2'b00;
        op_enable = 0;
        
        // Esperar algunos ciclos de reloj
        #10;

        // Test 1: Guardar en `save1` con `save_enable = 2'b01`
        save_enable = 2'b01;
        num = 4'b0001;  // Guardar el número 1
        res = 16'h1234; // Resultado para `save1`
        #10;  // Esperar 1 ciclo de reloj

        // Test 2: Guardar en `save1` con operación de desplazamiento
        num = 4'b0010;  // Guardar el número 2
        #10;

        // Test 3: Habilitar `clear_enable` y verificar que `save1` y `save2` se borren
        clear_enable = 1;
        #10;

        // Test 4: Guardar en `save2` con `save_enable = 2'b11`
        save_enable = 2'b11;
        num = 4'b0101;  // Guardar el número 5 en `save2`
        #10;

        // Test 5: Guardar operador con `save_enable = 2'b10`
        save_enable = 2'b10;
        operator = 2'b11; // Operador `11`
        #10;

        // Test 6: Verificar el estado con `clear_enable` activado
        clear_enable = 1;
        #10;

        // Finalización de la simulación
        $stop;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time = %t, num = %b, res = %h, operator = %b, clear_enable = %b, save_enable = %b, op_out = %b, save1 = %h, save2 = %h", 
                  $time, num, res, operator, clear_enable, save_enable, op_out, save1, save2);
        #20;
        $finish;
    end

endmodule
