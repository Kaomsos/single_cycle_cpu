module IReg(Inst, 
            op, rs, rt, rd, shamt, func, // R-format
            imm,                         // I-format
            addr);                       // jump
            
input [31:0] Inst;
output reg [5:0] op, func;
output reg [4:0] rs, rt, rd;
output reg [31:0] shamt;
output reg [15:0] imm;
output reg [25:0] addr;

always @(*)
    begin
        op <= Inst[31:26];
        rs <= Inst[25:21];
        rt <= Inst[20:16];

        rd <= Inst[15:11];
        shamt <= {{27{1'b0}},Inst[10:6]};
        func <= Inst[5:0];
        
        imm <= Inst[15:0];
        addr <=  Inst[25:0];
    end

endmodule