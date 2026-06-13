module execute_cycle_tb ();
reg [31:0] rs1_data_E, rs2_data_E, imm_data_E;
reg [4:0] rd_E;
reg reg_wr_E, imm_en_E, mem_reg_en_E, mem_wr_en_E, mem_read_en_E;
reg [4:0] opcode_E;
wire [31:0] alu_out_M; 
wire [3:0] flags;
reg clk;
reg rst;
wire [31:0] write_data_M;
wire [4:0] rd_M;
wire reg_wr_M, mem_reg_en_M, mem_wr_en_M, mem_read_en_M;

execute_cycle dut(
.rs1_data_E(rs1_data_E),
.rs2_data_E(rs2_data_E),
.imm_data_E(imm_data_E),
.rd_E(rd_E),
.reg_wr_E(reg_wr_E),
.imm_en_E(imm_en_E),
.mem_reg_en_E(mem_reg_en_E),
.mem_wr_en_E(mem_wr_en_E),
.mem_read_en_E(mem_read_en_E),
.opcode_E(opcode_E),
.alu_out_M(alu_out_M),
.flags(flags),
.clk(clk),
.rst(rst),
.write_data_M(write_data_M),
.rd_M(rd_M),
.reg_wr_M(reg_wr_M),
.mem_reg_en_M(mem_reg_en_M),
.mem_wr_en_M(mem_wr_en_M),
.mem_read_en_M(mem_read_en_M));

initial begin
$shm_open("waves.shm");
$shm_probe("ACTMF");
end

initial begin
rst = 1'b1;
end

initial begin
clk = 1'b0;
forever #5 clk=~clk;
end

initial begin
rs1_data_E = 32'd10;
rs2_data_E = 32'd5;
imm_data_E = 32'd5;
imm_en_E =1'd1;
end

initial begin
opcode_E = 5'd0;#5;
forever #10 opcode_E=opcode_E+1;
end

initial begin
#200;
$finish();
end
endmodule
