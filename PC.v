module PC( clk, rst, 
            NPC, PC );

  input              clk;
  input              rst;
  input       [31:0] NPC;
  output reg  [31:0] PC;

initial
  PC <= 32'b0;

always @(posedge rst)
    PC <= 32'h0000_0000;

always @(posedge clk)
      PC <= NPC;
      
endmodule

