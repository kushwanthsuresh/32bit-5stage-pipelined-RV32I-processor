module memory_cycle(	input [31:0] alu_out_M, write_data_M,
			input [4:0] rd_M,
			input reg_wr_M, mem_read_en_M, imm_s_en_M,
			output [31:0] data_mem_out_W,
			output [4:0] rd_W,
			output reg_wr_W, mem_read_en_W,
			output [31:0] alu_out_W,
			output [31:0] alu_out_Mb,
			input clk,rst);
wire [31:0] data_mem_out_M;
reg [31:0] data_mem_out_reg, alu_out_reg;
reg [4:0] rd_reg;
reg reg_wr_reg, mem_read_en_reg;
assign alu_out_Mb = alu_out_M;

DataMemory DM1 (
.clk(clk),
.rst(rst),
.address(alu_out_M[5:0]),
.mem_read_en(mem_read_en_M),
.mem_wr_en(imm_s_en_M),
.write_data(write_data_M),
.read_data(data_mem_out_M)
);

always@ (posedge clk or negedge rst) begin
if(!rst) begin
data_mem_out_reg <= 32'd0;
alu_out_reg <= 32'd0;
rd_reg <= 5'd0;
reg_wr_reg <= 1'd0;
mem_read_en_reg <= 1'd0;
end

else begin
data_mem_out_reg <= data_mem_out_M;
alu_out_reg <= alu_out_M;
rd_reg <= rd_M;
reg_wr_reg <= reg_wr_M;
mem_read_en_reg <= mem_read_en_M;
end
end

assign data_mem_out_W = data_mem_out_reg;
assign alu_out_W = alu_out_reg;
assign rd_W = rd_reg;
assign reg_wr_W = reg_wr_reg;
assign mem_read_en_W = mem_read_en_reg;

endmodule

