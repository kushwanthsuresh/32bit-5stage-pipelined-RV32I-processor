module controlunit (
    input  [31:0] inst,
    output reg [4:0] opcode,
    output reg reg_wr,
    output reg imm_en,
    output reg sign_ext_en,
    output reg imm_s_en,
    output reg mem_read_en
    //output reg mem_wr_en,
    //output reg mem_reg_en
);

reg [6:0] temp_opcode;
reg [2:0] funct3;
reg [6:0] funct7;
reg [6:0] ctr_imm;
always @(*) begin
        temp_opcode = inst[6:0];
    funct3 = inst[14:12];
    funct7 = inst[31:25];
    ctr_imm = inst[31:25];
        opcode = 5'd31;
    reg_wr   = 1'b0;
    sign_ext_en=1'b0;
    imm_s_en = 1'b0;
    imm_en = 1'b0;
    mem_read_en = 1'b0;
    case (temp_opcode)
        7'b0110011: begin   // R-type
            reg_wr = 1'b1;
	    imm_en = 1'b0;
	    sign_ext_en = 1'b0;
	    imm_s_en = 1'b0;
	    //mem_wr_en = 1'b0;
	    mem_read_en = 1'b0;
	    //mem_reg_en = 1'b0;
            case ({funct7, funct3})
                {7'b0000000,3'b000}: opcode = 5'd0;  // ADD
                {7'b0100000,3'b000}: opcode = 5'd1;  // SUB
                {7'b0000000,3'b001}: opcode = 5'd2;  // SLL
                {7'b0000000,3'b010}: opcode = 5'd3;  // SLT
                {7'b0000000,3'b011}: opcode = 5'd4;  // SLTU
                {7'b0000000,3'b100}: opcode = 5'd5;  // XOR
                {7'b0000000,3'b101}: opcode = 5'd6;  // SRL
                {7'b0100000,3'b101}: opcode = 5'd7;  // SRA
                {7'b0000000,3'b110}: opcode = 5'd8;  // OR
                {7'b0000000,3'b111}:opcode = 5'd9;  // AND

                {7'b0000001,3'b000}:opcode = 5'd10; // MUL
                {7'b0000001,3'b001}: opcode = 5'd11; // MULH
                {7'b0000001,3'b010}: opcode = 5'd12; // MULHSU
                {7'b0000001,3'b011}: opcode = 5'd13; // MULHU
                {7'b0000001,3'b100}: opcode = 5'd14; // DIV
                {7'b0000001,3'b101}: opcode = 5'd15; // DIVU
                {7'b0000001,3'b110}: opcode = 5'd16; // REM
                {7'b0000001,3'b111}: opcode = 5'd17; // REMU
	   	default: begin
		        opcode = 5'd31;
   			reg_wr   = 1'b0;
			imm_en = 1'b0;
			sign_ext_en=1'b0;
			imm_s_en = 1'b0;
	    		//mem_wr_en = 1'b0;
	   	 	mem_read_en = 1'b0;
	    		//mem_reg_en = 1'b0;
end
            endcase
        end
     	 7'b0010011: begin
	     reg_wr = 1'b1;
	     imm_en = 1'b1;
	     imm_s_en = 1'b0;
	     //mem_wr_en = 1'b0;
	     mem_read_en = 1'b0;
	     //mem_reg_en = 1'b0;
	     case (funct3)
		3'b000: begin
			opcode = 5'd18;
			sign_ext_en=1'b1;end//addi
		3'b001: opcode = 5'd19;//slli
		3'b010: begin
			opcode = 5'd20;
			sign_ext_en=1'b1;end//slti
		3'b011: opcode = 5'd21;//sltiu
		3'b100: opcode = 5'd22;//xori
		3'b101: begin
			if (ctr_imm == 7'd0) begin
			opcode = 5'd23;end//srli
			else if (ctr_imm == 7'b0100000) begin
			opcode = 5'd24;end//srai
			end
		3'b110: opcode = 5'd25;//ori
		3'b111: opcode = 5'd26;//andi
	   	default: begin
		        opcode = 5'd31;
   			reg_wr   = 1'b0;
			imm_en = 1'b0;end
	   	endcase
	  end
	7'b0000011: begin
	     case( funct3)
		3'b010: begin
		opcode = 5'd27;//lw
		sign_ext_en = 1'b1;
	        reg_wr = 1'b1;
	        imm_en = 1'b1;
	        imm_s_en = 1'b0;
	        mem_read_en = 1'b1;
		end
	     	default: begin
		opcode = 5'd31;
		reg_wr = 1'b0;
		imm_en = 1'b0;
		mem_read_en = 1'b0;
		imm_s_en = 1'b0;
		sign_ext_en = 1'b0;end
		endcase
		end
	7'b0100011: begin
	    //mem_wr_en = 1'b1;
	    //mem_reg_en = 1'b0;
	    case ( funct3) 
		3'b010: begin
		opcode = 5'd28;//sw
		sign_ext_en =1'd1;
		mem_read_en = 1'b0;
	        reg_wr = 1'b0;
	        imm_en = 1'b1;
	        imm_s_en = 1'b1;end
	    	default: begin
		opcode=5'd31;
		imm_en=1'b0;
		imm_s_en=1'b0;
		mem_read_en = 1'b0;
		reg_wr = 1'b0;
		sign_ext_en = 1'd0;
		//mem_wr_en=1'b0; 
		end
		endcase
		end
		
	   	default: begin
		        opcode = 5'd31;
   			reg_wr   = 1'b0;
			imm_en =1'b0;
			imm_s_en = 1'b0;
	    		//mem_wr_en = 1'b0;
	   	 	mem_read_en = 1'b0;
	    		//mem_reg_en = 1'b0;
			sign_ext_en = 1'b0;end
    endcase
end

endmodule

