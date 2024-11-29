module memory (
    input wire clk,
    input wire [3:0] num,
    input wire [15:0] res,
    input wire [1:0] operator,
    input wire clear_enable,
    input wire equ_enable,
    input wire [1:0] save_enable,
    input wire op_enable,
    
    output reg [15:0] save1,
    output reg [15:0] save2,
    output reg [3:0] op_out
);

    always @(*) begin
        if (save_enable == 2'b01) begin
            if (~clear_enable) begin
                if (equ_enable) begin
                    save1 <= res;  // Posible redundancia
                end
                else begin
                    save1 <= (save1 << 4) + num;
                end
            end
            else begin
                save1 <= 0;
                save2 <= 0;
            end
        end

        if (save_enable == 2'b10) begin
            if (~clear_enable) begin
                op_out <= operator;
            end
            else begin
                save1 <= 0;
                save2 <= 0;
                op_out <= 0; 
            end
        end

        if (save_enable == 2'b11) begin
            if (~clear_enable) begin
                save2 <= (save2 << 4) + num;
            end
            else begin
                save1 <= 0;
                save2 <= 0;
            end
        end
    end

endmodule
