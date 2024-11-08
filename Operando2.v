// Autor: @Sanmarr

module Operando2(

    input wire clk,     // Clock signalz
    input wire clear,   // Reset signal
    input wire num_pressed,   // numero apretado
    input reg op_selected,   // operacion apretada
    input wire equal,   // Igual para resultado

    output reg [31:0] number1, // 32-bit counter
    output wire refresh_digit, // Enable que permite que el numero se actualize
    output reg shift_counter, // contador para saber cuanto shiftear  
    output reg save_2

);

always @(posedge clk) begin

end


endmodule
