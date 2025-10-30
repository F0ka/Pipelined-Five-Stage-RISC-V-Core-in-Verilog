
module	DATA_MEM_UNIT(clk,reset,MemWrite,MemRead,Address,Write_data,Read_Data);

input clk,reset,MemWrite,MemRead;
input [31:0] Address,Write_data;

output [31:0] Read_Data;

reg [31:0] DMem [63:0];
integer k;

assign Read_Data= {MemRead} ? DMem[Address] : 32'h0;

always @ (posedge clk)
begin
if(reset == 1'b1)
begin
for(k = 0; k < 64; k = k + 1)
begin
DMem[k] = 32'h0;
end
end
else if(MemWrite) DMem[Address] = Write_data;
end


endmodule