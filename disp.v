module disp (
    input wire [15:0] save1,
    input wire [15:0] save2,
    input [3:0] Op,            // Selector de operación 2 bits (Operation)
    input [1:0] display_state,
    output reg [15:0] display_out // Salida de 16 bits
);

    always @(*) begin
        case (display_state)
            2'b00: display_out <= save1;       // Selecciona save_1
            2'b01: display_out <= Op;           // Selecciona save_2
            2'b10: display_out <= save2;       // Selecciona save_2
            default: display_out <= 4'b1010;    // Valor por defecto
        endcase
    end

endmodule
