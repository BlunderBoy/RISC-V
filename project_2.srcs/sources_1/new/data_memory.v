`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2021 08:12:51 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
                   
reg [31:0] memorie [0:1023];

//initilizam memoria cu 0
integer i;
initial begin
    for(i = 0; i < 1024; i = i + 1)
    begin
        memorie[i] = 32'b0;
    end
end
//scriere pe ceas (sincrona)

always @(posedge clk)
begin
    if(mem_write)
    begin
        //11:2 pentru ca avem doar 1024 de intrari in memorie si na 10 biti
        memorie[address[11:2]] = write_data;
    end
end

//citire asincrona (cand vrea ea)
always @(mem_read, address)
begin
    if(mem_read)
    begin
        read_data = memorie[address[11:2]];
    end
end
endmodule
