module ALU (
    input wire clk,                  // Señal de reloj
    input wire clear,                // Señal de reinicio
    input wire [15:0] num1,          // Entrada de 16 bits: número 1
    input wire [15:0] num2,          // Entrada de 16 bits: número 2
    input wire [1:0] op_selected,    // Selector de operación: 00 suma, 01 resta
    output reg [16:0] number_out,    // Salida de 17 bits para manejar acarreo
    output reg special_signal        // Señal especial para indicar resta
);

always @(posedge clk or posedge clear) begin
    if (clear) begin
        number_out <= 17'b0;          // Reiniciar salida a cero
        special_signal <= 0;          // Reiniciar señal especial a cero
    end else begin
        case (op_selected)
            2'b01: begin
                number_out <= num1 + num2;      // Suma
                special_signal <= 0;            // No es una resta
            end
            2'b10: begin
                // Resta (complemento a 2)
                if (num1 >= num2) begin
                    number_out <= num1 + (~num2 + 1);  // Resta directa
                    special_signal <= 0; 
                end else begin 
                    number_out <= num2 + (~num1 + 1);  // Resta directa
                    special_signal <= 1;            // Señal especial activada por resta
                end
                
            end
            default: begin
                number_out <= 17'b0;             // Caso por defecto
                special_signal <= 0;             // No es una operación válida
            end
        endcase
    end
end

endmodule
