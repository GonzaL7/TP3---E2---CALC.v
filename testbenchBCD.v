`timescale 1ns / 1ps

module testbenchBCD;

    reg [15:0] a;
    reg [15:0] b;
    reg op;
    wire [15:0] result;
    wire carry;
    wire valid;

    alu_BCD uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .carry(carry),
        .valid(valid)
    );

    initial begin
        // Suma de 1234 + 4321
        a = 16'h1234; // 1234 en BCD
        b = 16'h4321; // 4321 en BCD
        op = 0;       // Suma
        #10;

        // Resta de 4321 - 1234
        a = 16'h4321; // 4321 en BCD
        b = 16'h1234; // 1234 en BCD
        op = 1;       // Resta
        #10;

        // Suma que genera un acarreo
        a = 16'h9999; // 9999 en BCD
        b = 16'h0001; // 0001 en BCD
        op = 0;       // Suma
        #10;

        // Resta negativa (inválida)
        a = 16'h1234; // 1234 en BCD
        b = 16'h4321; // 4321 en BCD
        op = 1;       // Resta
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | a=%h | b=%h | op=%b | result=%h | carry=%b | valid=%b",
                 $time, a, b, op, result, carry, valid);
    end
endmodule
