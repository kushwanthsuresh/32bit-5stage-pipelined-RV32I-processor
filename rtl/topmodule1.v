module topmodule1( 	input clk,
			input rst,
			input [31:0] I_write_data,
			input Imem_wr_en,
			output [31:0] y,
			output [3:0] flags);
wire [31:0] instruction_D, rs1_data_E, wd_W, alu_out_M, write_data_M, alu_out_W, data_mem_out_W,write_data_E,data_E,alu_out_Mb;
//wire [11:0] imm_temp_data_E;
wire imm_s_en_E, reg_wr_E,  mem_read_en_E, reg_wr_W, imm_s_en_M, reg_wr_M, mem_read_en_M, mem_read_en_W,stallF,stallD,flushE;
wire [4:0] opcode_E, rd_E, rd_W, rd_M, rs1_D, rs2_D, rs1_E, rs2_E;
wire [1:0] ForwardAE, ForwardBE;

fetch_cycle F1 (
.clk(clk),
.rst(rst),
.instruction_D(instruction_D),
.I_write_data(I_write_data),
.Imem_wr_en(Imem_wr_en),
.stallF(stallF),
.stallD(stallD)
);

decode_cycle D1 (
.clk(clk),
.rst(rst),
.rd_W(rd_W),
.rs1_data_E(rs1_data_E),
.write_data_E(write_data_E),
//.imm_temp_data_E(imm_temp_data_E),
.imm_s_en_E(imm_s_en_E),
.reg_wr_E(reg_wr_E),
.opcode_E(opcode_E),
//.imm_en_E(imm_en_E),
.mem_read_en_E(mem_read_en_E),
.rd_E(rd_E),
.reg_wr_W(reg_wr_W),
.wd_W(wd_W),
.instruction_D(instruction_D),
//.sign_ext_en_E(sign_ext_en_E)
.data_E(data_E),
.rs1_D(rs1_D),
.rs2_D(rs2_D),
.rs1_E(rs1_E),
.rs2_E(rs2_E),
.flushE(flushE)
);

execute_cycle E1 (
.clk(clk),
.rst(rst),
.rd_M(rd_M),
.alu_out_M(alu_out_M),
.write_data_M(write_data_M),
.imm_s_en_M(imm_s_en_M),
.reg_wr_M(reg_wr_M),
.mem_read_en_M(mem_read_en_M),
.flags(flags),
.rs1_data_E(rs1_data_E),
.data_E(data_E),
.imm_s_en_E(imm_s_en_E),
.reg_wr_E(reg_wr_E),
.opcode_E(opcode_E),
//.imm_en_E(imm_en_E),
.mem_read_en_E(mem_read_en_E),
.rd_E(rd_E),
.write_data_E(write_data_E),
.alu_out_Mb(alu_out_Mb),
.ForwardBE(ForwardBE),
.ForwardAE(ForwardAE),
.wd_W(wd_W)
//.sign_ext_en_E(sign_ext_en_E),
//.imm_temp_data_E(imm_temp_data_E)
);

memory_cycle M1(
.clk(clk),
.rst(rst),
.rd_W(rd_W),
.alu_out_W(alu_out_W),
.data_mem_out_W(data_mem_out_W),
.mem_read_en_W(mem_read_en_W),
.reg_wr_W(reg_wr_W),
.rd_M(rd_M),
.alu_out_M(alu_out_M),
.write_data_M(write_data_M),
.imm_s_en_M(imm_s_en_M),
.reg_wr_M(reg_wr_M),
.mem_read_en_M(mem_read_en_M),
.alu_out_Mb(alu_out_Mb)
);

mux M2(
.a2(alu_out_W),
.b2(data_mem_out_W),
.sel2(mem_read_en_W),
.y2(wd_W)
);

hazardunit H1 ( 
.rst(rst),
.reg_wr_M(reg_wr_M),
.reg_wr_W(reg_wr_W),
.mem_read_en_E(mem_read_en_E),
.rd_M(rd_M),
.rd_W(rd_W),
.rs1_E(rs1_E),
.rs2_E(rs2_E),
.rs1_D(rs1_D),
.rs2_D(rs2_D),
.rd_E(rd_E),
.ForwardAE(ForwardAE),
.ForwardBE(ForwardBE),
.stallF(stallF),
.stallD(stallD),
.flushE(flushE)
);


assign y = wd_W;
endmodule


			
