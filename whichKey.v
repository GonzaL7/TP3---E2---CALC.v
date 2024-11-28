module whichKey (
    input wire [3:0] key_pressed,   // Entrada: tecla traducida (salida de `traduccion_teclado`)
    output reg is_number,           // Salida: 1 si es número (0–9), 0 si es operador
    output reg is_op,               // Señal alta si es un operador (A, B, etc.)
    output reg is_c,                // Señal alta si es 'C'
    output reg is_equ,              // Señal alta si es 'D' (<=)
    output reg [1:0] operator       // Identificador del operador (A<=2'b01, B<=2'b10, etc.)
);

always @(*) begin
    // Inicializar todas las salidas
    is_number <= 0;
    is_op <= 0;
    is_c <= 0;
    is_equ <= 0;
    operator <= 2'b00;

    // Evaluar la tecla presionada
    case (key_pressed)
        // Números (0-9)
        4'b0000, // 0
        4'b0001, // 1
        4'b0010, // 2
        4'b0011, // 3
        4'b0100, // 4
        4'b0101, // 5
        4'b0110, // 6
        4'b0111, // 7
        4'b1000, // 8
        4'b1001: // 9
            is_number <= 1;

        // Operador A
        4'b1010: begin
            operator <= 2'b01;
            is_op <= 1;
        end

        // Operador B
        4'b1011: begin
            operator <= 2'b10;
            is_op <= 1;
        end

        // Operador C
        4'b1100: begin
            is_c <= 1;
        end

        // Operador D (<=)
        4'b1101: begin
            is_equ <= 1;
        end

        // Operadores especiales (* y #)
        4'b1110, // *
        4'b1111: // #
            is_op <= 1;

        default: begin
            // Valor por defecto
            is_number <= 0;
            is_op <= 0;
            is_c <= 0;
            is_equ <= 0;
            operator <= 2'b00;
        end
    endcase
end

endmodule
