`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2021 07:58:34 PM
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX, //      
          input [31:0] REG_DATA1_EX,//
          input [31:0] REG_DATA2_EX,//
          input [31:0] PC_EX, //
          input [2:0] FUNCT3_EX, //
          input [6:0] FUNCT7_EX, //
          input [4:0] RD_EX, //--
          input [4:0] RS1_EX, //--
          input [4:0] RS2_EX, //--
          input RegWrite_EX, //--
          input MemtoReg_EX, //--
          input MemRead_EX,//--
          input MemWrite_EX, //--
          input [1:0] ALUop_EX, //
          input ALUSrc_EX, //
          input Branch_EX, 
          input [1:0] forwardA,forwardB, //
          
          input [31:0] ALU_DATA_WB,//
          input [31:0] ALU_OUT_MEM,//
          
          output ZERO_EX,//
          output [31:0] ALU_OUT_EX,//
          output [31:0] PC_Branch_EX, //
          output [31:0] REG_DATA2_EX_FINAL //
          );
          
    //control
    wire [3:0] ALUinput;
    ALUcontrol control(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);
    
    //ALU
    wire [31:0] outA, outB, outImd;
    mux3_1 muxA(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, outA);
    mux3_1 muxB(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardB, outB);
    assign REG_DATA2_EX_FINAL = outB; //regData2final asta este dupa primul mutiplexor 3_1
    
    mux2_1 muxImd(outB, IMM_EX, ALUSrc_EX, outImd);
    ALU unitateAritmetica(ALUinput, outA, outImd, ZERO_EX, ALU_OUT_EX);
    
    sumatorEX sumator(PC_EX, IMM_EX, PC_Branch_EX);
endmodule
