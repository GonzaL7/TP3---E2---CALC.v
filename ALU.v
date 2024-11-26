module ALU (
    input wire clk,                    // Señal de reloj
    input wire clear,                  // Señal de reinicio
    input wire [15:0] bcd1,            // Número 1 en BCD (16 bits)
    input wire [15:0] bcd2,            // Número 2 en BCD (16 bits)
    input wire [1:0] op_selected,      // Selector de operación: 00 suma, 01 resta
    output reg [15:0] bcd_out,         // Resultado de la operación en BCD
    output reg special_signal          // Señal especial para indicar resta
);
    reg [13:0] bin1, bin2, bin_result; // Registros para almacenar los números en binario
    integer i;

    // Convertir BCD a binario
    always @(*) begin
        // Conversión de bcd1 a binario
        bin1 = 0;
        for (i = 0; i < 4; i = i + 1) begin
            bin1 = bin1 + (bcd1[(i * 4) +: 4] * (10 ** i));
        end

        // Conversión de bcd2 a binario
        bin2 = 0;
        for (i = 0; i < 4; i = i + 1) begin
            bin2 = bin2 + (bcd2[(i * 4) +: 4] * (10 ** i));
        end
    end

    // ALU: Operación aritmética
    always @(*) begin
        if (clear) begin
            bin_result <= 14'b0;           // Reiniciar el resultado binario
            special_signal <= 0;           // Reiniciar señal especial
        end else begin
            case (op_selected)
            2'b01: begin
                bin_result <= bin1 + bin2;      // Suma
                special_signal <= 0;            // No es una resta
            end
            2'b10: begin
                // Resta (complemento a 2)
                if (bin1 >= bin2) begin
                    bin_result <= bin1 + (~bin2 + 1);  // Resta directa
                    special_signal <= 0; 
                end else begin 
                    bin_result <= bin2 + (~bin1 + 1);  // Resta directa
                    special_signal <= 1;            // Señal especial activada por resta
                end
                
            end
                default: begin
                    bin_result <= 14'b0;         // Caso por defecto
                    special_signal <= 0;         // No es una operación válida
                end
            endcase
        end
    end

    // Convertir el resultado binario a BCD
    always @(bin_result) begin
        // Conversión de binario a BCD
        bcd_out = 16'b0;  // Inicializar a 0

        for (i = 13; i >= 0; i = i - 1) begin
            // Ajuste BCD si algún dígito es 5 o más
            if (bcd_out[3:0] >= 5) bcd_out[3:0] = bcd_out[3:0] + 3;
            if (bcd_out[7:4] >= 5) bcd_out[7:4] = bcd_out[7:4] + 3;
            if (bcd_out[11:8] >= 5) bcd_out[11:8] = bcd_out[11:8] + 3;
            if (bcd_out[15:12] >= 5) bcd_out[15:12] = bcd_out[15:12] + 3;

            // Desplazar BCD y agregar el siguiente bit de binario
            bcd_out = {bcd_out[14:0], bin_result[i]};
        end
    end

endmodule
