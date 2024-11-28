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

wire [5:0] input_teclado,       // 4-bit input where [3:2] are columns and [1:0] are rows
wire key_detect,                // Para que se detecte una UNICA vez
wire [3:0] traduccion           // 4-bit output representing the pressed key in binary
traduccion traduccion_inst(
    input_teclado.(input_teclado),  
    key_detect.(key_detect),           
    traduccion.(traduccion)
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

//Entradas y Salidas de traduccion
wire [3:0] key_pressed;  
reg num;           
reg op;               
reg c;                
reg equ;              
reg [1:0] operator;       
whichKey whichKey_inst (
    key_pressed.(key_pressed),          // Entrada: tecla traducida (salida de `traduccion_teclado`)
    is_number.(is_number),              // Salida: 1 si es número (0–9), 0 si es operador
    is_op.(is_op),                      // Señal alta si es un operador (A, B, etc.)
    is_c.(is_c),                        // Señal alta si es 'C'
    is_equ.(is_equ),                    // Señal alta si es 'D' (<=)
    operator.(operator)                 // Identificador del operador (A<=2'b01, B<=2'b10, etc.)
);


// Entradas y salidas de FSM

FSM FSM_inst (
    clk.(clk), 
    resetn.(resetn),
    cnt_out.(cnt_out),              //Salida del contador: 1 mayor a 4, 0 menor o igual a 4
    num.(num),                      //Avisa que se apreto un numero (0-9)
    OP.(OP),                        //Avisa que se apreto un boton de operacion
    C.(C),                              //Avisa que se apreto CLEAR (C)
    EQ.(EQ),                            //Avisa que se apreto el igual (=)
    save_enable.(save_enable),          //Avisa que hay que guardar en un save: [00] = nada, [01] = save1, [10]= saveOp, [11] = save2
    op_enable.(op_enable),              //Avisa que hay un operador
    alu_enable.(alu_enable),            //Habilita a la alu hacer la operacion
    disp_enable.(disp_enable),          //Avisa en que pantalla estamos: [00] = 0000, [01] = save1, [10]= saveOp, [11] = save2
    rst_cnt.(rst_cnt),              //resetea el contador
    equ_enable.(equ_enable),     //guarda el resultado
    curr_event.(curr_event)
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




// Conectar las salidas finales
assign numero = numero_out;
assign operator = operator_out;

endmodule
