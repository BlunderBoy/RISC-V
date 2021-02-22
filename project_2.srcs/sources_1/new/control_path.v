`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2021 05:33:20 PM
// Design Name: 
// Module Name: control_path
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


module control_path(input [6:0] opcode,
                    input control_sel,
                    output reg MemRead,MemtoReg,MemWrite,RegWrite,Branch,ALUSrc,
                    output reg [1:0] ALUop);
                    
        always @(opcode, control_sel)
        begin
            if(control_sel)
            begin
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0;
                RegWrite = 0;
                Branch = 0;
                ALUSrc = 0;
                ALUop = 2'b00;
            end
            if(!control_sel)
            begin
                //load
                if(opcode == 7'b0000011)
                begin
                    MemRead = 1;
                    MemtoReg = 1;
                    MemWrite = 0;
                    RegWrite = 1;
                    Branch = 0;
                    ALUSrc = 1;
                    ALUop = 2'b00;
                end
                //branch
                if(opcode == 7'b1100011)
                begin
                    ALUSrc = 0;
                    MemtoReg = 0; //trebuie sa fie x
                    RegWrite = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    Branch = 1;
                    ALUop = 2'b01;
                end
                //store
                if(opcode == 7'b0100011)
                begin
                    ALUSrc = 1;
                    MemtoReg = 0; //tre sa fie x
                    RegWrite = 0;
                    MemRead = 0;
                    MemWrite = 1;
                    Branch = 0;
                    ALUop = 2'b00;
                end
                //r format
                if(opcode == 7'b0110011)
                begin
                    ALUSrc = 0;
                    MemtoReg = 0;
                    RegWrite = 1;
                    MemRead = 0;
                    MemWrite = 0;
                    Branch = 0;
                    ALUop = 2'b10;
                end
                //imediate
                if(opcode == 7'b0010011)
                begin
                    ALUSrc = 1; //in ex se ia valoare imm
                    MemtoReg = 0;  
                    RegWrite = 1;
                    MemRead = 0;
                    MemWrite = 0;
                    Branch = 0;
                    ALUop = 2'b10;
                end
            end
        end
endmodule
