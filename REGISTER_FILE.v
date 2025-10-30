
module REGISTER_FILE(clk,reset,Main_bus,Write_reg_address,write_d_rd,write_d_Alu,RegWrite,read_d1,read_d2,MemToReg_in);

input clk,reset,RegWrite,MemToReg_in;
input [31:0]write_d_rd,write_d_Alu,Main_bus;
input [4:0]Write_reg_address;

output [31:0]read_d1,read_d2;

reg [31:0] Registers [31:0];

integer k;

assign read_d1 = Registers[Main_bus[19:15]];
assign read_d2 = Registers[Main_bus[24:20]];

always @ (posedge clk)
begin
	if(reset == 1'b1)
		begin
		for(k = 0; k < 32; k = k + 1)
			begin
			Registers[k] <= 32'h0;
			end
		end
	else begin if (MemToReg_in == 1'b1)
		begin
		if (RegWrite == 1'b1)
			begin
			Registers[Write_reg_address] <= write_d_rd;
			end
		end
	else
		begin
		if (RegWrite == 1'b1)
			begin
			Registers[Write_reg_address] <= write_d_Alu;
			end
		end
		end
end
endmodule