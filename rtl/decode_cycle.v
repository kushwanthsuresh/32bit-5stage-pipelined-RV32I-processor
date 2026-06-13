module decode_cycle(	input clk,
			input rst,flushE,
			output [31:0] rs1_data_E,
			output [31:0] write_data_E,
			output [31:0] data_E,
			output reg_wr_E,mem_read_en_E,imm_s_en_E,
			output [4:0] opcode_E,
			input [31:0] wd_W,
			input [31:0] instruction_D,
			input reg_wr_W ,
			input [4:0] rd_W,
			output [4:0] rd_E,
			output [4:0] rs1_D,rs2_D, rs1_E, rs2_E );
wire [31:0] rs1_data,rs2_data,imm_data;
wire [31:0] data;
wire [11:0] imm_temp_data;
wire imm_s_en, sign_ext_en, reg_wr, imm_en, mem_reg_en, mem_wr_en, mem_read_en;
wire [4:0] opcode;
reg [31:0] rs1_data_reg, write_data_reg, data_reg;
reg [11:0] imm_temp_data_reg;
reg reg_wr_reg,imm_en_reg,mem_read_en_reg, imm_s_en_reg, sign_ext_en_reg;
reg [4:0] opcode_reg;
reg [4:0] rd_reg, rs1_reg,rs2_reg;

controlunit C1(
.inst(instruction_D), 
.opcode(opcode),
.reg_wr(reg_wr),
.imm_en(imm_en),
.sign_ext_en(sign_ext_en),
.imm_s_en(imm_s_en),
.mem_read_en(mem_read_en)
//.mem_wr_en(mem_wr_en),
//.mem_reg_en(mem_reg_en)
);

mux2 M1 (
.a(instruction_D[31:20]),
.b({instruction_D[31:25],instruction_D[11:7]}),
.sel(imm_s_en),
.y(imm_temp_data)
);

sign_extend S1(
.sign_ext_en(sign_ext_en),
.imm_temp_data(imm_temp_data),
.imm_data(imm_data)
);

RegisterFileUnit R1(
.clk(clk),
.rst(rst),
.reg_wr(reg_wr_W),
.wd(wd_W), 
.rs1_add(instruction_D[19:15]), 
.rs2_add(instruction_D[24:20]), 
.rd_add(rd_W), 
.rs1_data(rs1_data), 
.rs2_data(rs2_data)
);

mux M2 (
.a2(rs2_data),
.b2(imm_data),
.sel2(imm_en), 
.y2(data)
);
assign rs1_D = instruction_D[19:15];
assign rs2_D = instruction_D[24:20];

always@ (posedge clk or negedge rst) begin
if(!rst) begin
rs1_data_reg <= 32'd0;
//rs2_data_reg <= 32'd0;
//imm_temp_data_reg <= 12'd0;
data_reg <= 32'd0;
//sign_ext_en_reg <= 1'b0;
reg_wr_reg <=1'd0;
opcode_reg <= 5'd31;
//imm_en_reg <= 1'd0;
//mem_reg_en_reg <= 1'd0;
//mem_wr_en_reg <= 1'd0;
imm_s_en_reg    <= 1'd0;
mem_read_en_reg <=1'd0;
rd_reg <=5'd0;
write_data_reg <= 31'd0;
rs1_reg <= 5'd0;
rs2_reg <= 5'd0;
end
else if (flushE) begin
rs1_data_reg <= rs1_data_reg;
data_reg <= data_reg;
reg_wr_reg <= 1'b0;
opcode_reg <= 5'd31;
imm_s_en_reg <= 1'd0;
mem_read_en_reg <= 1'd0;
rd_reg <= 5'd0;
write_data_reg <= 32'd0;
rs1_reg <= 5'd0;
rs2_reg <= 5'd0;
end
else begin
rs1_data_reg <= rs1_data;
//rs2_data_reg <= rs2_data;
//imm_temp_data_reg <= imm_temp_data;
//sign_ext_en_reg <= sign_ext_en;
data_reg <=data;
reg_wr_reg <=reg_wr;
opcode_reg <= opcode;
//imm_en_reg <= imm_en;
//mem_reg_en_reg <= mem_reg_en;
//mem_wr_en_reg <= mem_wr_en;
imm_s_en_reg <= imm_s_en;
mem_read_en_reg <=mem_read_en;
rd_reg <= instruction_D[11:7];
write_data_reg <= rs2_data;
rs1_reg <= instruction_D[19:15];
rs2_reg <= instruction_D[24:20];
end
end

assign rs1_data_E = rs1_data_reg;
//assign rs2_data_E = rs2_data_reg;
assign reg_wr_E =reg_wr_reg;
assign opcode_E = opcode_reg;
//assign imm_en_E = imm_en_reg;
//assign mem_reg_en_E = mem_reg_en_reg;
//assign mem_wr_en_E = mem_wr_en_reg;
assign imm_s_en_E = imm_s_en_reg;
assign mem_read_en_E = mem_read_en_reg;
assign rd_E = rd_reg;
assign data_E = data_reg;
//assign sign_ext_en_E = sign_ext_en_reg;
//assign imm_temp_data_E = imm_temp_data_reg;
assign write_data_E = write_data_reg;
assign rs1_E = rs1_reg;
assign rs2_E = rs2_reg;
endmodule



