module mux(
	input [31:0] a2,
	input [31:0] b2,
	input sel2,
 	output [31:0] y2);
assign y2 = sel2 ? b2 : a2 ;
endmodule
