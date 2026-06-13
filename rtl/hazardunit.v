module hazardunit ( 	input rst,reg_wr_M, reg_wr_W, mem_read_en_E,
			input [4:0] rd_M, rd_W, rs1_E, rs2_E, rs1_D, rs2_D, rd_E,
			output reg [1:0] ForwardAE, ForwardBE,
			output stallF, stallD, flushE);

always @(*) begin
        if (!rst) begin
	    ForwardAE = 2'b00; end
        else if (((rs1_E == rd_M) && reg_wr_M) && (rs1_E != 5'b0))
            ForwardAE = 2'b10; 
        else if (((rs1_E == rd_W) && reg_wr_W) && (rs1_E != 5'b0))
            ForwardAE = 2'b01; 
        else
            ForwardAE = 2'b00; 
    end

always @(*) begin
	if (!rst) begin
	    ForwardBE = 2'b00; end
        else if (((rs2_E == rd_M) && reg_wr_M) && (rs2_E != 5'b0))
            ForwardBE = 2'b10; 
        else if (((rs2_E == rd_W) && reg_wr_W) && (rs2_E != 5'b0))
            ForwardBE = 2'b01; 
        else
            ForwardBE = 2'b00; 
    end
wire lw_stall;
assign lw_stall = (rst) ? (mem_read_en_E && ((rs1_D == rd_E) || (rs2_D == rd_E))) : 1'b0;


assign stallF = lw_stall;
assign stallD = lw_stall;
assign flushE = lw_stall;

endmodule

	
