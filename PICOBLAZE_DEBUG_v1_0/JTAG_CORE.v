`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/21 10:26:15
// Design Name: 
// Module Name: JTAG_CORE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module JTAG_CORE#(
	parameter					C_NUM_PICOBLAZE = 8,
	parameter					BRAM_ADDRESS_WIDTH = 10
)(
	output						jtag_rst_0,
	output						jtag_rst_1,
	output						jtag_rst_2,
	output						jtag_rst_3,
	output						jtag_rst_4,
	output						jtag_rst_5,
	output						jtag_rst_6,
	output						jtag_rst_7,
	output						jtag_en_0,
	output						jtag_en_1,
	output						jtag_en_2,
	output						jtag_en_3,
	output						jtag_en_4,
	output						jtag_en_5,
	output						jtag_en_6,
	output						jtag_en_7,
	output						jtag_we_0,
	output						jtag_we_1,
	output						jtag_we_2,
	output						jtag_we_3,
	output						jtag_we_4,
	output						jtag_we_5,
	output						jtag_we_6,
	output						jtag_we_7,
	output						jtag_clk_0,
	output						jtag_clk_1,
	output						jtag_clk_2,
	output						jtag_clk_3,
	output						jtag_clk_4,
	output						jtag_clk_5,
	output						jtag_clk_6,
	output						jtag_clk_7,
	output	[17:0]				jtag_din_0,
	output	[17:0]				jtag_din_1,
	output	[17:0]				jtag_din_2,
	output	[17:0]				jtag_din_3,
	output	[17:0]				jtag_din_4,
	output	[17:0]				jtag_din_5,
	output	[17:0]				jtag_din_6,
	output	[17:0]				jtag_din_7,
	output	[9:0]				jtag_addr_0,
	output	[9:0]				jtag_addr_1,
	output	[9:0]				jtag_addr_2,
	output	[9:0]				jtag_addr_3,
	output	[9:0]				jtag_addr_4,
	output	[9:0]				jtag_addr_5,
	output	[9:0]				jtag_addr_6,
	output	[9:0]				jtag_addr_7,
	input	[17:0]				jtag_dout_0,
	input	[17:0]				jtag_dout_1,
	input	[17:0]				jtag_dout_2,
	input	[17:0]				jtag_dout_3,
	input	[17:0]				jtag_dout_4,
	input	[17:0]				jtag_dout_5,
	input	[17:0]				jtag_dout_6,
	input	[17:0]				jtag_dout_7
    );
///////////////////////////////////////////////////////////////////////////////////
	localparam					MAX_JTAG_CHAIN_CNT = 8;
	
	wire	[MAX_JTAG_CHAIN_CNT-1:0]		jtag_rst;
	wire	[MAX_JTAG_CHAIN_CNT-1:0]		jtag_en;
	wire	[17:0]		jtag_din;
	wire	[9:0]		jtag_addr;
	wire	[MAX_JTAG_CHAIN_CNT*18-1:0]		jtag_dout;
	wire	[MAX_JTAG_CHAIN_CNT-1:0]		jtag_rst_t;
	wire	[MAX_JTAG_CHAIN_CNT-1:0]		jtag_en_t;
	wire	[MAX_JTAG_CHAIN_CNT*18-1:0]		jtag_din_t;
	wire	[MAX_JTAG_CHAIN_CNT*10-1:0]		jtag_addr_t;
	wire	[MAX_JTAG_CHAIN_CNT*18-1:0]		jtag_dout_t;
	assign	jtag_rst_0 = jtag_rst_t[0];
	assign	jtag_rst_1 = jtag_rst_t[1];
	assign	jtag_rst_2 = jtag_rst_t[2];
	assign	jtag_rst_3 = jtag_rst_t[3];
	assign	jtag_rst_4 = jtag_rst_t[4];
	assign	jtag_rst_5 = jtag_rst_t[5];
	assign	jtag_rst_6 = jtag_rst_t[6];
	assign	jtag_rst_7 = jtag_rst_t[7];
	assign	jtag_en_0 = jtag_en_t[0];
	assign	jtag_en_1 = jtag_en_t[1];
	assign	jtag_en_2 = jtag_en_t[2];
	assign	jtag_en_3 = jtag_en_t[3];
	assign	jtag_en_4 = jtag_en_t[4];
	assign	jtag_en_5 = jtag_en_t[5];
	assign	jtag_en_6 = jtag_en_t[6];
	assign	jtag_en_7 = jtag_en_t[7];
	assign	jtag_we_0 = jtag_we;
	assign	jtag_we_1 = jtag_we;
	assign	jtag_we_2 = jtag_we;
	assign	jtag_we_3 = jtag_we;
	assign	jtag_we_4 = jtag_we;
	assign	jtag_we_5 = jtag_we;
	assign	jtag_we_6 = jtag_we;
	assign	jtag_we_7 = jtag_we;
	assign	jtag_clk_0 = jtag_clk;
	assign	jtag_clk_1 = jtag_clk;
	assign	jtag_clk_2 = jtag_clk;
	assign	jtag_clk_3 = jtag_clk;
	assign	jtag_clk_4 = jtag_clk;
	assign	jtag_clk_5 = jtag_clk;
	assign	jtag_clk_6 = jtag_clk;
	assign	jtag_clk_7 = jtag_clk;
	assign	jtag_din_0 = jtag_din;
	assign	jtag_din_1 = jtag_din;
	assign	jtag_din_2 = jtag_din;
	assign	jtag_din_3 = jtag_din;
	assign	jtag_din_4 = jtag_din;
	assign	jtag_din_5 = jtag_din;
	assign	jtag_din_6 = jtag_din;
	assign	jtag_din_7 = jtag_din;
	assign	jtag_addr_0 = jtag_addr;
	assign	jtag_addr_1 = jtag_addr;
	assign	jtag_addr_2 = jtag_addr;
	assign	jtag_addr_3 = jtag_addr;
	assign	jtag_addr_4 = jtag_addr;
	assign	jtag_addr_5 = jtag_addr;
	assign	jtag_addr_6 = jtag_addr;
	assign	jtag_addr_7 = jtag_addr;
	assign	jtag_dout_t = {jtag_dout_7,jtag_dout_6,jtag_dout_5,jtag_dout_4,jtag_dout_3,jtag_dout_2,jtag_dout_1,jtag_dout_0};
	
	genvar i;
	generate
		for (i=0;i<MAX_JTAG_CHAIN_CNT;i=i+1) begin
			assign	jtag_rst_t[i] = (i <= (C_NUM_PICOBLAZE-1)) ? jtag_rst[C_NUM_PICOBLAZE-1-i] : 1'b0;
			assign	jtag_en_t[i] = (i <= (C_NUM_PICOBLAZE-1)) ? jtag_en[C_NUM_PICOBLAZE-1-i] : 1'b0;
			assign	jtag_dout[i*18+:18] = (i <= (C_NUM_PICOBLAZE-1)) ? jtag_dout_t[(C_NUM_PICOBLAZE-1-i)*18+:18] : jtag_dout_t[0*18+:18];
		end
	endgenerate
    jtag_loader_6#(
        .C_FAMILY("7S"),
        .C_NUM_PICOBLAZE(C_NUM_PICOBLAZE),
        .C_JTAG_LOADER_ENABLE(1),
        .C_BRAM_MAX_ADDR_WIDTH(BRAM_ADDRESS_WIDTH),
        .C_ADDR_WIDTH_0(BRAM_ADDRESS_WIDTH)
    )jtag_loader_6_inst(
        .picoblaze_reset(jtag_rst),
        .jtag_en(jtag_en),
        .jtag_din(jtag_din),
        .jtag_addr(jtag_addr),
        .jtag_clk(jtag_clk),
        .jtag_we(jtag_we),
        .jtag_dout_0(jtag_dout[0*18+:18]),
        .jtag_dout_1(jtag_dout[1*18+:18]),
        .jtag_dout_2(jtag_dout[2*18+:18]),
        .jtag_dout_3(jtag_dout[3*18+:18]),
        .jtag_dout_4(jtag_dout[4*18+:18]),
        .jtag_dout_5(jtag_dout[5*18+:18]),
        .jtag_dout_6(jtag_dout[6*18+:18]),
        .jtag_dout_7(jtag_dout[7*18+:18])
    );
	
endmodule
