

module HAZERD_UNIT(clk,reset,IS_LOAD,In_IF_ID,In_ID_EX,read_data1,read_data2,In_EX_MEM,In_MEM_WB,RD_MEM_WB,ALUD_MEM_WB,WriteCTRL_EX_MEM,WriteCTRL_MEM_WB,WB_MUX,OUT_A,OUT_B,STALL);

input clk,reset,WriteCTRL_EX_MEM,WriteCTRL_MEM_WB,WB_MUX,IS_LOAD; // CLK + RESET + WRITE TRL IN (MEM) AND (WB) + (WB) MUX CTRL 
input [135:104]In_ID_EX;	//INSTRUTION IN (EXE) *RS1 AND RS2 FROM IT* (FORWARDING)
input [31:0]In_IF_ID;		//INSTRUTION IN (ID)*RS1 AND RS2 FROM IT* (STALLING)
input [103:72]read_data1;	//RS1 DATA IN (EXE)
input [71:41]read_data2;	//RS2 DATA IN (EXE)
input [10:6]In_EX_MEM;  	//WRITE ADDRESS IN (MEM)
input [6:2]In_MEM_WB;		//WRITE ADDRESS IN (WB)
input [70:39]RD_MEM_WB;		//MEMORY DATA IN (WB)
input [38:7]ALUD_MEM_WB;	//ALU OUTPUT DATA IN (WB)
output reg [31:0]OUT_A,OUT_B;	//OUTPUTS FOR HAZERD MUXS
output reg STALL;

reg [1:0] FRWD_A,FRWD_B; 


// IF_ID_Out
// 63:32[instractionTop],31:0[instraction_outTop]

// ID_EX_Out
// 167:136[ID_TOP[instractionTop]],135:104[ID_TOP[instraction_outTop]]
// ,103:72[read_data1Top],71:41[read_data2Top],39:8[IMM_GENTop],7:0[Control_Out_TOP]

// EX_MEM_Out
// 106:75[ALUResultTop],74:43[EX_TOP[71:40]],42:11[IMM_PC_SUM_TOP],
// 10:6[EX_TOP[115:111]],5:1[EX_TOP[5:1]],0[ZeroTop]

// MEM_WB_Out
// 70:39[data_mem_rd],38:7[MEM_TOP[106:75]],6:2[MEM_TOP[10:6]],1:0[MEM_TOP[2:1]]

always @ (posedge clk)
begin

if(reset)begin
	FRWD_A <= 0;
	FRWD_B <= 0;
	STALL <= 0;
end
else begin


// FORWARDING
if(In_ID_EX[19:15] != 0 && In_ID_EX[19:15] == In_EX_MEM && WriteCTRL_EX_MEM) FRWD_A <= 2'b10;   //rs1 (a)
else if(In_ID_EX[123:119] != 0 && In_ID_EX[123:119] == In_MEM_WB && WriteCTRL_EX_MEM) FRWD_A <= 2'b01;   //rs1 (a)
else FRWD_A <= 2'b00;

if(In_ID_EX[24:20] != 0 && In_ID_EX[19:15] == In_EX_MEM && WriteCTRL_MEM_WB) FRWD_B <= 2'b10; 	//rs2 (b)
else if(In_ID_EX[123:119] != 0 && In_ID_EX[123:119] == In_MEM_WB && WriteCTRL_MEM_WB) FRWD_B <= 2'b01;   //rs1 (a)
else FRWD_B <= 2'b00;

// STALLING 
if (In_IF_ID[19:15] == In_ID_EX[115:111] || In_IF_ID[24:20] == In_ID_EX[115:111] && IS_LOAD) STALL <= 1;
else STALL <= 0;

case(FRWD_A)	// RS1 FORWARDING MUX
	4'b01 :
	begin
	if(WB_MUX) OUT_A <= RD_MEM_WB;		// FROM WB MUX 
	else OUT_A <= ALUD_MEM_WB ;         	// CAN BE IMPROVED 
	end
	2'b10 : OUT_A <= In_EX_MEM;		// FROM ALU			
	default : OUT_A <= read_data1;				
endcase

case(FRWD_B)	// RS2 FORWARDING MUX
	4'b01 :
	begin
	if (WB_MUX) OUT_B <= RD_MEM_WB;		// FROM WB MUX 
	else OUT_A <= ALUD_MEM_WB ;		// CAN BE IMPROVED 
	end
	2'b10 : OUT_B <= In_EX_MEM;		// FROM ALU		
	default : OUT_B <= read_data2;				
endcase


end
end
endmodule