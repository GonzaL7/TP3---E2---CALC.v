module teclado(
  input enable,
  input clk,
  input reset,
  input wire [3:0] filas;
  output reg [3:0] columnas;
  output reg [5:0] indice_boton; // Primeros 3 bits, posicion de columna (Si el MSB es 1, HAY UN ERROR) # Segundos dos bits, posicion de fila (Si el MSB esta en uno, ningun boton fue apretado)
  output reg button_pressed);

  reg columna_actual[2:0], fila_actual[2:0];

  // Itero las cuatro columnas
  ring_counter ring(clk, reset, enable, columnas[0], columnas[1], columnas[2], columnas[3]);
  deteccionBoton detectar_boton(enable, fila[0], fila[1], fila[2], fila[3], button_pressed)

initial begin
  reset = 1;
  enable = 0;
end
 // Necesito que sea independiente de Clk.
 // @(*) hace que sea un bloque combinacional

always @(*) begin

  if (reset)begin

  end
  enable = 1;
  reset = 0;

  // Logica de Deteccion de Columnas
  case (columnas)
    4'b0001: columna_actual = 3'b000; // Si la primer columna es 1
    4'b0010: columna_actual = 3'b001; // Si la segunda columna es 1 
    4'b0100: columna_actual = 3'b010; // Si la tercer columna es 1
    4'b1000: columna_actual = 3'b011; // Si la cuarta columna es 1
    4'b0000: columna_actual = 3'b100; // Si NINGUNA columna esta en 1 (POSIBLE ERROR)
    default: columna_actual = 3'b101; // Caso Default (Hay algo muy raro) DEFINITIVAMENTE UN ERROR
  endcase

  // Logica de Deteccion de Fila
  if (button_pressed == 1) begin
    case (filas) 
      4'b0001: fila_actual = 3'b000; // Si la primer fila esta en 1 
      4'b0010: fila_actual = 3'b001; // Si la segunda fila esta en 1
      4'b0100: fila_actual = 3'b010; // Si la tercer fila esta en 1
      4'b1000: fila_actual = 3'b011; // Si la cuarta fila esta en 1
      
      4'b0000: fila_actual = 3'b100; // Si NINGUNA fila esta en 1
      default: fila_actual = 3'b100; // Caso Default
    endcase
    
    indice_boton[2:0] <= fila_actual;
    indice_boton[5:3] <= columna_actual;
  end
  else begin // Me aseguro de avisarle que ningun boton se esta apretando!
    indice_boton[2:0] <= 3'b100;
  end
end
endmodule