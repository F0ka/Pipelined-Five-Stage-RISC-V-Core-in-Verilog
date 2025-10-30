module PC_UNIT(clk ,reset,IsBranch,IsZero,imm_PC_SUM, PC_out);

input clk,reset,IsBranch,IsZero;
input [31:0] imm_PC_SUM; 
output reg [31:0] PC_out;

always @ (posedge clk)

begin
if(reset)PC_out <= 32'h00000000;
else if (IsBranch == 1'b1 && IsZero == 1'b1)
begin
PC_out <= imm_PC_SUM;
end
else PC_out <= PC_out + 4;
end

endmodule
	 
