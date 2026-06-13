module execute_cycle(	input [31:0] rs1_data_E, data_E,write_data_E,wd_W,alu_out_Mb,
			//input [11:0] imm_temp_data_E,
			input [4:0] rd_E,
			input reg_wr_E, mem_read_en_E, imm_s_en_E,
			input [4:0] opcode_E,
			output [31:0] alu_out_M, 
			output [3:0] flags,
			input clk,
			input rst,
			output [31:0] write_data_M,
			output [4:0] rd_M,
			output reg_wr_M, mem_read_en_M, imm_s_en_M,
			input [1:0] ForwardAE, ForwardBE);
wire [31:0] alu_out_E,alu_data1,alu_data2;
wire Z,N,OV,C;
reg [31:0] alu_out_reg, write_data_reg;
reg [4:0] rd_reg;
reg [3:0] flags_reg;
reg reg_wr_reg, mem_read_en_reg, imm_s_en_reg;

/*sign_extend S1(
.sign_ext_en(sign_ext_en_E),
.imm_temp_data(imm_temp_data_E),
.imm_data(imm_data_E)
);

mux M2 (
.a2(rs2_data_E),
.b2(imm_data_E),
.sel2(imm_en_E), 
.y2(data)
);*/

mux3to1 M1 (.a(rs1_data_E),
	    .b(wd_W),
	    .c(alu_out_Mb),
	    .s(ForwardAE),
	    .d(alu_data1)   );

mux3to1 M2 (.a(data_E),
	    .b(wd_W),
	    .c(alu_out_Mb),
	    .s(ForwardBE),
	    .d(alu_data2)   );


ALU A1(
.rs1_d(alu_data1), 
.rs2_d(alu_data2), 
.opcode(opcode_E), 
.rd_d(alu_out_E), 
.Z(Z),
.C(C),
.OV(OV),
.N(N)
);


always@ (posedge clk or negedge rst) begin
if(!rst) begin
alu_out_reg <= 32'd0;
rd_reg <= 5'd0;
reg_wr_reg <= 1'b0;
//mem_reg_en_reg <= 1'b0;
//mem_wr_en_reg <= 1'b0;
imm_s_en_reg <= 1'b0;
mem_read_en_reg <= 1'b0;
write_data_reg <= 32'd0;
flags_reg <= 4'd0;
end
else begin
alu_out_reg <= alu_out_E;
rd_reg <= rd_E;
reg_wr_reg <= reg_wr_E;
//mem_reg_en_reg <= mem_reg_en_E;
//mem_wr_en_reg <= mem_wr_en_E;
imm_s_en_reg <= imm_s_en_E;
mem_read_en_reg <= mem_read_en_E;
write_data_reg <= write_data_E;
flags_reg <= {C,OV,Z,N};
end
end

assign alu_out_M = alu_out_reg;
assign rd_M = rd_reg;
assign reg_wr_M = reg_wr_reg;
//assign mem_reg_en_M = mem_reg_en_reg;
//assign mem_wr_en_M = mem_wr_en_reg;
assign imm_s_en_M = imm_s_en_reg;
assign mem_read_en_M = mem_read_en_reg;
assign write_data_M = write_data_reg;
assign flags = flags_reg;
endmodule
