// NPC control signal
`define NPC_PLUS4       2'b00
`define NPC_BRANCH      2'b01
`define NPC_JUMP_PSEU   2'b10
`define NPC_JUMP_TRUE   2'b11


// ALU control signal
`define ALU_NOP   4'b0000 
`define ALU_ADD   4'b0001
`define ALU_SUB   4'b0010 
`define ALU_AND   4'b0011
`define ALU_OR    4'b0100
`define ALU_SLT   4'b0101
`define ALU_SLTU  4'b0110
`define ALU_XOR   4'b0111
`define ALU_NOR   4'b1000
`define ALU_SLL   4'b1001
`define ALU_SLR   4'b1010
`define ALU_SRA   4'b1011


// RegDst control signal
`define DST_RD  2'b00
`define DST_RT  2'b01
`define DST_31  2'b10
// RegSrc control signal
`define SRC_REG_ALU     2'b00
`define SRC_REG_MEM     2'b01
`define SRC_REG_PCPLUS4 2'b10

// ALUSrc_B control signal
`define SRC_B_DATA2     1'b0
`define SRC_B_IMM       1'b1
// ALUSrc_A control signal
`define SRC_A_DATA1     1'b0
`define SRC_A_SHAMT     1'b1

// EXTOp control signal
`define EXT_SIGN    2'b00
`define EXT_ZERO    2'b01
`define EXT_LUI     2'b10

// DMem Length control signal
`define BYTE    2'b00
`define HALF    2'b01
`define WORD    2'b10
// Dmem Load control signal
`define SIGN    1'b1
`define UNSIGN  1'b0

//funct
`define ADD     6'h20
`define ADDU    6'h21
`define SUB     6'h22
`define SUBU    6'h23

`define AND     6'h24
`define OR      6'h25
`define XOR     6'h26
`define NOR     6'h27

`define SLT     6'h2a
`define SLTU    6'h2b

`define SLL     6'h0
`define SLR     6'h2
`define SRA     6'h3
`define SLLV    6'h4
`define SRLV    6'h6
`define SRAV    6'h7

`define JALR    6'h9
`define JR      6'h8

// opcode
`define SPECIAL  6'h0 // include jalr jr

`define ADDI    6'h8
`define ADDIU   6'h9

`define ANDI    6'hc
`define ORI     6'hd
`define XORI    6'he

`define LUI     6'hf
`define SLTI    6'ha
`define SLTIU   6'hb

`define LB      6'h20
`define LBU     6'h24
`define LH      6'h21
`define LHU     6'h25
`define LW      6'h23
`define SB      6'h28
`define SH      6'h29
`define SW      6'h2b


`define BEQ     6'h4
`define BNE     6'h5
`define BLEZ    6'h6
`define BGTZ    6'h7
// special encoding + r
`define SPECIAL_1 6'h1
    `define BLTZ    6'h0
    `define BGEZ    6'h1

`define J       6'h2
`define JAL     6'h3

