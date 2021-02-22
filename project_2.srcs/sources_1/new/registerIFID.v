`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2020 12:52:03 AM
// Design Name: 
// Module Name: registerIFID
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


module registerIFID(
    input clk, reset, write,
    input [31:0] pc, instruction,
    output reg [31:0] pcOut, instructionOut 
    );
    
    always @(posedge clk)
    begin
    if(reset)
    begin
        pcOut = 32'b0;
        instructionOut = 32'b0;
    end
    
    if(write)
    begin
        pcOut = pc;
        instructionOut = instruction;
    end
    end
endmodule
