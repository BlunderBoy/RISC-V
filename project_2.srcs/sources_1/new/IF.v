`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2020 01:19:49 AM
// Design Name: 
// Module Name: IF
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


module IF(
    input clk, reset,
    input PCsrc, PC_write,
    input [31:0]PC_Branch,
    output [31:0]PC_IF, INSTRUCTION_IF
    );
    
    wire [31:0] PCplus4, PCNext, PCOut;
    adder sumator(PCOut, 4, PCplus4); //pc += 4
    mux2_1 mux(PCplus4, PC_Branch, PCsrc, PCNext); //pc e pc+4 sau pc_branch
    
    PC ProgramCounter(clk, reset, PC_write, PCNext, PCOut);
    assign PC_IF = PCOut;
       
    instruction_memory memorie(PCOut[11:2], INSTRUCTION_IF);
endmodule
