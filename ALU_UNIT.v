
module ALU_UNIT(a,b,ALU_B_control,zero,imm_gen_in,control,result,PC_IN,PCSUMIMM_OUT);

input [31:0]a,b,PC_IN;
input [31:0]imm_gen_in;
input [3:0] control;
input ALU_B_control;
output reg [31:0] result,PCSUMIMM_OUT;
output reg zero;

always @ (*)
begin
PCSUMIMM_OUT <= PC_IN + imm_gen_in;
if (ALU_B_control == 1'b1)
begin
	case(control)
	4'b0000 : begin zero <= 0; result <= a & imm_gen_in; end
	4'b0001 : begin zero <= 0; result <= a | imm_gen_in; end
	4'b0010 : begin zero <= 0; result <= a + imm_gen_in; end
	4'b0110 : begin zero <= 1; result <= a - imm_gen_in; end
	default: begin zero <= 0; result <= a; end
	endcase
end
else
begin
	case(control)
	4'b0000 : begin zero <= 0; result <= a & b; end
	4'b0001 : begin zero <= 0; result <= a | b; end
	4'b0010 : begin zero <= 0; result <= a + b; end
	4'b0110 : begin zero <= 1; result <= a - b; end
	default: begin zero <= 0; result <= a; end
	endcase
end
end
endmodule