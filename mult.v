module mul10 (
    input wire clk,
    input wire [3:0] in10,      // Entrada de 4 bits
    output reg [13:0] out10     // Salida de 14 bits
);
    reg [13:0] extended_in10;
    reg [13:0] in3, in2;

    always @(*) begin
        extended_in10 = {10'b0, in10}; // Extender a 14 bits
        in3 = extended_in10 << 3;     // Multiplicación por 8
        in2 = extended_in10 << 1;     // Multiplicación por 2
        out10 = in3 + in2;            // Suma para multiplicar por 10
    end
endmodule

module mul100 (
    input wire clk,             // Señal de reloj
    input wire [3:0] in100,     // Entrada de 4 bits
    output reg [13:0] out100    // Salida de 14 bits
);
    reg [13:0] extended_in100;  // Entrada extendida
    reg [13:0] in64, in32, in4;

    always @(*) begin
        extended_in100 = {10'b0, in100}; // Extender a 14 bits
        in64 = extended_in100 << 6;     // Multiplicación por 64
        in32 = extended_in100 << 5;     // Multiplicación por 32
        in4 = extended_in100 << 2;      // Multiplicación por 4
        out100 = in64 + in32 + in4;     // Suma total para multiplicar por 100
    end
endmodule

module mul1k (
    input wire clk,             // Señal de reloj
    input wire [3:0] in1k,      // Entrada de 4 bits
    output reg [13:0] out1k     // Salida de 14 bits
);
    reg [13:0] extended_in1k;   // Entrada extendida
    reg [13:0] in1024, in16, in8;

    always @(*) begin
        extended_in1k = {10'b0, in1k}; // Extender a 14 bits
        in1024 = extended_in1k << 10; // Multiplicación por 1024
        in16 = extended_in1k << 4;    // Multiplicación por 16
        in8 = extended_in1k << 3;     // Multiplicación por 8
        out1k = in1024 - in16 - in8;  // Suma total para multiplicar por 1000
    end
endmodule