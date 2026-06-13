module DataMemory (
		input [5:0] address,
		input clk,
		input rst,
		input mem_read_en,
		input mem_wr_en,
		input [31:0] write_data,
		output [31:0] read_data);
reg [31:0] Dmem [63:0];
integer i;
initial begin
for (i=0; i<64; i=i+1) begin
Dmem[i]= i+7;
end
end
assign read_data = (mem_read_en) ? Dmem[address] : 32'd0;
always @(posedge clk or negedge rst) begin
if(!rst) begin
for(i=0; i<64; i=i+1) 
Dmem[i] <= 32'd0;
end
else if (mem_wr_en) 
Dmem[address] <= write_data;
end
endmodule 
