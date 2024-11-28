module ALU (
    input wire clk,                    // Señal de reloj
    input wire clear,                  // Señal de reinicio

    input wire [15:0] bcd1,            // Número 1 en BCD (16 bits)
    input wire [15:0] bcd2,            // Número 2 en BCD (16 bits)
    input wire [1:0] op_selected,      // Selector de operación: 01 suma, 10 resta

    output reg [15:0] bcd_out,         // Resultado de la operación en BCD
    output reg special_signal          // Señal especial para indicar resta
);

    // Señales para los módulos multiplicadores
    wire [13:0] mul10_out1, mul100_out1, mul1k_out1, mul10k_out1;
    wire [13:0] mul10_out2, mul100_out2, mul1k_out2, mul10k_out2;

    reg [13:0] bin1, bin2, bin_result; // Registros para almacenar los números en binario
    integer i;

    // Instanciar módulos multiplicadores para bcd1
    mul10 mul10_inst1 (.clk(clk), .in10(bcd1[3:0]), .out10(mul10_out1));
    mul100 mul100_inst1 (.clk(clk), .in100(bcd1[7:4]), .out100(mul100_out1));
    mul1k mul1k_inst1 (.clk(clk), .in1k(bcd1[11:8]), .out1k(mul1k_out1));

    // Instanciar módulos multiplicadores para bcd2
    mul10 mul10_inst2 (.clk(clk), .in10(bcd2[3:0]), .out10(mul10_out2));
    mul100 mul100_inst2 (.clk(clk), .in100(bcd2[7:4]), .out100(mul100_out2));
    mul1k mul1k_inst2 (.clk(clk), .in1k(bcd2[11:8]), .out1k(mul1k_out2));

    // Convertir BCD a binario
    always @(*) begin
        // Conversión de bcd1 a binario
        bin1 = mul10_out1 + mul100_out1 + mul1k_out1 + mul10k_out1;

        // Conversión de bcd2 a binario
        bin2 = mul10_out2 + mul100_out2 + mul1k_out2 + mul10k_out2;
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
