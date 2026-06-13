module decode_cycle_tb();
reg clk;
reg rst;
wire [31:0] rs1_data_E;
wire [31:0] rs2_data_E;
wire [31:0] imm_data_E;
wire reg_wr_E, imm_en_E, mem_reg_en_E, mem_wr_en_E, mem_read_en_E;
wire [4:0] opcode_E;
reg [31:0] wd;
reg [31:0] instruction_D;
reg reg_wr_W ;
reg [4:0] rd_W;
wire [4:0] rd_E;

decode_cycle dut(
.clk(clk),
.rst(rst),
.rs1_data_E(rs1_data_E),
.rs2_data_E(rs2_data_E),
.imm_data_E(imm_data_E),
.reg_wr_E(reg_wr_E),
.opcode_E(opcode_E),
.imm_en_E(imm_en_E),
.mem_reg_en_E(mem_reg_en_E),
.mem_wr_en_E(mem_wr_en_E),
.mem_read_en_E(mem_read_en_E),
.wd(wd),
.instruction_D(instruction_D),
.reg_wr_W(reg_wr_W),
.rd_W(rd_W),
.rd_E(rd_E));

initial begin
$shm_open("waves.shm");
$shm_probe("ACTMF");
end

initial begin
clk=1'b0;
forever #5 clk=~clk;
end

initial begin
rst=1'b1;
end

initial begin
instruction_D = 32'h40628233;#10;
instruction_D  = 32'h009403B3;#10;
instruction_D  = 32'h00C58533;#10;
instruction_D  =32'h00F746B3;#10;
instruction_D  =32'h01289833;#10;
instruction_D  =32'h015A59B3;#10;
instruction_D  =32'h418BDC33;#10;
instruction_D  =32'h01BCEA33;#10;
instruction_D  =32'h01ED6E33;#10;
instruction_D  =32'h00A10093;#10;
instruction_D  =32'hFFB20193;#10;
instruction_D  =32'h00F37293;#10;
instruction_D  =32'h00344393;#10;
instruction_D  =32'h00752493;#10;
instruction_D  =32'h00462593;#10;
instruction_D  =32'h06470693;#10;
instruction_D  =32'hFFF80793;#10;
instruction_D  =32'h00894893;#10;
instruction_D  =32'h001A7A13;#10;
instruction_D  =32'h00012083;#10;
instruction_D  =32'h00422183;#10;
instruction_D  =32'h00832283;#10;
instruction_D  =32'h00C42383;#10;
instruction_D  =32'h01052483;#10;
instruction_D  =32'h01462583;#10;
instruction_D  =32'h00112023;#10;
instruction_D  =32'h00322223;#10;
instruction_D  =32'h00532423;#10;
instruction_D  =32'h00742623;#10;
instruction_D  =32'h00952823;#10;
instruction_D  =32'h00B62A23;#10;
end

initial begin
#500;
$finish();
end
endmodule
