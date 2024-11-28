module ALU (
    input wire clk,                  // Clock signal
    input wire clear,                // Reset signal
    input wire [15:0] bcd1,          // Operand 1 in BCD (16 bits)
    input wire [15:0] bcd2,          // Operand 2 in BCD (16 bits)
    input wire [1:0] op_selected,    // Operation selector: 01 add, 10 subtract
    input wire [1:0] alu_enable,     // ALU enable signal

    output reg [15:0] bcd_out,       // Result in BCD
    output reg special_signal        // Special signal for subtraction
);

    // Internal signals for binary conversion
    wire [13:0] mul10_out1, mul100_out1, mul1k_out1;
    wire [13:0] mul10_out2, mul100_out2, mul1k_out2;

    reg [13:0] bin1, bin2, bin_result; // Binary registers
    integer i;

    // Instantiate multiplier modules for BCD to binary conversion
    mul10 mul10_inst1 (.clk(clk), .in10(bcd1[3:0]), .out10(mul10_out1));
    mul100 mul100_inst1 (.clk(clk), .in100(bcd1[7:4]), .out100(mul100_out1));
    mul1k mul1k_inst1 (.clk(clk), .in1k(bcd1[11:8]), .out1k(mul1k_out1));

    mul10 mul10_inst2 (.clk(clk), .in10(bcd2[3:0]), .out10(mul10_out2));
    mul100 mul100_inst2 (.clk(clk), .in100(bcd2[7:4]), .out100(mul100_out2));
    mul1k mul1k_inst2 (.clk(clk), .in1k(bcd2[11:8]), .out1k(mul1k_out2));

    // Convert BCD to binary
    always @(*) begin
        bin1 = mul10_out1 + mul100_out1 + mul1k_out1;
        bin2 = mul10_out2 + mul100_out2 + mul1k_out2;
    end

    // ALU operation: Perform arithmetic based on alu_enable and op_selected
    always @(posedge clk or posedge clear) begin
        if (clear) begin
            bin_result <= 14'b0;
            special_signal <= 0;
        end else if (alu_enable == 2'b01) begin
            case (op_selected)
                2'b01: begin
                    bin_result <= bin1 + bin2;  // Addition
                    special_signal <= 0;
                end
                2'b10: begin
                    if (bin1 >= bin2) begin
                        bin_result <= bin1 - bin2;  // Subtraction
                        special_signal <= 0;
                    end else begin
                        bin_result <= bin2 - bin1;  // Subtraction
                        special_signal <= 1;
                    end
                end
                default: begin
                    bin_result <= 14'b0;  // Default case
                    special_signal <= 0;
                end
            endcase
        end
    end

    // Convert binary result to BCD
    always @(*) begin
        bcd_out = 16'b0;

        for (i = 13; i >= 0; i = i - 1) begin
            if (bcd_out[3:0] >= 5) bcd_out[3:0] = bcd_out[3:0] + 3;
            if (bcd_out[7:4] >= 5) bcd_out[7:4] = bcd_out[7:4] + 3;
            if (bcd_out[11:8] >= 5) bcd_out[11:8] = bcd_out[11:8] + 3;
            if (bcd_out[15:12] >= 5) bcd_out[15:12] = bcd_out[15:12] + 3;

            bcd_out = {bcd_out[14:0], bin_result[i]};
        end
    end

endmodule

