module Regs(clk, RegWrite, rst,
            ReadAddr_1, ReadData_1,
            ReadAddr_2, ReadData_2,
            WriteAddr, WriteData);
//是否要有时钟、复位            
input clk, RegWrite, rst;
//integer i;
input [4:0] ReadAddr_1, ReadAddr_2, WriteAddr;
input [31:0] WriteData;
output reg [31:0] ReadData_1, ReadData_2;

reg [31:0] register[1:31];           

integer i;

always @(posedge rst) begin
    for(i = 1; i < 32; i = i + 1)
        register[i] <= 32'b0;
end
    
always @(posedge clk)//条件判断语句必须放在always里面
begin
    //非阻塞赋值
    ReadData_1 <= (ReadAddr_1 == 0) ? 0 : register[ReadAddr_1]; 
    ReadData_2 <= (ReadAddr_2 == 0) ? 0 : register[ReadAddr_2];
    if(WriteAddr != 0 && RegWrite) begin              
    //忽略写0号寄存器的要求
        register[WriteAddr] <= WriteData;
        $display("r[%2d] = 0x%8X,", WriteAddr, WriteData);
    end
    else ;
end

endmodule
