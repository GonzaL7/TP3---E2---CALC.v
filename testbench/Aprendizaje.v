
//COMBINATIONAL LOGIC//
//####################################//

// Gate Level
module multiplexGateLevel (
    A,B,X,out1
);
    
  input A,B,X;
  output out1;
  
  wire not_x;
  wire out_and1, out_and2;

  not not1(not_x, X);
  and and_1(out_and1, not_x, B);
  and and_2(out_and2, A, B);

  or or_1(out1,and_1, and_2);

endmodule

// Data Flow Level

module multiplexerDataLeve (
    A,B,X,out1
);
    
  input A,B,X;
  output out1;

  assign out1 = ((~X&A)&A|(B&X))

    //~NOT
    //& And
    //| OR
endmodule

// Behavioural LEvel


module multiplexerBehavioutalLevel (
    A,B,X,out1
);
    
  input A,B,X;
  output out1;

// Descripcion general de comportamiento
  always @(*) begin
    if(X==0) begin
        out1 = A;
    else
        out1 = B;
    end
  end

    //~NOT
    //& And
    //| OR
endmodule

//SEQUENTIAL LOGIC//

module sequentialExample (
    A,B,out
);

input A,B;
output out;

always @(posedge clk ) begin
    // NON-BLOCKING ASSIGNMENT. 
    // Delay de asignamiento hasta que todas las asignaciones a 
    // B se hayan realizaso en el time step.
    A <= B;

    // Basicamente, cuando quiera usar asignaciones secuenciales
    // Tengo que usar asignaciones "Non-Blocking".

    // ideal para la creación de Shift Registers.
end
    
endmodule