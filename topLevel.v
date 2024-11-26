module topLevel;

input wire clk,        // Señal de reloj para todo el sistema
input wire rst,        // Señal de reset

//Entradas y Salidas del teclado
wire enable,
wire [3:0] filas;
wire [3:0] columnas;
wire [5:0] indice_boton

// Instanciar módulo Teclado
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

// Instanciar módulo Validez
sincronize sincronize_inst (
    .num(num), 
    .key_press(key_press), 
    .key_detect(key_detect),
    .rst(rst)
);

// Instanciar módulo Traducción
traduccion traduccion_inst (
    .input_teclado(input_teclado),
    .traduccion(traduccion) 
);
// Instanciar módulo "Qué se apretó?"
que_se_apreto que_se_apreto_inst (
    .key_pressed(key_pressed), 
    .translated(translated), 
    .numero(numero_out), 
    .operator(operator_out)
);
// Conectar las salidas finales
assign numero = numero_out;
assign operator = operator_out;

endmodule
