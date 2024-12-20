module topLevel(
input wire clk,           // Señal de reloj para todo el sistema
input wire reset,         // Señal de reset
input wire enable,
input wire [3:0] filas,
output wire [3:0] columnas
);

//Entradas y Salidas del teclado
wire [4:0] indice_boton;
wire key_press;    // Entrada de la tecla
wire [2:0] columna_actual; // Debe ser un vector, no un arreglo
wire [2:0] fila_actual;
teclado teclado_inst (
    .enable(enable),
    .clk(clk),
    .reset(reset),
    .filas(filas),
    .columnas(columnas),
    .indice_boton(indice_boton),
    .columna_actual(columna_actual), // Debe ser un vector, no un arreglo
    .fila_actual(fila_actual),   // Debe ser un vector, no un arreglo
    .button_pressed(key_press)
);

//Entradas y Salidas de Sincronizacion
wire key_detect;    // Señal de detección de flanco
sincronize sincronize_inst (
    .clk(clk), 
    .key_press(key_press), 
    .key_detect(key_detect),
    .rst(reset)
);

//Entradas y Salidas de traduccion
wire [3:0] keyPressed;              // 4-bit output representing the pressed key in binary
traduccion traduccion_inst(
    .input_teclado(indice_boton),  
    .key_detect(key_detect),           
    .traduccion(keyPressed)
);


//Entradas y Salidas de whichKey
wire num;         
wire op;               
wire c;                
wire equ;              
wire [1:0] operator;       
whichKey whichKey_inst (
    .key_pressed(keyPressed),          // Entrada: tecla traducida (salida de `traduccion_teclado`)
    .is_number(num),                    // Salida: 1 si es número (0–9), 0 si es operador
    .is_op(op),                         // Señal alta si es un operador (A, B, etc.)
    .is_c(is_c),                        // Señal alta si es 'C'
    .is_equ(equ),                       // Señal alta si es 'D' (<=)
    .operator(operator)                 // Identificador del operador (A<=2'b01, B<=2'b10, etc.)
);


//Entradas y salidas de cnt
wire cnt_out;       // Salida de estado
cnt cnt_inst (
    .clk(clk),          
    .rst_cnt(rst_cnt),      
    .num(num),          
    .cnt_out(cnt_out)       
);


// Entradas y salidas de FSM
wire [1:0] save_enable;     //Avisa que hay que guardar en un save: [00] = nada, [01] = save1, [10]= saveOp, [11] = save2
wire op_enable;             //Avisa que hay un operador
wire alu_enable;            //Habilita a la alu hacer la operacion
wire [1:0] disp_enable;     //Avisa en que pantalla estamos: [00] = 0000, [01] = save1, [10]= saveOp, [11] = save2
wire rst_cnt;               //resetea el contador
wire equ_enable;            //guarda el resultado
wire [3:0] curr_event;
wire [3:0] next_event;
FSM FSM_inst (
    .clk(clk), 
    .resetn(reset),
    .cnt_out(cnt_out),              
    .num(num),                      
    .OP(op),                        
    .C(c),                          
    .EQ(equ),                        
    .save_enable(save_enable),      
    .op_enable(op_enable),          
    .alu_enable(alu_enable),        
    .disp_enable(disp_enable),      
    .rst_cnt(rst_cnt),              
    .equ_enable(equ_enable),        
    .curr_event(curr_event)
    );


// Entradas y salidas de memory
wire [15:0] save1;
wire [15:0] save2;
wire [3:0] op_out;
memory memory_inst (
    .clk(clk),
    .rst(reset),
    .num(keyPressed),
    .res(res),
    .operator(operator),
    .clear_enable(clear_enable),
    .equ_enable(equ_enable),
    .save_enable(save_enable),
    .op_enable(op_enable),
    .save1(save1),
    .save2(save2),
    .op_out(op_out)
);


//Entradas y salidas de ALU
wire [15:0] res;             // Result in BCD
wire special_signal;          // Special signal for subtraction
ALU ALU_inst (
    .clk(clk),                 
    .clear(c),               
    .bcd1(save1),                
    .bcd2(save2),          
    .op_selected(op_out),       
    .bcd_out(res),       
    .special_signal(special_sign)       
);

//Entradas y salidas de display
wire [1:0] display_state;
wire [15:0] display_out;         // Salida de 4 bits
disp disp_inst(  
    .save1(save1),
    .save2(save2),    
    .Op(op_out),            
    .display_state(display_state),
    .display_out(display_out) 
);

endmodule
