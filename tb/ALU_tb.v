module ALU_tb();
reg [31:0] rs1_d;
reg [31:0] rs2_d;
reg [4:0] opcode;
wire [31:0] rd_d;
wire Z;
wire N;
wire OV;
wire C;

ALU dut(
.rs1_d(rs1_d),
.rs2_d(rs2_d),
.opcode(opcode),
.rd_d(rd_d),
.Z(Z),
.OV(OV),
.N(N),
.C(C)
);

initial begin
$shm_open("waves.shm");
$shm_probe("ACTMF");
end

initial begin
rs1_d=32'h00000005;
rs2_d=32'h00000007;

end

initial begin
opcode=5'd18;#5;
opcode=5'd19;#5;
opcode=5'd20;#5;
opcode=5'd21;#5;
opcode=5'd22;#5;
opcode=5'd23;#5;
opcode=5'd24;#5;
opcode=5'd25;#5;
opcode=5'd26;#5;
opcode=5'd9;#5;
opcode=5'd10;#5;
opcode=5'd11;#5;
opcode=5'd12;#5;
opcode=5'd13;#5;
opcode=5'd14;#5;
opcode=5'd15;#5;
opcode=5'd16;#5;
opcode=5'd17;#5;
opcode=5'd0;#5;
opcode=5'd1;#5;
opcode=5'd2;#5;
opcode=5'd3;#5;
opcode=5'd4;#5;
opcode=5'd5;#5;
opcode=5'd6;#5;
opcode=5'd7;#5;
opcode=5'd8;#5;
opcode=5'd9;#5;
opcode=5'd10;#5;
opcode=5'd11;#5;
opcode=5'd12;#5;
opcode=5'd13;#5;
opcode=5'd14;#5;
opcode=5'd15;#5;
opcode=5'd16;#5;
opcode=5'd17;#5;

end

endmodule
