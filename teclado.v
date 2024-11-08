module teclado(
  input wire Fila1, 
  input wire Fila2, 
  input wire FIla3,
  input wire Fila4,

  
  
  output wire Columna1,
  output wire Columna2,
  output wire Columna3,
  output wire Columna4,

  output reg botonApretado);
 
 //Necesito que sea independiente de Clk.
 // @(*) hace que sea un bloque combinacional
always @(*) begin
  if (enable) begin
    if (R1 || R2 || R3 || R4) begin
      botonApretado = 1;
    end 
    else begin
      botonApretado = 0;
    end
  end
end
 
endmodule