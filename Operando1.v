module Operando1(

    input wire clk,     // Clock signal
    input wire clear,   // Reset signal
    input wire num_pressed,   // numero apretado
    input reg op_selected,   // operacion apretada

    output reg [31:0] number1, // 32-bit counter
    output wire refresh_digit, // Enable que permite que el numero se actualize
    output reg shift_counter, // contador para saber cuanto shiftear  
    output reg save_1

);

always @(posedge clk) begin

end


endmodule
