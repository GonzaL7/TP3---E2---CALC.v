module tb_binary2BCD;

    reg [13:0] binary;    // Entrada binaria de 14 bits
    wire [15:0] bcd;      // Salida BCD de 25 bits
    
    // Instanciamos el módulo binary2BCD
    binary2BCD uut (
        .binary(binary),
        .bcd(bcd)
    );
    
    initial begin
        // Inicializamos la señal binaria
        binary = 14'd0;  // 0 en binario
        
        // Mostramos los resultados
        $monitor("decimal=%d, binary = %b, bcd = %b",binary, binary, bcd);
        
        // Prueba de valores binarios
        #10 binary = 14'd10;    // 10 en decimal
        #10 binary = 14'd15;    // 20 en decimal
        #10 binary = 14'd20;    // 50 en decimal
        #10 binary = 14'd100;   // 100 en decimal
        #10 binary = 14'd125;   // 150 en decimal
        #10 binary = 14'd150;   // 200 en decimal
        #10 binary = 14'd175;   // 300 en decimal
        #10 binary = 14'd200;  // 1000 en decimal
        #10 binary = 14'd210;  // 5000 en decimal
        #10 binary = 14'd255; // 10000 en decimal
        #10 binary = 14'd1150;   // 200 en decimal
        #10 binary = 14'd1175;   // 300 en decimal
        #10 binary = 14'd1200;  // 1000 en decimal
        #10 binary = 14'd1210;  // 5000 en decimal
        #10 binary = 14'd1255; // 10000 en decimal
        // Fin de la simulación
        #10 $finish;
    end

endmodule
