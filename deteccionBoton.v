module deteccionBoton(
  input wire enable,
  input wire R1, 
  input wire R2, 
  input wire R3,
  input wire R4,
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