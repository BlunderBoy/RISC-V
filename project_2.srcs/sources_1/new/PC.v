`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2020 09:05:54 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk, res, write,
    input [31:0] in,
    output reg [31:0] out
    );

    always @(posedge clk)
    begin
        if(write)
            out = in;
    end
    
    always @(res)
    begin
        if (res)
            out = 0;
    end
endmodule
