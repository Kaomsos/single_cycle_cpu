`include "ctrl_encode_def.v"

module EXT(Imm16, EXTOp, Imm32);
    
   input  [15:0] Imm16; // input 16 bits
   input  [1:0]  EXTOp;	// ctrl signal
   output [31:0] Imm32; // output 32 bits
   
   assign Imm32 = (EXTOp == `EXT_SIGN)? {{16{Imm16[15]}}, Imm16}:
                  (EXTOp == `EXT_ZERO)? {16'd0, Imm16}:
                  (EXTOp == `EXT_LUI)? {Imm16, 16'b0}:
                  32'bz;
       
endmodule
