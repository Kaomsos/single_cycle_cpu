`include "ctrl_encode_def.v"

module CtrlUnit (op, funct, 
                 Zero, RS, RT,
                 RegDst, ALUSrc_A, ALUSrc_B, ALUOp,
                 MemWrite, MemRead, 
                 LSLength, LoadSign,
                 RegSrc, RegWrite,
                 NPCOp, EXTOp);

input [5:0] op, funct;
input Zero;
input [4:0] RT;
input [31:0] RS;
output reg ALUSrc_A, ALUSrc_B, MemWrite, MemRead, LoadSign, RegWrite;
output reg [1:0] RegDst, RegSrc, NPCOp, EXTOp, LSLength;
output reg [3:0] ALUOp;

always @(*)
    begin
        case (op)
            // R-type and jalr jr
            `SPECIAL:begin  // mostly R-type
                begin
                    RegDst <= `DST_RD; 
                    ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_DATA2;
                    // ALUOp;
                    MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                    //LSLength; LoadSign;
                    RegSrc <= `SRC_REG_ALU; 
                    NPCOp <= `NPC_PLUS4; //EXTOp 
                end
                
                case (funct)
                    `ADD: ALUOp <= `ALU_ADD;
                    `ADDU: ALUOp <= `ALU_ADD;
                    `SUB: ALUOp <= `ALU_SUB;
                    `SUBU: ALUOp <= `ALU_SUB;
                    `AND: ALUOp <= `ALU_AND;
                    `OR: ALUOp <= `ALU_OR;
                    `XOR: ALUOp <= `ALU_XOR;
                    `NOR: ALUOp <= `ALU_NOR;
                    `SLT: ALUOp <= `ALU_SLT;   
                    `SLTU: ALUOp <= `ALU_SLTU;
                    // shift
                    `SLL: begin
                        ALUSrc_A <= `SRC_A_SHAMT;
                        ALUOp <= `ALU_SLL; 
                    end
                    `SLR: begin
                        ALUSrc_A <= `SRC_A_SHAMT;
                        ALUOp <= `ALU_SLR; 
                    end
                    `SRA: begin
                        ALUSrc_A <= `SRC_A_SHAMT;
                        ALUOp <= `ALU_SRA;
                    end      
                    `SLLV: ALUOp <= `ALU_SLL;     
                    `SRLV: ALUOp <= `ALU_SLR;     
                    `SRAV: ALUOp <= `ALU_SRA; 
                    // jump with reg
                    `JALR: begin
                        RegSrc <= `SRC_REG_PCPLUS4;
                        NPCOp <= `NPC_JUMP_TRUE;
                    end
                    `JR: begin
                        RegWrite <= 0;
                        NPCOp <= `NPC_JUMP_TRUE;
                    end
                    default: ALUOp <= `ALU_NOP;
                endcase
            end
            
            // I-type
            `ADDI: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_SIGN;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end
            `ADDIU: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_ZERO;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end
            `ANDI: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_ZERO;
                ALUOp <= `ALU_AND;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end
            `ORI: begin
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_ZERO;
                ALUOp <= `ALU_OR;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end
            `XORI: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_ZERO;
                ALUOp <= `ALU_XOR;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end
            `LUI: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_LUI;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end
            `SLTI: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_SIGN;
                ALUOp <= `ALU_SLT;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4;
            end
            `SLTIU: begin 
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                EXTOp <= `EXT_ZERO;
                ALUOp <= `ALU_SLTU;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                RegSrc <= `SRC_REG_ALU; 
                NPCOp <= `NPC_PLUS4; 
            end

            // load
            `LW: begin
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 1; RegWrite <= 1;
                LSLength <= `WORD;
                RegSrc <= `SRC_REG_MEM; 
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end
            `LH: begin
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 1; RegWrite <= 1;
                LSLength <= `HALF; LoadSign <= 1;
                RegSrc <= `SRC_REG_MEM; 
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end
            `LHU: begin
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 1; RegWrite <= 1;
                LSLength <= `HALF; LoadSign <= 0;
                RegSrc <= `SRC_REG_MEM; 
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end
            `LB: begin
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 1; RegWrite <= 1;
                LSLength <= `BYTE; LoadSign <= 1;
                RegSrc <= `SRC_REG_MEM; 
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end
            `LBU: begin
                RegDst <= `DST_RT; 
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 0; MemRead <= 1; RegWrite <= 1;
                LSLength <= `BYTE; LoadSign <= 0;
                RegSrc <= `SRC_REG_MEM; 
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end

            // save
            `SW:begin
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 1; MemRead <= 0; RegWrite <= 0;
                LSLength <= `WORD;
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end
            `SH: begin
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 1; MemRead <= 0; RegWrite <= 0;
                LSLength <= `HALF;
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end
            `SB: begin
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_IMM;
                ALUOp <= `ALU_ADD;
                MemWrite <= 1; MemRead <= 0; RegWrite <= 0;
                LSLength <= `BYTE;
                NPCOp <= `NPC_PLUS4; EXTOp <= `EXT_SIGN;
            end

            // branch
            `BEQ:begin
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_DATA2;
                ALUOp <= `ALU_SUB;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 0;
                EXTOp <= `EXT_SIGN;
                if (Zero)
                    NPCOp <= `NPC_PLUS4;  
                else
                    NPCOp <= `NPC_BRANCH;
            end
            `BNE:begin
                ALUSrc_A <= `SRC_A_DATA1; ALUSrc_B <= `SRC_B_DATA2;
                ALUOp <= `ALU_SUB;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 0;
                EXTOp <= `EXT_SIGN;
                if (Zero)
                    NPCOp <= `NPC_BRANCH;
                else
                    NPCOp <= `NPC_PLUS4; 
            end
            `BGTZ:begin
                MemWrite <= 0; MemRead <= 0; RegWrite <= 0;
                EXTOp <= `EXT_SIGN;
                if (RS > 0)
                    NPCOp <= `NPC_BRANCH;
                else
                    NPCOp <= `NPC_PLUS4; 
            end
            `BLEZ:begin
                MemWrite <= 0; MemRead <= 0; RegWrite <= 0;
                EXTOp <= `EXT_SIGN;
                if (RS <= 0)
                    NPCOp <= `NPC_BRANCH;
                else
                    NPCOp <= `NPC_PLUS4; 
            end
            // BLTZ and BGEZ
            `SPECIAL_1:begin
                MemWrite <= 0; MemRead <= 0; RegWrite <= 0;
                EXTOp <= `EXT_SIGN;
                case (RT)
                    `BLTZ:
                        if (RS < 0)
                            NPCOp <= `NPC_BRANCH;
                        else
                            NPCOp <= `NPC_PLUS4; 
                    `BGEZ:
                        if (RS >= 0)
                            NPCOp <= `NPC_BRANCH;
                        else
                            NPCOp <= `NPC_PLUS4; 
                    default:;
                endcase
            end

            // jump
            `J: begin
                MemWrite <= 0; MemRead <= 0; RegWrite <= 0;
                NPCOp <= `NPC_JUMP_PSEU;
            end
            `JAL: begin
                RegDst <= `DST_31;
                MemWrite <= 0; MemRead <= 0; RegWrite <= 1;
                NPCOp <= `NPC_JUMP_PSEU;
                RegSrc <= `SRC_REG_PCPLUS4;
            end
            default:;
        endcase
    end

endmodule