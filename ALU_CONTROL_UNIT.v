
module ALU_CONTROL_UNIT(Main_Bus,ALUOp_in,control_out);

input [31:0]Main_Bus;
input [1:0]ALUOp_in;

output reg [3:0]control_out;


always @ (*)
begin
casez({ALUOp_in,Main_Bus[31:25],Main_Bus[14:12]})
	12'b00_???????_??? : control_out <= 4'b0010;
	12'b?1_???????_??? : control_out <= 4'b0110;
	12'b1?_0000000_000 : control_out <= 4'b0010;
	12'b1?_0100000_000 : control_out <= 4'b0110;
	12'b1?_0000000_111 : control_out <= 4'b0000;
	12'b1?_0000000_110 : control_out <= 4'b0001;
	default: control_out = 4'b0000;
endcase
end
endmodule
	
