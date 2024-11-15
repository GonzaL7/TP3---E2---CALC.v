module verificacion (
    input wire esperando_operador, 
    input wire numero_traducido [3:0],
    output wire salida [3:0],
    output wire enable_memoria;
);
  initial begin
    enable_memoria = 1;
  end

    always @(*) begin
        if (esperando_operador) begin
            if (numero_traducido != 4'b1111 && numero_traducido != 4'b1110) begin
                salida = 4'b111;
                enable_memoria = 0;
            end
        end
        else begin
            salida = numero_traducido;
            enable_memoria = 1;
        end
        
        end

endmodule