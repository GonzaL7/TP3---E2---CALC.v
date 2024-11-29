module traduccion (
    input wire [5:0] input_teclado,  // 4-bit input where [3:2] are columns and [1:0] are rows
    input wire key_detect,           // Para que se detecte una UNICA vez
    output reg [3:0] traduccion  // 4-bit output representing the pressed key in binary
);

always @(*) begin
    if (key_detect) begin
        case (input_teclado)
            4'b0000: traduccion <= 4'b0001; // 1
            4'b0001: traduccion <= 4'b0010; // 2
            4'b0010: traduccion <= 4'b0011; // 3
            4'b0011: traduccion <= 4'b1010; // A
            4'b0100: traduccion <= 4'b0100; // 4
            4'b0101: traduccion <= 4'b0101; // 5
            4'b0110: traduccion <= 4'b0110; // 6
            4'b0111: traduccion <= 4'b1011; // B
            4'b1000: traduccion <= 4'b0111; // 7
            4'b1001: traduccion <= 4'b1000; // 8
            4'b1010: traduccion <= 4'b1001; // 9
            4'b1011: traduccion <= 4'b1100; // C
            4'b1100: traduccion <= 4'b1110; // *
            4'b1101: traduccion <= 4'b0000; // 0
            4'b1110: traduccion <= 4'b1111; // #
            4'b1111: traduccion <= 4'b1101; // D (=)
            default: traduccion <= 4'b0000; // Default case
        endcase
    end
        
    else begin
        traduccion <= 4'b0000;
    end 

end

endmodule

