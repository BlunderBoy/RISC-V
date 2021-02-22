`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2021 02:35:52 AM
// Design Name: 
// Module Name: and_gate
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


module and_gate(
    input a, b,
    output reg c
    );
    
    always @(*)
    begin
        case({a,b})
            2'b00: c = 0;
            2'b01: c = 0;
            2'b10: c = 0;
            2'b11: c = 1;
        endcase
    end
endmodule
