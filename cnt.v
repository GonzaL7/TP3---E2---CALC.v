module cnt (
    input wire clk,          // Señal de reloj
    input wire rst_cnt,      // Señal de reinicio
    input wire num,          // Señal para habilitar el conteo
    output reg cnt_out       // Salida de estado
);

    reg [2:0] contador;      // Registro de 3 bits para contar (0 a 7)

    always @(posedge clk) begin
        if (rst_cnt) 
        begin
            contador <= 3'b0;    // Reinicio del contador
            cnt_out <= 1'b0;     // Reinicio de la salida
        end 
        else begin
            if (num) 
            begin
                if (contador < 4) begin
                    contador <= contador + 1;
                    if(contador >= 3)
                        cnt_out <= 1'b1;
                    else
                    cnt_out <= 1'b0;
                end
                else begin
                    contador <= contador; // Mantener en 4 cuando alcanza el límite
                    cnt_out <= 1'b1;
                end
            end 
        end
            
          
        
            
        end

endmodule
