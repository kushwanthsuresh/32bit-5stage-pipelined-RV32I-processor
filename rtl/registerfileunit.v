module RegisterFileUnit( input clk,
			input reg_wr,
			input [31:0] wd,
			input [4:0] rd_add, 
			input [4:0] rs1_add,
			input [4:0] rs2_add,
			output [31:0] rs1_data,
			output [31:0] rs2_data,
			input rst);
reg [31:0] register [31:0];
integer i;
initial begin
register[0]  = 32'd0;
register[1]  = 32'd4857;
register[2]  = 32'd8474;
register[3]  = 32'd9404;
register[4]  = 32'd8475;
register[5]  = 32'd9087;
register[6]  = 32'd5465;
register[7]  = 32'd7465;
register[8]  = 32'd6454;
register[9]  = 32'd9475;
register[10] = 32'd3923;
register[11] = 32'd7465;
register[12] = 32'd9274;
register[13] = 32'd7465;
register[14] = 32'd8465;
register[15] = 32'd8566;
register[16] = 32'd8576;
register[17] = 32'd7465;
register[18] = 32'd8465;
register[19] = 32'd4365;
register[20] = 32'd9374;
register[21] = 32'd7465;
register[22] = 32'd8475;
register[23] = 32'd9374;
register[24] = 32'd7485;
register[25] = 32'd8475;
register[26] = 32'd7465;
register[27] = 32'd7465;
register[28] = 32'd7485;
register[29] = 32'd1015;
register[30] = 32'd74985;
register[31] = 32'd9826;
end

always @(posedge clk or negedge rst) begin
if(!rst) begin
for(i=0;i<32;i=i+1) begin
register[i]<=32'd0;
end
end
else if(reg_wr) begin
register[rd_add]<=wd;
end
end
assign rs1_data =  register[rs1_add];
assign rs2_data =  register[rs2_add];
endmodule
