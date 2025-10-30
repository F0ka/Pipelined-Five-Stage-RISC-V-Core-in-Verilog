`timescale 10ns/10ns

module testbench;

reg clk,reset;
reg [31:0]write_address;
reg [31:0]write_data;

RISCV_TOP uut(clk,reset,write_address,write_data);


always #1 clk = ~clk;  // 100mhz

initial
begin
	clk = 1; reset = 1;
	#1 reset = 0;
	#2 write_address = 10 ; write_data =32'b00000000010100000000001000010011;	// addi x4, x0, 5
	#2 write_address = 11 ; write_data =32'b00000000100000000000001010010011;	// addi x5, x0, 8
	#2 write_address = 15 ; write_data =32'b00000000010000101000001110110011;	// add x7, x5, x4       - after 4 addresses to avoid hazerd (STALL)
	#2 write_address = 16 ; write_data =32'b00000000001000000000010000010011;	// addi x8, x0, 2
	#2 write_address = 20 ; write_data =32'b01000000100000111000010100110011;	// sub x10, x7, x8	- after 4 addresses to avoid hazerd (STALL)
	#2 write_address = 24 ; write_data =32'b00000000101000000010001000100011;	// sw x10, 4(x0)	- after 4 addresses to avoid hazerd (STALL)
	#2 write_address = 25 ; write_data =32'b00000000011100000010000000100011;	// sw x7, 0(x0)		- after 4 addresses to avoid hazerd (STALL)
	#2 write_address = 29 ; write_data =32'b00000000010000000010011110000011;	// lw x15, 4(x0)	
	#2 write_address = 30 ; write_data =32'b00000000000000000010100000000011;	// lw x16, 0(x0)	- after 4 addresses to avoid hazerd (STALL)
	#2 write_address = 34 ; write_data =32'b00000001000001111000111100110011;	// add x30, x15, x16	- after 4 addresses to avoid hazerd (STALL)

	#2 write_address = 35 ; write_data =32'b11110110010000100000101011100011;	// beq x4, x4, -140	- LOOP 	(35 num of lasr address * 4 byte)
	
end
endmodule
