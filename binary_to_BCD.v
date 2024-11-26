module binary_to_BCD(
    input [7:0] binary,
    output reg [15:0] bcd
);
    integer i;
    always @(binary) begin
        bcd = 16'b0;  // Inicializar a 0

        for (i = 7; i >= 0; i = i - 1) begin
            // Ajuste BCD si algún dígito es 5 o más
            if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;
            if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
            if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;

            // Desplaza BCD y agrega el siguiente bit de binario
            bcd = {bcd[14:0], binary[i]};
        end
    end
endmodule
