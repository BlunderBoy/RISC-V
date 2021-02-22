`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2021 12:52:42 AM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
             );
//IF
wire IF_ID_write;
wire PCwrite;
wire [31:0] PC_branch;
wire [31:0] PC_IF, INSTRUCTION_IF;

IF fetcher(clk, reset,
           PCSrc, PCwrite,
           PC_branch,
           PC_IF, INSTRUCTION_IF);
//ID
wire [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
wire [2:0] FUNCT3_ID;
wire [6:0] FUNCT7_ID, OPCODE_ID;
wire [4:0] RD_ID, RS1_ID, RS2_ID;
wire [31:0] PC_ID, INSTRUCTION_ID;
wire [4:0] RD_WB;
wire RegWrite_WB, MemtoReg_WB, MemRead_WB, MemWrite_WB, Branch_WB;
ID decoder(clk,
            PC_ID, INSTRUCTION_ID,
            RegWrite_WB,
            ALU_DATA_WB,
            RD_WB,
            IMM_ID,
            REG_DATA1_ID, REG_DATA2_ID,
            FUNCT3_ID,
            FUNCT7_ID,
            OPCODE_ID,
            RD_ID,
            RS1_ID,
            RS2_ID);
//EX
wire[1:0] ALUop_EX;
wire[31:0] REG_DATA1_EX, REG_DATA2_EX, IMM_EX;
wire[6:0] FUNCT7_EX;
wire[2:0] FUNCT3_EX;
wire[4:0] RS1_EX, RS2_EX, RD_EX;

wire ZERO_EX;
wire [31:0] PC_Branch_EX,  REG_DATA2_EX_FINAL;
wire [31:0] ALU_OUT_MEM, REG_DATA2_MEM;
wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX;
EX executant(IMM_EX,       
          REG_DATA1_EX,
          REG_DATA2_EX,
          PC_EX, 
          FUNCT3_EX, 
          FUNCT7_EX, 
          RD_EX, 
          RS1_EX, 
          RS2_EX, 
          RegWrite_EX, 
          MemtoReg_EX, 
          MemRead_EX,
          MemWrite_EX, 
          ALUop_EX, 
          ALUSrc_EX, 
          Branch_EX, 
          forwardA,forwardB, 
          ALU_DATA_WB,
          ALU_OUT_MEM,
          ZERO_EX,
          ALU_OUT_EX,
          PC_Branch_EX, 
          REG_DATA2_EX_FINAL 
          );
//MEM
wire RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM;
wire ZERO_MEM;
wire [4:0] RD_MEM;
wire [31:0] DATA_MEMORY_WB, ALU_OUT_WB;
   
data_memory memorie(clk,       
                   MemRead_MEM,
                   MemWrite_MEM,
                   ALU_OUT_MEM,
                   REG_DATA2_MEM,
                   DATA_MEMORY_MEM
                   );
//WB

///////////////registri
//IF-ID
registerIFID registruIF_ID(clk, reset, IF_ID_write,
                      PC_IF, INSTRUCTION_IF,
                      PC_ID, INSTRUCTION_ID);
                           
//ID-EX si control path ca aici apare prima oara
wire control_sel;
wire MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc;
wire [1:0] ALUop;
control_path control(OPCODE_ID,
                     control_sel,
                     MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc,
                     ALUop);

ID_EX registruID_EX(clk, reset,
                    RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch,
                    ALUop,
                    PC_ID, REG_DATA1_ID, REG_DATA2_ID, IMM_ID,
                    FUNCT7_ID,
                    FUNCT3_ID,
                    RS1_ID,
                    RS2_ID,
                    RD_ID,
                    RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX,
                    ALUop_EX,
                    PC_EX, REG_DATA1_EX, REG_DATA2_EX, IMM_EX,
                    FUNCT7_EX,
                    FUNCT3_EX,
                    RS1_EX,
                    RS2_EX,
                    RD_EX);
//EX-MEM
EX_MEM registruEX_MEM(clk, reset,
                     RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
                     ZERO_EX,
                     ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL,
                     RD_EX,
                     RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
                     ZERO_MEM,
                     ALU_OUT_MEM, PC_branch, REG_DATA2_MEM,
                     RD_MEM);
                     
//MEM-WB
MEM_WB registruMEM_WB(
    clk, reset,
    RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
    DATA_MEMORY_MEM,
    ALU_OUT_MEM,
    RD_MEM,
    
    RegWrite_WB, MemtoReg_WB, MemRead_WB, MemWrite_WB, Branch_WB,
    DATA_MEMORY_WB,
    ALU_OUT_WB,
    RD_WB
    );

//forward
forwarding forwarder(RS1_EX,
                  RS2_EX,
                  RD_MEM,
                  RD_WB,
                  RegWrite_MEM,
                  RegWrite_WB,
                  forwardA, forwardB);

//hazard
hazard_detection edenHazard(RD_EX,
                        RS1_ID,
                        RS2_ID,
                        MemRead_EX,
                        PCwrite,
                        IF_ID_write,
                        control_sel);
                        
assign pipeline_stall = control_sel;

//and gate
and_gate andFinal(Branch_MEM, ZERO_MEM, PCSrc);

//mux
mux2_1 mux(ALU_OUT_WB, DATA_MEMORY_WB, MemtoReg_WB, ALU_DATA_WB);

assign PC_MEM = PC_branch;

endmodule
