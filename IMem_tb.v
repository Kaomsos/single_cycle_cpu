module IMem_tb;

 reg clk, rst;
 reg [31:0] Addr;
wire [31:0] Inst;

IMem imem(clk, rst, Addr, Inst);

initial begin
rst = 0; #1000 rst = 1;
end

initial
begin
   clk = 1; Addr = 32'b0;
    forever begin
        #(100) clk = ~clk; Addr = Addr + 4; 
    end
        
end

endmodule