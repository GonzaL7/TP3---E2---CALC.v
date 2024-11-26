module topLevel;

wire clk,           // Señal de reloj para todo el sistema
wire reset,         // Señal de reset
wire enable;


// Entradas y salidas de ring_counter
wire A;
wire B;
wire C;
wire D;
ring_counter ring_counter_inst(
    .clk(clk),
    .reset.(reset),
    .enable(enable),
    .A(A),
    .B(B),
    .C(C),
    .D(D)
);

//Entradas y Salidas del teclado
wire enable,
wire [3:0] filas;
wire [3:0] columnas;
wire [5:0] indice_boton;
teclado teclado_inst (
    .enable(enable),
    .clk(clk),
    .reset(reset),
    .filas(filas),
    .columnas(columnas),
    .indice_boton(indice_boton)
);


//Entradas y Salidas de Sincronizacion
wire key_press;    // Entrada de la tecla
wire rst;
wire num;
wire key_detect;    // Señal de detección de flanco

sincronize sincronize_inst (
    .num(num), 
    .key_press(key_press), 
    .key_detect(key_detect),
    .rst(rst)
);


//Entradas y Salidas de traduccion
wire input_teclado;
wire traduccion;
traduccion traduccion_inst (
    .input_teclado(input_teclado),
    .traduccion(traduccion) 
);


//Entradas y salidas de display
wire [3:0] save_1;        // Entrada de 4 bits (save_1)
wire [3:0] save_2;        // Otra entrada de 4 bits (save_2)
wire [1:0] Op;            // Selector de operación 2 bits (Operation)
wire [1:0] display_state;
wire [3:0] display_out; // Salida de 4 bits
disp disp_inst(
    .save_1(save_1),        
    .save_2(save_2),        
    .Op(Op),            
    .display_state(display_state),
    .display_out(display_out) 
);

//Entradas y salidas de contador
wire rst_cnt;      // Señal de reinicio
wire num;          // Señal para habilit
wire cnt_out;       // Salida de estado
cnt cnt_inst(
    .clk(clk),    
    .rst_cnt(rst_cnt),
    .num(num),    
    .cnt_out(cnt_out) 
);

//Entradas y salidas de BCD2binary
wire [15:0] bcd;      // 4 dígitos en BCD (16 bits)
wire [13:0] bin;  // Salida en binario (máximo 9999 en decimal = 14 bits)
BCD2binary BCD2binary_inst (
    .bcd(bcd), 
    .bin(bin)  
);


//Entradas y salidas de binary2BCD
wire [13:0] binar;
wire [15:0] bcdd;
binary2BCD binary2BCD_inst(
    .binary(binary),
    .bcdd(bcdd)
);


// Conectar las salidas finales
assign numero = numero_out;
assign operator = operator_out;

endmodule
