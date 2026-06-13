/*
module instruction_mem( input [4:0] addr,
			output reg [31:0] inst,
			input clk);
reg [31:0] mem [0:31];
//initial begin
//mem[0] = 32'h003100B3;
//mem[1] = 32'h40628233;
//mem[2] = 32'h009403B3;
//mem[3] = 32'h00C58533;
//mem[4] =32'h00F746B3;
//mem[5] =32'h01289833;
//mem[6] =32'h015A59B3;
//mem[7] =32'h418BDC33;
//mem[8] =32'h01BCEA33;
//mem[9] =32'h01ED6E33;
//mem[10] =32'h00A10093;
//mem[11] =32'hFFB20193;
//mem[12] =32'h00F37293;
//mem[13] =32'h00344393;
//mem[14] =32'h00752493;
//mem[15] =32'h00462593;
//mem[16] =32'h06470693;
//mem[17] =32'hFFF80793;
//mem[18] =32'h00894893;
//mem[19] =32'h001A7A13;
//mem[20] =32'h00012083;
//mem[21] =32'h00422183;
//mem[22] =32'h00832283;
//mem[23] =32'h00C42383;
//mem[24] =32'h01052483;
//mem[25] =32'h01462583;
//mem[26] =32'h00112023;
//mem[27] =32'h00322223;
//mem[28] =32'h00532423;
//mem[29] =32'h00742623;
//mem[30] =32'h00952823;
//mem[31] =32'h00B62A23;
//end

always @(posedge clk)
begin
if(<=mem[addr];
end
endmodule
*/
module instruction_mem (

		input [5:0] address,
		input clk,
		//input mem_read_en,
		input Imem_wr_en,
		input [31:0] write_data,
		output [31:0] read_data);
reg [31:0] Imem [63:0];
initial begin
Imem[0] = 32'h003100B3;
Imem[1] = 32'h00012083;
Imem[2] = 32'h004081b3;
Imem[3] = 32'h40508233;
Imem[4] =32'h00F746B3;
Imem[5] =32'h01289833;
Imem[6] =32'h015A59B3;
Imem[7] =32'h418BDC33;
Imem[8] =32'h01BCEA33;
Imem[9] =32'h01ED6E33;
Imem[10] =32'h00A10093;
Imem[11] =32'hFFB20193;
Imem[12] =32'h00F37293;
Imem[13] =32'h00344393;
Imem[14] =32'h00752493;
Imem[15] =32'h00462593;
Imem[16] =32'h06470693;
Imem[17] =32'hFFF80793;
Imem[18] =32'h00894893;
Imem[19] =32'h001A7A13;
Imem[20] =32'h00112023;
Imem[21] =32'h00322223;
Imem[22] =32'h00532423;
Imem[23] =32'h00742623;
Imem[24] =32'h00952823;
Imem[25] =32'h00B62A23;
Imem[26] =32'h00012083;
Imem[27] =32'h00422183;
Imem[28] =32'h00832283;
Imem[29] =32'h00C42383;
Imem[30] =32'h01052483;
Imem[31] =32'h01462583;
end

assign read_data =  Imem[address] ;
always @(posedge clk) begin
if (Imem_wr_en) 
Imem[address] <= write_data;
end
endmodule 
