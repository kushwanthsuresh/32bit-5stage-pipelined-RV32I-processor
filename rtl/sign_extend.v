module sign_extend(
		input sign_ext_en,
		input [11:0] imm_temp_data,
		output reg [31:0] imm_data);
always @(*) begin
if (!sign_ext_en) 
	imm_data = {{20{1'b0}},imm_temp_data[11:0]}; 
else
	imm_data = {{20{imm_temp_data[11]}},imm_temp_data[11:0]};
end
endmodule
