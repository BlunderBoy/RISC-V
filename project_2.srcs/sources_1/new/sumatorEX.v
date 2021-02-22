`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2021 09:21:43 PM
// Design Name: 
// Module Name: sumatorEX
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


module sumatorEX(
    input [31:0] ina, inb,
    output [31:0] out
    );
    
    assign out = ina + inb;
endmodule
