`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2021 02:50:17 AM
// Design Name: 
// Module Name: risc_V_final_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module risc_V_final_TB(

    );
    reg clock, reset;
    wire [31:0] PC_EX;
    wire [31:0] ALU_OUT_EX;
    wire [31:0] PC_MEM;
    wire PCSrc;
    wire [31:0] DATA_MEMORY_MEM;
    wire [31:0] ALU_DATA_WB;
    wire [1:0] forwardA, forwardB;
    wire pipeline_stall;
    
    RISC_V procesor(clock,
              reset,
              PC_EX,
              ALU_OUT_EX,
              PC_MEM,
              PCSrc,
              DATA_MEMORY_MEM,
              ALU_DATA_WB,
              forwardA, forwardB,
              pipeline_stall
             );
    
    always #5 clock=~clock;
    
    initial 
    begin
        #0 clock = 1'b0;
        reset = 1'b1;
        
        #20
        reset = 1'b0;
        
        #18
        $finish;
    end
    
endmodule