module binary2BCD(
    input [13:0] binary,  // Entrada de 14 bits
    output reg [15:0] bcd  // Salida de 25 bits para almacenar el BCD
);
    integer i;
    
    always @(binary) begin
        bcd = 14'b0;  // Inicializar a 0

        for (i = 13; i >= 0; i = i - 1) begin
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
