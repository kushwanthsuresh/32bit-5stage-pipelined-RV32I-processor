module topmodule1_tb();
reg clk,rst;
reg [31:0] I_write_data;
reg Imem_wr_en;
wire [31:0] y;
wire [3:0] flags;

topmodule1 dut(
.clk(clk),
.rst(rst),
.I_write_data(I_write_data),
.Imem_wr_en(Imem_wr_en),
.y(y),
.flags(flags)
);

initial begin
$shm_open("waves.shm");
$shm_probe("ACTMF");
end

initial begin
rst=1'b1;
end

initial begin
clk=1'b1;
forever #5 clk=~clk;
end

initial begin
I_write_data = 32'd0;
Imem_wr_en = 1'd0;
end

initial begin
#400;
$finish();
end

endmodule
