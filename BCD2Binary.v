module BCD2binary (
    input [15:0] bcd,      // 4 dígitos en BCD (16 bits)
    output reg [13:0] bin  // Salida en binario (máximo 9999 en decimal = 14 bits)
);
    integer i; // Iterador para el ciclo

    always @(*) begin
        // Inicializar el resultado binario en 0
        bin = 0;

        // Procesar los 4 dígitos BCD
        for (i = 0; i < 4; i = i + 1) begin
            // Extraer cada dígito BCD y convertirlo a binario
            // Multiplicar el dígito por su peso decimal (10^posición)
            bin = bin + (bcd[(i * 4) +: 4] * (10 ** i));
        end
    end
endmodule
