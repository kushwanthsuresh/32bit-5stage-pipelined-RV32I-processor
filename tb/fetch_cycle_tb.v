module fetch_cycle_tb();
reg clk;
reg rst;
wire [31:0] instruction_D;
reg [31:0] I_write_data;
reg Imem_wr_en;

fetch_cycle dut(
.clk(clk),
.rst(rst),
.instruction_D(instruction_D),
.I_write_data(I_write_data),
.Imem_wr_en(Imem_wr_en));

initial begin
$shm_open("waves.shm");
$shm_probe("ACTMF");
end

initial begin
rst =1'b0;#30;
rst = 1'b1;
end

initial begin
clk = 1'b0;
forever #5 clk=~clk;
end

initial begin
I_write_data= 32'd0;
Imem_wr_en = 1'b0;
end

initial begin
#400;
$finish();
end

endmodule
