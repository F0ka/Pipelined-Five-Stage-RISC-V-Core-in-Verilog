
module RISCV_TOP(input clk,reset,input[31:0]in_add,input[31:0]in_data);

wire [31:0]instractionTop,instraction_outTop,read_data1Top,read_data2Top,ALUResultTop,IMM_GENTop,data_mem_rd,IMM_PC_SUM_TOP;
wire [3:0]ALUControlTop;
wire ZeroTop;
wire [7:0]Control_Out_TOP;

wire [63:0]ID_TOP;	// 63:32[instractionTop],31:0[instraction_outTop]

wire [167:0]EX_TOP;	// 167:136[ID_TOP[instractionTop]],135:104[ID_TOP[instraction_outTop]]
			// ,103:72[read_data1Top],71:41[read_data2Top],39:8[IMM_GENTop],7:0[Control_Out_TOP]

wire [106:0]MEM_TOP;	// 106:75[ALUResultTop],74:43[EX_TOP[71:40]],42:11[IMM_PC_SUM_TOP],
			// 10:6[EX_TOP[115:111]],5:1[EX_TOP[5:1]],0[ZeroTop]

wire [70:0]WB_TOP;	// 70:39[data_mem_rd],38:7[MEM_TOP[106:75]],6:2[MEM_TOP[10:6]],1:0[MEM_TOP[2:1]]

PIPELINE_UNIT PIPELINE_UNIT
(.clk(clk)
,.reset(reset)
,.IF_ID_In({instractionTop,instraction_outTop})
,.IF_ID_Out(ID_TOP)
,.ID_EX_In({ID_TOP,read_data1Top,read_data2Top,IMM_GENTop,Control_Out_TOP})
,.ID_EX_Out(EX_TOP)
,.EX_MEM_In({ALUResultTop,EX_TOP[71:40],IMM_PC_SUM_TOP,EX_TOP[115:111],EX_TOP[5:1],ZeroTop})	
,.EX_MEM_Out(MEM_TOP)
,.MEM_WB_In({data_mem_rd,MEM_TOP[106:75],MEM_TOP[10:6],MEM_TOP[2:1]})
,.MEM_WB_Out(WB_TOP));


//---------------------------------------------------[IF-MEM]


PC_UNIT PC_UNIT
(.clk(clk),
.reset(reset),
.IsBranch(MEM_TOP[5]), 		
.IsZero(MEM_TOP[0]), 		
.imm_PC_SUM(MEM_TOP[42:11]), 	
.PC_out(instractionTop));

INSTRACTION_MEM_UNIT INSTRACTION_MEM_UNIT
(.reset(reset),
.clk(clk),
.write_address(in_add),
.write_data(in_data),
.read_address(instractionTop),
.instraction_out(instraction_outTop));


//---------------------------------------------------[ID-WB]


CONTROL_UNIT CONTROL_UNIT
(.instraction(ID_TOP[31:0]),
.Control_Out(Control_Out_TOP));

REGISTER_FILE REGISTER_FILE
(.clk(clk),
.reset(reset),
.Main_bus(ID_TOP[31:0]),
.Write_reg_address(WB_TOP[6:2]), 	
.write_d_rd(WB_TOP[70:39]), 			
.write_d_Alu(WB_TOP[38:7]), 		
.RegWrite(WB_TOP[1]), 			
.read_d1(read_data1Top), 	
.read_d2(read_data2Top), 	
.MemToReg_in(WB_TOP[0])); 		

IMM_GEN_UNIT IMM_GEN_UNIT
(.In(ID_TOP[31:0]),
.Out(IMM_GENTop));


//---------------------------------------------------[EX]---DONE


ALU_CONTROL_UNIT ALU_CONTROL_UNIT
(.Main_Bus(EX_TOP[135:104]),
.ALUOp_in(EX_TOP[7:6]),
.control_out(ALUControlTop));

ALU_UNIT ALU_UNIT
(.a(EX_TOP[103:72]),		
.b(EX_TOP[71:40]),		
.ALU_B_control(EX_TOP[0]),	
.zero(ZeroTop),
.imm_gen_in(EX_TOP[39:8]),
.control(ALUControlTop),
.result(ALUResultTop),
.PC_IN(EX_TOP[167:136]),
.PCSUMIMM_OUT(IMM_PC_SUM_TOP));


//---------------------------------------------------[MEM]


DATA_MEM_UNIT DATA_MEM_UNIT
(.clk(clk),
.reset(reset),
.MemWrite(MEM_TOP[4]),			
.MemRead(MEM_TOP[3]),			
.Address(MEM_TOP[106:75]),		
.Write_data(MEM_TOP[74:43]),	
.Read_Data(data_mem_rd));		




endmodule