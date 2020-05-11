`include "ctrl_encode_def.v"

module DMem #(parameter SIZE = 4096)
    (clk, rst, 
        MemRead, MemWrite, LSLength, LoadSign,
        Addr, ReadData, WriteData);

input clk, rst, MemRead, MemWrite, LoadSign;
input [1:0] LSLength;
input [31:0] Addr, WriteData;
output reg [31:0] ReadData;

integer i, len, loadtemp;

reg [7:0] mem [0 : SIZE - 1];

//initial

always @(posedge rst)begin
    for (i = 0; i < SIZE; i = i + 1) 
        mem[i] <= 8'b0;
end

always @(posedge clk)begin
    case (LSLength)
        `BYTE: len = 1;
        `HALF: len = 2;
        `WORD: len = 4;
        default:;
    endcase
    
    //Read Memory / Write after Read, though not going to happen in DMem
    // Little Endian in mem
    if (MemRead)
    begin
            loadtemp = {mem[Addr + 3], mem[Addr + 2], mem[Addr + 1], mem[Addr]};
        // distiguish by srl/sra
        if (LoadSign)
            ReadData <= (loadtemp << ((4 - len) * 8)) >>> ((4 - len) * 8);
        else
            ReadData <= (loadtemp << ((4 - len) * 8)) >> ((4 - len) * 8);
    end
    else
        ReadData <= 32'bz;

    //Write Memory
    if (MemWrite)
        for (i = 0; i < len; i = i + 1) 
        // low bits in WriteData first
            mem[Addr + i] <= WriteData[(i * 8) + 7 -: 8];
    else;
end // endalways

endmodule