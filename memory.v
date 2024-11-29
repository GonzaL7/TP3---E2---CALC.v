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

    // Lógica sincronizada con el reloj
    always @(posedge clk) begin
        // Borrado
        if (clear_enable) begin
            save1 <= 16'd0;
            save2 <= 16'd0;
            op_out <= 4'd0;
        end else begin
            // Guardar en save1
            if (save_enable == 2'b01) begin
                if (equ_enable) begin
                    save1 <= res;  // Guardar el resultado directamente
                end else begin
                    save1 <= (save1 << 4) + num; // Desplazamiento y adición
                end
            end

            // Guardar en op_out
            if (save_enable == 2'b10) begin
                op_out <= operator;
            end

            // Guardar en save2
            if (save_enable == 2'b11) begin
                save2 <= (save2 << 4) + num; // Desplazamiento y adición
            end
        end
    end

endmodule
