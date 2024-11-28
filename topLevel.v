module topLevel;

wire clk,           // Señal de reloj para todo el sistema
wire reset,         // Señal de reset


// Entradas y salidas de ring_counter
wire A;
wire B;
wire C;
wire D;
wire enableRING;
ring_counter ring_counter_inst(
    .clk(clk),
    .reset.(reset),
    .enable(enableRING),
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
wire [5:0] input_teclado,       // 4-bit input where [3:2] are columns and [1:0] are rows
wire key_detect,                // Para que se detecte una UNICA vez
wire [3:0] keyPressed           // 4-bit output representing the pressed key in binary
traduccion traduccion_inst(
    input_teclado.(input_teclado),  
    key_detect.(key_detect),           
    traduccion.(keyPressed)
);


//Entradas y Salidas de whichKey
reg num;           
reg op;               
reg c;                
reg equ;              
reg [1:0] operator;       
whichKey whichKey_inst (
    key_pressed.(key_pressed),          // Entrada: tecla traducida (salida de `traduccion_teclado`)
    is_number.(num),              // Salida: 1 si es número (0–9), 0 si es operador
    is_op.(op),                      // Señal alta si es un operador (A, B, etc.)
    is_c.(is_c),                        // Señal alta si es 'C'
    is_equ.(equ),                    // Señal alta si es 'D' (<=)
    operator.(operator)                 // Identificador del operador (A<=2'b01, B<=2'b10, etc.)
);


//Entradas y salidas de cnt
input wire rst_cnt,      // Señal de reinicio
output reg cnt_out       // Salida de estado
wire cnt_out;               //Salida del contador: 1 mayor a 4, 0 menor o igual a 4
cnt cnt_inst (
    clk.(clk),          
    rst_cnt.(rst_cnt),      
    num.(num),          
    cnt_out.(cnt_out)       
);


// Entradas y salidas de FSM
wire rstFSM;
wire [1:0] save_enable;     //Avisa que hay que guardar en un save: [00] = nada, [01] = save1, [10]= saveOp, [11] = save2
wire op_enable;             //Avisa que hay un operador
wire alu_enable;            //Habilita a la alu hacer la operacion
wire [1:0] disp_enable;     //Avisa en que pantalla estamos: [00] = 0000, [01] = save1, [10]= saveOp, [11] = save2
wire rst_cnt;               //resetea el contador
wire equ_enable;            //guarda el resultado
wire curr_event;
wire next_event;
FSM FSM_inst (
    clk.(clk), 
    resetn.(rstFSM),
    cnt_out.(cnt_out),              
    num.(num),                      
    OP.(op),                        
    C.(c),                          
    EQ.(equ),                        
    save_enable.(save_enable),      
    op_enable.(op_enable),          
    alu_enable.(alu_enable),        
    disp_enable.(disp_enable),      
    rst_cnt.(rst_cnt),              
    equ_enable.(equ_enable),        
    curr_event.(curr_event)
    );


// Entradas y salidas de memory
reg [15:0] save1;
reg [15:0] save2;
reg [3:0] op_out;
module memory (
    clk.(clk),
    num.(num),
    res.(res),
    operator.(operator),
    clear_enable.(clear_enable),
    equ_enable.(equ_enable),
    save_enable.(save_enable),
    op_enable.(op_enable),
    save1.(save1),
    save2.(save2),
    op_out.(op_out)
);


//Entradas y salidas de ALU
wire alu_enable,            // ALU enable signal
reg [15:0] res,             // Result in BCD
reg special_signal          // Special signal for subtraction
ALU ALU_inst (
    clk.(clk),                 
    clear.(c),               
    bcd1.(save_1),                
    bcd2.(save_2),          
    op_selected.(op_out),   
    alu_enable.(alu_enable),    
    bcd_out.(res),       
    special_signal.(special_sign)       
);


//Entradas y salidas de display
wire [3:0] save_1;        // Entrada de 4 bits (save_1)
wire [3:0] save_2;        // Otra entrada de 4 bits (save_2)
wire [1:0] Op;            // Selector de operación 2 bits (Operation)
wire [1:0] display_state;
wire [3:0] display_out;         // Salida de 4 bits
disp disp_inst(
    .save_1(save_1),        
    .save_2(save_2),        
    .Op(Op),            
    .display_state(display_state),
    .display_out(display_out) 
);

endmodule
