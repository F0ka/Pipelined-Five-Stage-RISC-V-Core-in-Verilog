 

module PIPELINE_UNIT(clk,reset,IF_ID_In,IF_ID_Out,ID_EX_In,ID_EX_Out,EX_MEM_In,EX_MEM_Out,MEM_WB_In,MEM_WB_Out);

input clk,reset;
input [63:0]IF_ID_In;    //32 to PC , 32 to Instraction
input [167:0]ID_EX_In;   //32 to PC ,, 32 to Instraction ,32 to read data 1,32 to read data 2, 32 to Imm Gen  + 8 Control
input [106:0]EX_MEM_In;	 //32 to ALU result ,32 to read data 2,32 to ImmGen_PC_Sum, 5 to Write Reg Address + 5 Control + 1 ALUZero
input [70:0]MEM_WB_In;   //32 to Read data,32 ALU reult ,5 to Write Reg Address + 2 Control
output reg [63:0]IF_ID_Out;	// 32,32
output reg [167:0]ID_EX_Out;	// 32,32,32,32,32,7
output reg [106:0]EX_MEM_Out;	// 32,32,32,5,5,1
output reg [70:0]MEM_WB_Out;	// 32,32,5,2

always @ (posedge clk)
begin
if(reset)
begin
IF_ID_Out <= 32'h0;
ID_EX_Out <= 32'h0;
EX_MEM_Out <= 32'h0;
MEM_WB_Out <= 32'h0;
end
IF_ID_Out <= IF_ID_In;
ID_EX_Out <= ID_EX_In;
EX_MEM_Out <= EX_MEM_In;
MEM_WB_Out <= MEM_WB_In;
end
endmodule
