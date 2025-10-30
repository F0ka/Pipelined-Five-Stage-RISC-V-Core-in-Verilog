
module CONTROL_UNIT(instraction,Control_Out);

input [31:0]instraction;
output reg [7:0]Control_Out;

always @ (instraction)
begin
casez(instraction[6:0])
	7'b0110011 : 
	begin			//R-format
	Control_Out[0] <= 1'b0;			//ALUSrc  0
	Control_Out[1] <= 1'b0;			//MemtoReg  1
	Control_Out[2] <= 1'b1;			//RegWrite  2
	Control_Out[3] <= 1'b0;			//MemRead  3
	Control_Out[4] <= 1'b0;			//MemWrite  4
	Control_Out[5] <= 1'b0;			//Branch  5
	Control_Out[7:6] <= 2'b10;		//ALUOp 7:6
	end
	7'b0010011 : 
	begin			//I-format
	Control_Out[0] <= 1'b1;			//ALUSrc  0
	Control_Out[1] <= 1'b0;			//MemtoReg  1
	Control_Out[2] <= 1'b1;			//RegWrite  2
	Control_Out[3] <= 1'b0;			//MemRead  3
	Control_Out[4] <= 1'b0;			//MemWrite  4
	Control_Out[5] <= 1'b0;			//Branch  5
	Control_Out[7:6] <= 2'b10;		//ALUOp 7:6
	end
	7'b0000011 : 
	begin			//lw
	Control_Out[0] <= 1'b1;
	Control_Out[1] <= 1'b1;
	Control_Out[2] <= 1'b1;
	Control_Out[3] <= 1'b1;
	Control_Out[4] <= 1'b0;
	Control_Out[5] <= 1'b0;
	Control_Out[7:6] <= 2'b00;
	end
	7'b0100011 : 
	begin			//sw
	Control_Out[0] <= 1'b1;
	Control_Out[1] <= 1'bx;
	Control_Out[2] <= 1'b0;
	Control_Out[3] <= 1'b0;
	Control_Out[4] <= 1'b1;
	Control_Out[5] <= 1'b0;
	Control_Out[7:6] <= 2'b00;
	end
	7'b1100011 : 
	begin			//sw
	Control_Out[0] <= 1'b0;
	Control_Out[1] <= 1'bx;
	Control_Out[2] <= 1'b0;
	Control_Out[3] <= 1'b0;
	Control_Out[4] <= 1'b0;
	Control_Out[5] <= 1'b1;
	Control_Out[7:6] <= 2'b01;
	end
	default :
	begin
	Control_Out[0] <= 1'b0;
	Control_Out[1] <= 1'b0;
	Control_Out[2] <= 1'b0;
	Control_Out[3] <= 1'b0;
	Control_Out[4] <= 1'b0;
	Control_Out[5] <= 1'b0;
	Control_Out[7:6] <= 2'b00;
	end
endcase
end
endmodule