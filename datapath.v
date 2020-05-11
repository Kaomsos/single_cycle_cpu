module datapath(
    clk, rst,
    _pc, npc, 
    instr, imm, addr, opcode, funct,
    loaddata, data1, data2, writeback,
    alu_opr1, alu_opr2, alu_out
);

input clk, rst;
output [31:0] _pc, npc, instr,
            loaddata, data1, data2, alu_opr1, alu_opr2, alu_out, writeback;
output [15:0] imm;
output [25:0] addr;
output [5:0] opcode, funct;

wire ALUSrc_A, ALUSrc_B, MemWrite, MemRead, LoadSign, RegWrite, Zero;
wire [1:0] RegDst, RegSrc, NPCOp, EXTOp, LSLength;
wire [3:0] ALUOp;
wire [31:0] NPC, PC, PCPLUS4, Inst, WriteBack,
                ReadData, ReadData_1, ReadData_2, A, B, C, imm32;
wire [5:0] op, func;
wire [4:0] rs, rt, rd, WriteAddr;
wire [31:0] shamt;
wire [15:0] imm16;
wire [25:0] imm26;

assign _pc = PC;
assign npc = NPC;
assign instr = Inst;
assign imm = imm16;
assign addr = imm26;
assign opcode = op;
assign funct = func;
assign loaddata = ReadData;
assign writeback = WriteBack;
assign data1 = ReadData_1;
assign data2 = ReadData_2;
assign alu_opr1 = A;
assign alu_opr2 = B;
assign alu_out = C;


CtrlUnit ctrl (op, func, 
                 Zero, ReadData_1, rt,
                 RegDst, ALUSrc_A, ALUSrc_B, ALUOp,
                 MemWrite, MemRead, 
                 LSLength, LoadSign,
                 RegSrc, RegWrite,
                 NPCOp, EXTOp);

PC pc (clk, rst, NPC, PC);
NPC newpc(PC, NPCOp, imm16, imm26, ReadData_1, NPC, PCPLUS4);

IMem imem (clk, rst, PC, Inst);
IReg ireg (Inst, op, rs, rt, rd, shamt, func, imm16, imm26);
mux4 #(5) regdst(rd, rt, 5'b11111, 5'bz, RegDst, WriteAddr);
Regs regs (clk, RegWrite, rst,
            rs, ReadData_1,
            rt, ReadData_2,
            WriteAddr, WriteBack);
EXT ext (imm16, EXTOp, imm32);
mux2 #(32) a_src (ReadData_1 ,shamt, ALUSrc_A, A);
mux2 #(32) b_src (ReadData_2 ,imm32, ALUSrc_B, B);
alu the_alu (A, B, ALUOp, C, Zero);
DMem dmem (clk, rst, 
        MemRead, MemWrite, LSLength, LoadSign,
        C, ReadData, ReadData_2);
mux4 #(32) regsrc (C, ReadData, PCPLUS4, 32'bz, RegSrc, WriteBack);


endmodule