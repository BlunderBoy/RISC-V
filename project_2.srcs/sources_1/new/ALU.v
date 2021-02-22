`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2021 06:39:41 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop,
           input [31:0] ina,inb,
           output zero,
           output reg [31:0] out);
           
           
           always @(ALUop, ina, inb)
           begin
           case(ALUop)
                4'b0000: out = ina & inb;
                4'b0001: out = ina | inb;
                4'b0010: out = ina + inb;
                4'b0011: out = ina ^ inb;
                4'b0100: out = ina << inb;
                4'b0101: out = ina >> inb; 
                4'b0110: out = ina - inb;
                
                4'b1001: out = ina >>> inb;
           endcase
           end
           
           assign zero = (out == 0) ? 1 : 0;
endmodule
