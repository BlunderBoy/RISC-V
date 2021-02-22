`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2021 12:39:49 AM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    //global control
    input clk, reset,
    
    //control path
    input RegWrite_in, MemtoReg_in, MemRead_in, MemWrite_in, Branch_in,
    
    //mem
    input [31:0] read_data_in,
    
    //alu
    input [31:0] ALU_OUTPUT_in,
    
    //id
    input [4:0] rd_in,
   
    
    //output
   //control path
    output reg RegWrite_out, MemtoReg_out, MemRead_out, MemWrite_out, Branch_out,
    
    //mem
    output reg [31:0] read_data_out,
    
    //alu
    output reg [31:0] ALU_OUTPUT_out,
    
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
            read_data_out = 32'b0;
            ALU_OUTPUT_out = 32'b0;
            rd_out = 4'b0;
        end
        else
        begin
            RegWrite_out = RegWrite_in;
            MemtoReg_out = MemtoReg_in;
            MemRead_out = MemRead_in;
            MemWrite_out = MemWrite_in;
            Branch_out = Branch_in;
            read_data_out = read_data_in;
            ALU_OUTPUT_out = ALU_OUTPUT_in;
            rd_out = rd_in;
        end
    end
    
endmodule
