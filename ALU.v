// Autor: GonzaL7
module ALU (
    input wire clk,                  // Clock signal
    input wire clear,                // Reset signal
    input wire [3:0] num1_ones,      // Units place of num1
    input wire [3:0] num1_tens,      // Tens place of num1
    input wire [3:0] num1_hundreds,  // Hundreds place of num1
    input wire [3:0] num1_thousands, // Thousands place of num1
    input wire [3:0] num2_ones,      // Units place of num2
    input wire [3:0] num2_tens,      // Tens place of num2
    input wire [3:0] num2_hundreds,  // Hundreds place of num2
    input wire [3:0] num2_thousands, // Thousands place of num2
    input wire op_selected,          // Operation selected: 0 for add, 1 for subtract
    output reg [3:0] result_ones,    // Units place of result
    output reg [3:0] result_tens,    // Tens place of result
    output reg [3:0] result_hundreds,// Hundreds place of result
    output reg [3:0] result_thousands// Thousands place of result
);

reg [4:0] temp_ones, temp_tens, temp_hundreds, temp_thousands; // Temporary 5-bit registers to hold intermediate results
reg carry;  // Carry/borrow flag

always @(posedge clk or posedge clear) begin
    if (clear) begin
        result_ones <= 4'b0;
        result_tens <= 4'b0;
        result_hundreds <= 4'b0;
        result_thousands <= 4'b0;
    end else begin
        // Step 1: Perform BCD addition/subtraction for each place, starting from units
        if (op_selected == 0) begin  // Addition
            temp_ones = num1_ones + num2_ones;
            carry = (temp_ones > 9);
            result_ones = carry ? (temp_ones - 10) : temp_ones;

            temp_tens = num1_tens + num2_tens + carry;
            carry = (temp_tens > 9);
            result_tens = carry ? (temp_tens - 10) : temp_tens;

            temp_hundreds = num1_hundreds + num2_hundreds + carry;
            carry = (temp_hundreds > 9);
            result_hundreds = carry ? (temp_hundreds - 10) : temp_hundreds;

            temp_thousands = num1_thousands + num2_thousands + carry;
            carry = (temp_thousands > 9);
            result_thousands = carry ? (temp_thousands - 10) : temp_thousands;

        end else begin  // Subtraction
            temp_ones = num1_ones - num2_ones;
            carry = (temp_ones[4] == 1);  // Check for borrow
            result_ones = carry ? (temp_ones + 10) : temp_ones;

            temp_tens = num1_tens - num2_tens - carry;
            carry = (temp_tens[4] == 1);
            result_tens = carry ? (temp_tens + 10) : temp_tens;

            temp_hundreds = num1_hundreds - num2_hundreds - carry;
            carry = (temp_hundreds[4] == 1);
            result_hundreds = carry ? (temp_hundreds + 10) : temp_hundreds;

            temp_thousands = num1_thousands - num2_thousands - carry;
            carry = (temp_thousands[4] == 1);
            result_thousands = carry ? (temp_thousands + 10) : temp_thousands;
        end
    end
end

endmodule
