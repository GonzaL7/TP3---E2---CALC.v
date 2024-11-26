module testbenchALU2;

    // Registros para las señales de entrada
    reg clk;
    reg clear;
    reg [15:0] bcd1;
    reg [15:0] bcd2;
    reg [1:0] op_selected;

    // Señales para las salidas
    wire [15:0] bcd_out;
    wire special_signal;

    // Instancia del módulo ALU_BCD
    ALU2 uut (
        .clk(clk),
        .clear(clear),
        .bcd1(bcd1),
        .bcd2(bcd2),
        .op_selected(op_selected),
        .bcd_out(bcd_out),
        .special_signal(special_signal)
    );

    // Generación del reloj
    always begin
        #5 clk = ~clk;  // Ciclo de reloj con periodo de 10 unidades de tiempo
    end

    // Inicialización de señales
    initial begin
        // Inicialización del reloj y señales
        clk = 0;
        clear = 0;
        bcd1 = 16'b0;
        bcd2 = 16'b0;
        op_selected = 2'b01;  // Suma por defecto

        // Desactivamos la señal de reinicio
        #10 clear = 1;
        #10 clear = 0;  // Desactivamos el reinicio

        // Test de Suma: bcd1 = 12 (0001 0010), bcd2 = 34 (0010 0100)
        #10 bcd1 = 16'b0001001000000000;  // BCD para 12
        #10 bcd2 = 16'b0010001100000000;  // BCD para 34
        #10 op_selected = 2'b01;  // Operación de suma
        #20;  // Esperar para ver el resultado

        // Test de Resta: bcd1 = 45 (0100 0101), bcd2 = 23 (0010 0011)
        #10 bcd1 = 16'b0100010100000000;  // BCD para 45
        #10 bcd2 = 16'b0010001100000000;  // BCD para 23
        #10 op_selected = 2'b10;  // Operación de resta
        #20;  // Esperar para ver el resultado

        // Test de Resta con señal especial: bcd1 = 15 (0001 0101), bcd2 = 25 (0010 0101)
        #10 bcd1 = 16'b0001010100000000;  // BCD para 15
        #10 bcd2 = 16'b0010010100000000;  // BCD para 25
        #10 op_selected = 2'b10;  // Operación de resta
        #20;  // Esperar para ver el resultado

        // Finalizar simulación
        $stop;
    end

    // Monitorear los resultados
    initial begin
        $monitor("Time = %t, bcd1 = %h, bcd2 = %h, op_selected = %b, bcd_out = %h, special_signal = %b", 
                  $time, bcd1, bcd2, op_selected, bcd_out, special_signal);
        #500 $finish;
    end

    

endmodule
