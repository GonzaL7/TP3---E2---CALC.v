module disp (
    input wire clk,                 // Reloj para la lógica secuencial
    input wire reset,               // Señal de reinicio
    input wire [15:0] save1,        // Entrada de datos (16 bits) para save1
    input wire [15:0] save2,        // Entrada de datos (16 bits) para save2
    input wire display_state,       // Señal para seleccionar save1 (0) o save2 (1)
    output reg [3:0] display_out,   // Salida de 4 bits (nibble para el display)
    output reg sync                 // Señal de sincronización
);

    reg [1:0] state;                // Estado actual (2 bits para 4 estados)
    wire [15:0] selected_data;      // Datos seleccionados (save1 o save2)

    // Seleccionar entre save1 y save2 basado en display_state
    assign selected_data = (display_state == 1'b0) ? save1 : save2;

    // Lógica secuencial para actualizar el estado
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;         // Reinicia al primer estado
        end else begin
            state <= state + 1;     // Avanza al siguiente estado
        end
    end

    // Lógica combinacional para seleccionar el nibble correspondiente
    always @(*) begin
        case (state)
            2'b00: display_out = selected_data[3:0];    // Primer nibble (bits 3:0)
            2'b01: display_out = selected_data[7:4];    // Segundo nibble (bits 7:4)
            2'b10: display_out = selected_data[11:8];   // Tercer nibble (bits 11:8)
            2'b11: display_out = selected_data[15:12];  // Cuarto nibble (bits 15:12)
            default: display_out = 4'b0000;             // Valor por defecto
        endcase
    end

    // Generar la señal de sincronización
    always @(*) begin
        if (state == 2'b00) begin
            sync = 1'b1;            // Activa sync cuando el estado es 0
        end else begin
            sync = 1'b0;            // Desactiva sync en otros estados
        end
    end

endmodule
