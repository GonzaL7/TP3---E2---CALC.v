`timescale 1ns / 1ps

module testbenchBCD2binary;

    // Señales para conectar al DUT
    reg [15:0] bcd;      // Entrada en BCD
    wire [13:0] bin;     // Salida en binario

    // Instancia del módulo a probar
    BCD2binary dut (
        .bcd(bcd),
        .bin(bin)
    );

    // Procedimiento para aplicar estímulos
    initial begin
        // Monitor para observar los resultados
        $monitor("Time = %0d | BCD = %b | Binario = %d", $time, bcd, bin);

        // Prueba 1: 0000_0001_0000_0001 (BCD: 1)
        bcd = 16'b0000_0000_0000_0001;
        #10;

        // Prueba 2: 0000_0001_0010_0011 (BCD: 123)
        bcd = 16'b0000_0001_0010_0011;
        #10;

        // Prueba 3: 0000_1001_1001_1001 (BCD: 999)
        bcd = 16'b0000_1001_1001_1001;
        #10;

        // Prueba 4: 0001_0100_0100_1001 (BCD: 1449)
        bcd = 16'b0001_0100_0100_1001;
        #10;

        // Prueba 5: 0010_0101_0011_0001 (BCD: 2531)
        bcd = 16'b0010_0101_0011_0001;
        #10;

        // Prueba 6: 0000_0000_0000_0000 (BCD: 0)
        bcd = 16'b0000_0000_0000_0000;
        #10;

        // Finalizar simulación
        $finish;
    end

endmodule
