module testbenchdisp;

    // Declaración de señales para las entradas
    reg [3:0] save_1;
    reg [3:0] save_2;
    reg [1:0] Op;
    reg [1:0] display_state;
    
    // Declaración de la salida
    wire [3:0] display_out;
    
    // Instanciación del módulo disp
    disp uut (
        .save_1(save_1),
        .save_2(save_2),
        .Op(Op),
        .display_state(display_state),
        .display_out(display_out)
    );
    
    // Bloque inicial para aplicar estímulos a las señales
    initial begin
        // Inicialización de las señales
        save_1 = 4'b0000;
        save_2 = 4'b1111;
        Op = 2'b00;
        display_state = 2'b00;
        
        // Imprimir los resultados
        $monitor("save_1 = %b, save_2 = %b, Op = %b, display_state = %b, display_out = %b", 
                 save_1, save_2, Op, display_state, display_out);
        
        // Probar diferentes valores para las señales
        #10 save_1 = 4'b0101; save_2 = 4'b1010; Op = 2'b01; display_state = 2'b00; // Espera 10 unidades de tiempo
        #10 display_state = 2'b01;
        #10 display_state = 2'b10;
        #10 display_state = 2'b11; // Estado por defecto
        #10 display_state = 2'b00;
        #10 Op = 2'b10;
        
        // Finalizar la simulación
        #10 $finish;
    end

endmodule
