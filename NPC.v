`include "ctrl_encode_def.v"

module NPC(PC, NPCOp, 
            IMM16, IMM26, RS,
            NPC, PCPLUS4);  // next pc module
    
   input  [31:0] PC, RS;        // pc
   input  [1:0]  NPCOp;     // next pc operation
   input  [15:0] IMM16;       // immediate
   input  [25:0] IMM26;
   output reg [31:0] NPC;   // next pc
   
   output wire [31:0] PCPLUS4;
   
   assign PCPLUS4 = PC + 4; // pc + 4
   
   always @(*) begin
      case (NPCOp)
          `NPC_PLUS4:  NPC = PCPLUS4;
          `NPC_BRANCH: NPC = PCPLUS4 + {{14{IMM16[15]}}, IMM16[15:0], 2'b00}; // PC-relative
          `NPC_JUMP_PSEU:   NPC = {PCPLUS4[31:28], IMM26[25:0], 2'b00};  // pseudo jump
          `NPC_JUMP_TRUE:   NPC = RS;
          default:     NPC = PCPLUS4;
      endcase
   end // end always
   
endmodule
