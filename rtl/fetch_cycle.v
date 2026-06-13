module fetch_cycle(	input clk, rst,
			output [31:0] instruction_D,
			input [31:0] I_write_data,
			input Imem_wr_en,
			input stallF,
			input stallD
);
wire [5:0] addr;
wire [31:0] instruction_F;
reg [31:0] instruction_D_reg;


ProgramCounter P1(	.clk(clk),
			.rst(rst),
			.addr(addr),
			.stallF(stallF)   );

instruction_mem I1(	.clk(clk),
			.address(addr),
			.Imem_wr_en(Imem_wr_en),
			.write_data(I_write_data),
			.read_data(instruction_F)     );

always@ (posedge clk or negedge rst)  begin
if(!rst) begin
instruction_D_reg <= 32'd0;
end
else if (stallD) begin
instruction_D_reg <= instruction_D_reg;
end
else begin
instruction_D_reg <= instruction_F;
end
end

assign instruction_D = (rst == 1'b0) ? 32'd0 : instruction_D_reg;
endmodule		
			
