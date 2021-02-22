`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2021 12:22:25 AM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
    //global control
    input clk, reset,
    
    //control path
    input RegWrite_in, MemtoReg_in, MemRead_in, MemWrite_in, Branch_in,
    
    //alu
    input zero_in,
    input [31:0] ALU_OUT_in, PC_in, REG_DATA2_in,
    
    //id
    input [4:0] rd_in,
    
    //output 
    
    //control path
    output reg RegWrite_out, MemtoReg_out, MemRead_out, MemWrite_out, Branch_out,
    
    //alu
    output reg zero_out,
    output reg [31:0] ALU_OUT_out, PC_out, REG_DATA2_out,
    
    //id
    output reg [4:0] rd_out
    
    );
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            RegWrite_out = 1'b0;
            MemtoReg_out = 1'b0;
            MemRead_out = 1'b0;
            MemWrite_out = 1'b0;
            Branch_out = 1'b0;
            zero_out = 1'b0;
            ALU_OUT_out = 32'b0;
            PC_out = 32'b0;
            REG_DATA2_out = 32'b0;
            rd_out = 4'b0;
        end
        else
        begin
            RegWrite_out = RegWrite_in;
            MemtoReg_out = MemtoReg_in;
            MemRead_out = MemRead_in;
            MemWrite_out = MemWrite_in;
            Branch_out = Branch_in;
            zero_out = zero_in;
            ALU_OUT_out = ALU_OUT_in;
            PC_out = PC_in;
            REG_DATA2_out = REG_DATA2_in;
            rd_out = rd_in;
        end
    end
endmodule
