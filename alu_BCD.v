module alu_BCD (
    input wire [15:0] a,  // Primer número en formato BCD (4 dígitos, 16 bits)
    input wire [15:0] b,  // Segundo número en formato BCD (4 dígitos, 16 bits)
    input wire op,        // Operación: 0 = Suma, 1 = Resta
    output reg [15:0] result, // Resultado en formato BCD (4 dígitos)
    output reg carry,     // Indica si hubo un acarreo (suma) o un subacarreo (resta)
    output reg valid      // Indica si el resultado es válido en BCD
);

    reg [19:0] temp;      // Registro temporal para manejar sumas/restas y posibles correcciones
    integer i;            // Índice para iterar por cada dígito

    always @(*) begin
        carry = 0;
        valid = 1;
        temp = 0;

        // Operación: suma o resta
        if (op == 0) // Suma
            temp = {4'b0000, a} + {4'b0000, b};
        else         // Resta
            temp = {4'b0000, a} - {4'b0000, b};

        // Corrección BCD por cada dígito
        for (i = 0; i < 4; i = i + 1) begin
            // Extraer cada dígito del resultado
            if (temp[4*i +: 4] > 4'b1001) begin
                temp[4*i +: 4] = temp[4*i +: 4] + 4'b0110; // Corregir si excede 9
                if (i < 3)
                    temp[4*(i+1) +: 4] = temp[4*(i+1) +: 4] + 1; // Propagar acarreo
                else
                    carry = 1; // Acarreo en el último dígito
            end
        end

        // Verificar validez del resultado
        valid = (temp[19:16] == 0); // Si hay más de 4 dígitos, el resultado es inválido

        // Asignar el resultado final
        result = temp[15:0];
    end
endmodule
