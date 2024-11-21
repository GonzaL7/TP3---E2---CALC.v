module sincronize (
    input wire clk,          // Reloj
    input wire key_press,    // Entrada de la tecla
    output reg key_detect,    // Señal de detección de flanco
    input wire rst
);

    reg key_pressA; // Estado anterior de la tecla

    always @(posedge clk) begin

        if(rst)
            begin
                key_pressA <= 0;
                key_detect <= 0;
            end
        else
            begin
            // Detectar un flanco ascendente en key_press
                if (key_press == 1 && key_pressA == 0) 
                key_detect <= 1;  // Flanco ascendente detectado
            else 
                key_detect <= 0;  // No hay flanco ascendente

            // Actualizar el estado anterior
            key_pressA <= key_press;        
            end

        
    end

endmodule
