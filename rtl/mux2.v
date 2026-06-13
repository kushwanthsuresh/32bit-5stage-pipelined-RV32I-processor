module mux2 (
  input   [11:0]    a,
  input   [11:0]    b,
  input            sel,
  output [11:0]    y
);
assign y = sel ? b : a ;
endmodule
