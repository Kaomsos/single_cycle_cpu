module IMem #(parameter DEPTH = 1024)
            (clk, rst,
            Addr, Inst);

input clk, rst;
input [31:0] Addr;
output reg [31:0] Inst;

integer i;
reg [31:0] mem [0 : DEPTH - 1];

initial
begin
    $readmemh("mipstestloopjal_sim.dat", mem);
    $display("(IM)Finish Read File",mem);
    for(i = 0; i < 256; i = i + 1)
        $write("%h ", mem[i]);
	$write("\n");
end
    

always @(posedge rst)
    for (i = 0; i < DEPTH; i = i + 1)
        mem[i] <= 32'b0;

always @(posedge clk)
    Inst <= mem[Addr >> 2];

endmodule