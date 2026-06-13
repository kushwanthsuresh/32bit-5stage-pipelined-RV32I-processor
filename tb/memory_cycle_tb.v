module memory_cycle_tb();
reg [31:0] alu_out_M, write_data_M;
reg [4:0] rd_M;
reg reg_wr_M, mem_reg_en_M, mem_wr_en_M, mem_read_en_M;
wire [31:0] data_mem_out_W, alu_out_W;
wire [4:0] rd_W;
wire reg_wr_W, mem_reg_en_W;
reg clk,rst;

memory_cycle dut(
.alu_out_M(alu_out_M),
.write_data_M(write_data_M),
.rd_M(rd_M),
.reg_wr_M(reg_wr_M),
.mem_reg_en_M(mem_reg_en_M),
.mem_wr_en_M(mem_wr_en_M),
.mem_read_en_M(mem_read_en_M),
.data_mem_out_W(data_mem_out_W),
.alu_out_W(alu_out_W),
.rd_W(rd_W),
.reg_wr_W(reg_wr_W),
.mem_reg_en_W(mem_reg_en_W),
.clk(clk),
.rst(rst));

initial begin
$shm_open("waves.shm");
$shm_probe("ACTMF");
end

initial begin
rst =1'b1;
end

initial begin
clk=1'b0;
forever #5 clk=~clk;
end

initial begin
mem_read_en_M=1'b1;#40;
mem_read_en_M=1'b0;
mem_wr_en_M=1'b1;#40;
end

initial begin
alu_out_M=32'd5;#10;
alu_out_M=32'd6;#10;
alu_out_M=32'd7;#10;
alu_out_M=32'd8;#10;
alu_out_M=32'd0;#10;
alu_out_M=32'd1;#10;
alu_out_M=32'd2;#10;
alu_out_M=32'd3;#10;
end

initial begin
#20;
write_data_M=32'd20;#5;
write_data_M=32'd21;#5;
write_data_M=32'd22;#5;
write_data_M=32'd23;#5;
end

initial begin
#200;
$finish();
end
endmodule
