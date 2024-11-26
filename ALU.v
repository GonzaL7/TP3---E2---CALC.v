// Autor: GonzaL7


module ALU (
    input wire clk,                  // Clock signal
    input wire clear,                // Reset signal
    input wire [15:0] num1,          // 16-bit input number 1
    input wire [15:0] num2,          // 16-bit input number 2
    input wire op_selected,          // Operation selected: 0 for add, 1 for subtract
    output reg [16:0] number_out     // 17-bit output to handle carry
);

always @(posedge clk or posedge clear) begin
    if (clear) begin
        number_out <= 17'b0;         // Reset output to zero on clear signal
    end
    else begin
        if (op_selected == 0)
            number_out <= num1 + num2;  // Addition
        else
            number_out <= num1 - num2;  // Subtraction
    end
end

endmodule
