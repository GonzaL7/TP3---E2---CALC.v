module multiplier (
    input wire clk,             // Señal de reloj
    input wire start,           // Señal para iniciar la multiplicación
    input wire [15:0] num1,     // Primer número (16 bits)
    input wire [15:0] num2,     // Segundo número (16 bits)
    output reg [31:0] result,   // Resultado del producto (32 bits)
    output reg ready            // Señal que indica que el resultado está listo
);

    reg [15:0] count;           // Contador para realizar las sumas
    reg [31:0] partial_sum;     // Acumulador para las sumas

    reg active;                 // Señal interna para indicar que el módulo está trabajando

    always @(posedge clk) begin
        if (start) begin
            // Inicialización al recibir la señal de inicio
            count <= num2;       // Contador inicial igual al multiplicador
            partial_sum <= 0;    // Resultado parcial inicializado a 0
            result <= 0;         // Resultado final en 0
            ready <= 0;          // Resultado aún no listo
            active <= 1;         // Activar el cálculo
        end else if (active) begin
            if (count > 0) begin
                partial_sum <= partial_sum + num1;  // Sumar el multiplicando
                count <= count - 1;                // Decrementar el contador
            end else begin
                // Finalizar la operación cuando el contador llega a 0
                result <= partial_sum;             // Resultado final
                ready <= 1;                        // Indicar que el resultado está listo
                active <= 0;                       // Desactivar el cálculo
            end
        end
    end

endmodule