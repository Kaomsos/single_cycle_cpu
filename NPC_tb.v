`include "ctrl_encode_def.v"

module NPC_test;
    input [31: 0] PC;
   input reg  [31:0] REG;        // pc
   input reg [1:0]  NPCOp;     // next pc operation
   input reg [25:0] IMM;       // immediate
   output [31:0] NPC;   // next pc
   output [31:0] PCPLUS4;

    reg [31:0] PCreg;

assign PC = PCreg;
assign NPC = 

initial
    PC = 0;



initial
begin
    NPCOp = `PCPLUS4;
    # 10 
end