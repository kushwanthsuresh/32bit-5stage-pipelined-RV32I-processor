module ProgramCounter(  input clk,
			input rst,
			input stallF,
			output reg [5:0] addr);
initial begin
addr=1'b0;
end
always @(posedge clk or negedge rst) begin
if(!rst)
addr<=6'd0;
else if(stallF)
addr<=addr;
else
addr<=addr+1;
end
endmodule
