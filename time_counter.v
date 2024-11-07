module time_counter(
    input wire clk,     // Clock signal
    input wire reset,   // Reset signal
    output reg [31:0] contador // 32-bit counter
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        contador <= 0; // Resetear el contador a 0
    end else begin
        contador <= contador + 1; // Incrementar el Contador
    end
end
endmodule
