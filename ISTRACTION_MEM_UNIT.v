module INSTRACTION_MEM_UNIT(reset,clk,write_address,write_data,read_address,instraction_out);

input reset,clk;
input [31:0]read_address;
input [31:0]write_address;
input [31:0]write_data;
output reg [31:0]instraction_out;


parameter MEMORY_SIZE = 64; //in words
reg [31:0] registers [MEMORY_SIZE-1:0];





integer i;

always @ (posedge reset)
begin

for(i = 0; i < MEMORY_SIZE;i = i + 1)
begin
registers[i] = 0;
end

end

always @ (posedge clk)
begin

registers[write_address] <= write_data;
instraction_out <= registers[read_address >> 2];

end



endmodule
