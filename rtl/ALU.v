module ALU ( input [31:0] rs1_d,
	     input [31:0] rs2_d,
	     input [4:0] opcode,
	     output reg [31:0] rd_d,
	     output reg Z,
	     output reg C,
	     output reg N,
	     output reg OV);
reg [32:0] temp;
reg [63:0] temp_mul;
always @(*) begin
rd_d=32'd0;
Z=0;
C=0;
N=0;
OV=0;
case(opcode)
5'b00000: 	begin//add
		temp = {1'b0, rs1_d} + {1'b0, rs2_d};
        	rd_d = temp[31:0];
        	C    = temp[32];
        	OV = (rs1_d[31] == rs2_d[31]) && (rd_d[31] != rs1_d[31]);
		end
5'b00001: 	begin	//sub
        	temp = {1'b0, rs1_d} - {1'b0, rs2_d};
        	rd_d = temp[31:0];
	        C = ~temp[32];
        	OV = (rs1_d[31] != rs2_d[31]) && (rd_d[31] != rs1_d[31]);
		end
5'b00010: 	rd_d=rs1_d<<(rs2_d[4:0]);
5'b00011:	rd_d=($signed(rs1_d)<$signed(rs2_d)?32'd1:32'd0);//slt
5'b00100:	rd_d=(rs1_d<rs2_d)?32'd1:32'd0;//sltu
5'b00101:	rd_d=rs1_d^rs2_d;//xor
5'b00110:	rd_d=rs1_d>>rs2_d[4:0];//srl
5'b00111:	rd_d=$signed(rs1_d)>>>rs2_d[4:0];//sra
5'b01000:	rd_d=rs1_d|rs2_d;//or
5'b01001:	rd_d=rs1_d&rs2_d;//and
5'b01010:	begin//mul
		temp_mul=rs1_d * rs2_d; 
		rd_d = temp_mul[31:0];
		end
5'b01011:	begin
		temp_mul=$signed(rs1_d) * $signed(rs2_d);
		rd_d=temp_mul[63:32];
		end // MULH
5'b01100:	begin
		temp_mul=($signed(rs1_d) * rs2_d);
		rd_d=temp_mul[63:32];
		end//MULHSU
5'b01101:	begin
		temp_mul=(rs1_d * rs2_d);
		rd_d=temp_mul[63:32]; 
		end// MULHU
5'b01110:	rd_d = (rs2_d != 32'd0) ? $signed(rs1_d) / $signed(rs2_d) : 32'd0; // DIV
5'b01111:	rd_d = (rs2_d == 32'd0) ? 32'd0: rs1_d / rs2_d ; // DIVU
5'b10000:	rd_d = (rs2_d != 32'd0) ? $signed(rs1_d) % $signed(rs2_d) : 32'd0; // REM
5'b10001:	rd_d = (rs2_d == 32'd0) ? 32'd0 : rs1_d % rs2_d; // REMU
5'd18:		begin
		temp={1'b0,rs1_d}+{1'b0,rs2_d};
		rd_d=temp[31:0];
		C=temp[32];
		OV=(rs1_d[31] == rs2_d[31]) && (rd_d[31]!=rs1_d[31]);
		end//addi
5'd19:		rd_d=rs1_d<<(rs2_d[4:0]);//slli
5'd20:		rd_d=($signed(rs1_d) > $signed(rs2_d) ? 32'd0:32'd1);//slti
5'd21:		rd_d=(rs1_d > rs2_d) ? 32'd0:32'd1;//sltiu
5'd22: 		rd_d=rs1_d^rs2_d;//xori
5'd23:		rd_d=rs1_d>>rs2_d[4:0];//srli
5'd24:		rd_d=$signed(rs1_d)>>>rs2_d[4:0];//sra
5'd25:		rd_d=rs1_d|rs2_d;//ori
5'd26:		rd_d=rs1_d&rs2_d;//andi
5'd27:		rd_d=rs1_d+rs2_d;//lw
5'd28:		rd_d=rs1_d+rs2_d;//sw

default: rd_d = 32'd0;
endcase
        Z     = (rd_d == 32'd0);
        N = rd_d[31];
    end
endmodule




		

  
