module teclado(
  input wire enable,
  input wire clk,
  input wire reset,
  input wire [3:0] filas,
  output wire [3:0] columnas,
  output reg [4:0] indice_boton, // Primeros 3 bits: columna | Siguientes 3 bits: fila
  output reg [2:0] columna_actual, // Debe ser un vector, no un arreglo
  output reg [2:0] fila_actual,   // Debe ser un vector, no un arreglo
  output wire button_pressed
);

  // Instancias de módulos
  ring_counter ring(
    .clk(clk), 
    .reset(reset), 
    .enable(enable), 
    .A(columnas[0]),
    .B(columnas[1]),
    .C(columnas[2]),
    .D(columnas[3])
  );
  
  deteccionBoton detectar_boton(
    .enable(enable), 
    .R1(filas[0]), 
    .R2(filas[1]), 
    .R3(filas[2]), 
    .R4(filas[3]), 
    .botonApretado(button_pressed)
  );

initial begin
  indice_boton = 5'b10000;
  columna_actual = 3'b111;
  fila_actual = 3'b111;
end


  // Lógica combinacional para detectar la columna actual
  always @(*) begin
    if (enable) begin
      case (columnas)
        4'b0001: columna_actual <= 3'b000; // Primera columna
        4'b0010: columna_actual <= 3'b001; // Segunda columna
        4'b0100: columna_actual <= 3'b010; // Tercera columna
        4'b1000: columna_actual <= 3'b011; // Cuarta columna
        4'b0000: columna_actual <= 3'b111; // Ninguna columna activa
        default: columna_actual <= 3'b111; // Error
      endcase
    end else begin
      columna_actual <= 3'b111; // Por defecto: ninguna columna activa
    end

    if (button_pressed) begin
      case (filas)
        4'b0001: fila_actual <= 3'b000; // Primera fila
        4'b0010: fila_actual <= 3'b001; // Segunda fila
        4'b0100: fila_actual <= 3'b010; // Tercera fila
        4'b1000: fila_actual <= 3'b011; // Cuarta fila
        4'b0000: fila_actual <= 3'b111; // Ninguna fila activa
        default: fila_actual <= 3'b111; // Por defecto
      endcase
    end else begin
      fila_actual <= 3'b111; // Ningún botón presionado
    end
  // Actualización del índice del botón presionado
    if (reset) begin
      indice_boton <= 6'b10000; // Valores por defecto en caso de reset
    end else begin
      indice_boton[3:2] <= columna_actual;
      indice_boton[1:0] <= fila_actual;
      indice_boton[4] <= 1'b0;
    end

    if (~button_pressed) begin
      indice_boton <= 5'b10000;
    end

  end

endmodule
