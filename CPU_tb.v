module CPU_tb;

reg clk, rst;
wire [31:0] pc, npc, instr,
            load_from_mem, data1, data2, writeback,
            alu_opr1, alu_opr2, alu_out;
wire [15:0] imm;
wire [25:0] addr;
wire [5:0] opcode, funct;

datapath cpu(clk, rst,
                pc, npc, 
                instr, imm, addr, opcode, funct,
                load_from_mem, data1, data2, writeback,
                alu_opr1, alu_opr2, alu_out);

initial
begin
    clk = 0; rst = 0;
    forever
        #(100) clk = ~clk;
end

endmodule