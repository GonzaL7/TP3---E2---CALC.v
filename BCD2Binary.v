module BCD_to_Binary(
    input [15:0] bcd,      // 4 BCD digits, each 4 bits
    output reg [7:0] binary
);
    always @(*) begin
        binary = (bcd[15:12] * 8'd1000) +
                 (bcd[11:8]  * 8'd100) +
                 (bcd[7:4]   * 8'd10) +
                 bcd[3:0];
    end
endmodule
