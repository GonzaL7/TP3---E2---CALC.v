module disp (
    input [3:0] save_1,        // Entrada de 4 bits (save_1)
    input [3:0] save_2,        // Otra entrada de 4 bits (save_2)
    input [1:0] Op,            // Selector de operación 2 bits (Operation)
    input [1:0] display_state,
    output reg [3:0] display_out // Salida de 4 bits
);

    always @(*) begin
        case (display_state)
            2'b00: display_out <= save_1;       // Selecciona save_1
            2'b01: display_out <= Op;           // Selecciona save_2
            2'b10: display_out <= save_2;       // Selecciona save_2
            default: display_out <= 4'b1010;    // Valor por defecto
        endcase
    end

endmodule
