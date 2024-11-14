module ALU (
    input wire clk,     // Clock signal
    input wire clear,   // Reset signal
    input wire num1 [3:0],   
    input wire num2 [3:0],
    input reg op_selected,   // operacion apretada

    output reg [4:0] number_out, // 4-bit number



);

always @(posedge clk) begin
if (op_selected==0)
    number_out<=(num1+num2)
else if (op_selected==1) 
    number_out<=(num1-num2)
end

endmodule