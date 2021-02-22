`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2021 09:54:14 PM
// Design Name: 
// Module Name: forwarding
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


module forwarding(input [4:0] rs1,
                  input [4:0] rs2,
                  input [4:0] ex_mem_rd,
                  input [4:0] mem_wb_rd,
                  input ex_mem_regwrite,
                  input mem_wb_regwrite,
                  output reg [1:0] forwardA,forwardB);
                  
    always @(*)
    begin
        //forward A
        if(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1))
        begin
            forwardA = 2'b10;
        end
        else if ((mem_wb_regwrite && mem_wb_rd != 5'b0)
        && !(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1))
        && (mem_wb_rd == rs1))
        begin
            forwardA = 2'b01;
        end
        else
        begin
            forwardA = 2'b00;
        end
        
        //forward B
        if (ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2))
        begin
            forwardB <= 2'b10;
        end
        else if ((mem_wb_regwrite && (mem_wb_rd != 5'b0)) 
        && !(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2)) 
        && (mem_wb_rd == rs2))
        begin
            forwardB <= 2'b01;
        end
        else
        begin
            forwardB <= 2'b00;
        end
    end
endmodule
