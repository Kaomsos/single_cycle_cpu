`include "ctrl_encode_def.v"

module alu(A,                 // rs
           B,                 // rt
            ALUOp, C, Zero);
           
   input  signed [31:0] A, B;
   input         [3:0]  ALUOp;
   output signed [31:0] C;
   output Zero;
   
   reg [31:0] C;
   integer i;
       
   always @( * ) begin
      case ( ALUOp )
          `ALU_NOP:  C = A;                          // NOP
          
          `ALU_ADD:  C = A + B;                      // ADD/I/U
          `ALU_SUB:  C = A - B;                      // SUB/I/U
          `ALU_AND:  C = A & B;                      // AND/ANDI
          `ALU_OR:   C = A | B;                      // OR/ORI
          `ALU_XOR:  C = A ^ B;                       // XOR/I 
          `ALU_NOR:  C = ~(A | B);                    // NOR/I
         
          `ALU_SLT:  C = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI
          `ALU_SLTU: C = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0; // SLTU/SLTUI

          `ALU_SLL:  C = B << A;
          `ALU_SLR:  C = B >> A;
          `ALU_SRA:  C = B >>> A;
          default:   C = A;                          // Undefined
      endcase
   end // end always
   
   assign Zero = (C == 32'b0);

endmodule