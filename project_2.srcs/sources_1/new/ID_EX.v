`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2021 12:11:21 AM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    //global control
    input clk, reset,
    
    //control path
    input RegWrite_in, MemtoReg_in, MemRead_in, MemWrite_in, ALUSrc_in, Branch_in,
    input [1:0] ALUop_in,
    
    //id
    input [31:0] PC_in, REG_DATA1_in, REG_DATA2_in, IMM_in,
    input [6:0] FUNCT7_in,
    input [2:0] FUNCT3_in,
    input [4:0] RS1_in, RS2_in, RD_in,
    
    //control path
    output reg RegWrite_out, MemtoReg_out, MemRead_out, MemWrite_out, ALUSrc_out, Branch_out,
    output reg [1:0] ALUop_out,
    
    //id
    output reg [31:0] PC_out, REG_DATA1_out, REG_DATA2_out, IMM_out,
    output reg [6:0] FUNCT7_out,
    output reg [2:0] FUNCT3_out,
    output reg [4:0] RS1_out, RS2_out, RD_out
    );
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            RegWrite_out = 1'b0;
            MemtoReg_out = 1'b0;
            MemRead_out = 1'b0;
            MemWrite_out = 1'b0;
            ALUSrc_out = 1'b0;
            Branch_out = 1'b0;
            ALUop_out = 2'b0;
            PC_out = 32'b0;
            REG_DATA1_out = 32'b0;
            REG_DATA2_out = 32'b0;
            IMM_out = 32'b0;
            FUNCT7_out = 7'b0;
            FUNCT3_out = 3'b0;
            RS1_out = 5'b0;
            RS2_out = 5'b0;
            RD_out = 5'b0;
        end
        else
        begin
            RegWrite_out = RegWrite_in;
            MemtoReg_out = MemtoReg_in;
            MemRead_out = MemRead_in;
            MemWrite_out = MemWrite_in;
            ALUSrc_out = ALUSrc_in;
            Branch_out = Branch_in;
            ALUop_out = ALUop_in;
            PC_out = PC_in;
            REG_DATA1_out = REG_DATA1_in;
            REG_DATA2_out = REG_DATA2_in;
            IMM_out = IMM_in;
            FUNCT7_out = FUNCT7_in;
            FUNCT3_out = FUNCT3_in;
            RS1_out = RS1_in;
            RS2_out = RS2_in;
            RD_out = RD_in;
        end
    end
endmodule
