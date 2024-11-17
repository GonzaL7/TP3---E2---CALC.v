module FSM_Mealy_Calculadora (

    input wire clk, 
    input wire resetn,
    //Entradas
    input wire cnt_out, //Salida del contador: 1 mayor a 4, 0 menor o igual a 4
    input wire num,     //Avisa que se apreto un numero (0-9)
    input wire OP,      //Avisa que se apreto un boton de operacion
    input wire C,       //Avisa que se apreto CLEAR (C)
    input wire EQ,      //Avisa que se apreto el igual (=)
     
    //Salidas
    output reg [1:0] save_enable,   //Avisa que hay que guardar en un save: [00] = nada, [01] = save1, [10]= saveOp, [11] = save2
    output reg op_enable,           //Avisa que hay un operador
    output reg alu_enable,          //Avilita a la alu hacer la operacion
    output reg [1:0] disp_enable,   //Avisa en que pantalla estamos: [00] = 0000, [01] = save1, [10]= saveOp, [11] = save2
    output reg rst_cnt,             //resetea el contador
    output reg equ_enable,          //guarda el resultado

    output reg [3:0] curr_event);


    reg [3:0] next_event;

    // Asignacion de estados
    parameter [3:0] MemoryClear =       4'b0000;
    parameter [3:0] save_1 =            4'b0001;
    parameter [3:0] Esperando_1 =       4'b0010;
    parameter [3:0] Esperando_Op_1 =    4'b0011;
    parameter [3:0] save_Op =           4'b0100;
    parameter [3:0] save_2 =            4'b0101;
    parameter [3:0] Esperando_2 =       4'b0110;
    parameter [3:0] Esperando_EQ =      4'b0111;
    parameter [3:0] ALU =               4'b1000;
    parameter [3:0] RES =               4'b1001;
    parameter [3:0] Save_Res =          4'b1010;
    parameter [3:0] Error_Messg =       4'b1011;

    // Logica de proximo estado curr_y salida (combinacional)
    always @(cnt_out,num, OP, C, EQ, curr_event)
        case (curr_event)
            MemoryClear: if (num == 0)
                begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b00;
                    rst_cnt <= 0;          
                    equ_enable <= 0;       
                    
                    //Proximo Estado
                    next_event = MemoryClear;
                end
               else
                begin
                    save_enable <= 2'b01;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b01;
                    rst_cnt <= 0;          
                    equ_enable <= 0;       
                    
                    //Proximo Estado
                    next_event = save_1;
                end

            save_1:
                begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b01;
                    rst_cnt <= 0;          
                    equ_enable <= 0;       
                    
                    //Proximo Estado
                    next_event = Esperando_1;
                end

            Esperando_1: 
                begin
                    if (C ==1) begin
                        save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b00;
                        rst_cnt <= 1;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = MemoryClear;
                    end
                    else if (OP == 1) begin
                        save_enable <= 2'b00;
                        op_enable <= 1;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b10;
                        rst_cnt <= 1;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = SaveOp; 
                    end
                    else if (cnt_out == 1) begin
                        save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 0;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = Esperando_op1; 
                    end
                    else if (num==1 && cnt_out == 0) begin
                        save_enable <= 2'b01;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 0;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = Esperando_1; 
                    end
                end
            
            Esperando_Op_1:
                begin
                    if (C == 1) begin
                        save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 1;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = MemoryClear;  
                    end
                    else if (OP == 1) begin
                        save_enable <= 2'b00;
                        op_enable <= 1;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b10;
                        rst_cnt <= 1;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = save_Op;
                    end 
                    else if (num == 1) begin
                        save_enable <= 2'b01;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 0;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = Esperando_Op_1;                        
                    end
                end
            save_Op:
                begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b10;
                    rst_cnt <= 1;          
                    equ_enable <= 0;       
                
                    //Proximo Estado
                    next_event = Esperando_Op_1;
                end

            Esperando_2:
            begin
                if (C==1) begin
                        save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 1;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = MemoryClear;
                end
                else if (cnt_out == 1) begin
                    save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b11;
                        rst_cnt <= 0;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = Esperando_EQ;
                end
                else if (num == 1) begin
                        save_enable <= 2'b11;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b11;
                        rst_cnt <= 0;          
                        equ_enable <= 0;       
                    
                        //Proximo Estado
                        next_event = save_2;
                    end
                end

            save_2:
                begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b11;
                    rst_cnt <= 0;          
                    equ_enable <= 0;

                    //Proximo Estado
                    next_event = Esperando_2;
                end
            
            Esperando_EQ:
            begin
                if (EQ == 0) begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b11;
                    rst_cnt <= 0;          
                    equ_enable <= 0;

                    //Proximo Estado
                    next_event = Esperando_EQ;  
                end
                else if (C == 1) begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b11;
                    rst_cnt <= 1;          
                    equ_enable <= 0;

                    //Proximo Estado
                    next_event = MemoryClear;
                end
                else if (EQ == 1) begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 1;       
                    disp_enable <= 2'b01;
                    rst_cnt <= 0;          
                    equ_enable <= 0;

                    //Proximo Estado
                    next_event = ALU;
                    end
                end

            ALU:
                begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b01;
                    rst_cnt <= 0;          
                    equ_enable <= 0;

                    //Proximo Estado
                    next_event = RES;
                end
            
            RES:
                begin
                    if (C == 0 && EQ == 0) begin
                        save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 0;          
                        equ_enable <= 0;
    
                        //Proximo Estado
                        next_event = RES;
                    end
                    else if (C == 1) begin
                        save_enable <= 2'b00;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b00;
                        rst_cnt <= 1;          
                        equ_enable <= 0;
    
                        //Proximo Estado
                        next_event = MemoryClear;
                    end
                    else if (EQ == 1) begin
                        save_enable <= 2'b01;
                        op_enable <= 0;        
                        alu_enable <= 0;       
                        disp_enable <= 2'b01;
                        rst_cnt <= 0;          
                        equ_enable <= 1;
    
                        //Proximo Estado
                        next_event = Save_Res;
                    end
                end
            Save_Res:
                begin
                    save_enable <= 2'b00;
                    op_enable <= 0;        
                    alu_enable <= 0;       
                    disp_enable <= 2'b01;
                    rst_cnt <= 1;          
                    equ_enable <= 0;

                    //Proximo Estado
                    next_event = Esperando_2;
                end
        
            default: next_event = Error_Messg;
        
        endcase

    // Transicion de estado
    always @(negedge resetn, posedge clk)
        if (resetn == 0) curr_event <= MemoryClear;
        else curr_event <= next_event;

endmodule

