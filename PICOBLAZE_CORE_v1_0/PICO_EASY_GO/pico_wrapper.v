`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/15 14:22:43
// Design Name: 
// Module Name: pico_assist_wrapper
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


module pico_wrapper
#(
    parameter                                                                       GPO_PORT_CNT	=16,
    parameter                                                                       GPI_PORT_CNT	=16,
    parameter                                                                       PICO_IO_WIDTH	=8,
	parameter																		CORE_CS			= 1
)
(
    input                                                                           clk,
    input                                                                           rst,

    input                                                                           jtag_rst,
    input                                                                           jtag_en,  
    input                                                                           jtag_clk,
    input   [17:0]                                                                  jtag_din,
    output  [17:0]                                                                  jtag_dout,
    input   [11:0]                                                                  jtag_addr,
    input                                                                           jtag_we,
    
    input                                                                           interrupt,
    output                                                                          interrupt_ack,
    output reg  [GPO_PORT_CNT*PICO_IO_WIDTH-1:0]                                    gpo,
    output reg  [GPO_PORT_CNT-1:0]                                                  gpo_wr_strobe,
    input       [GPI_PORT_CNT*PICO_IO_WIDTH-1:0]                                    gpi,
    output wire [GPI_PORT_CNT-1:0]                                                  gpi_rd_strobe
);
    
///////////////////////////////////////////////
///PICOBLAZE CORE                            //
///////////////////////////////////////////////
    (*mark_debug="true"*)wire  [PICO_IO_WIDTH-1:0]                                  in_port;
    (*mark_debug="true"*)wire  [PICO_IO_WIDTH-1:0]                                  out_port;
    (*mark_debug="true"*)wire  [PICO_IO_WIDTH-1:0]                                  port_id;
    (*mark_debug="true"*)wire                                                       write_strobe;
    (*mark_debug="true"*)wire                                                       read_strobe;

    kcpsm6_assist#(
		.CORE_CS																	(CORE_CS)
	) kcpsm6_sub (
        .clk                                                                        (clk),
        .rst                                                                        (rst),
        .                            jtag_rst (jtag_rst),
        .                             jtag_en (jtag_en),
        .                            jtag_clk (jtag_clk),
        .                            jtag_din (jtag_din),
        .                           jtag_dout (jtag_dout),
        .                           jtag_addr (jtag_addr),
        .                             jtag_we (jtag_we),
        .in_port                                                                    (in_port),
        .out_port                                                                   (out_port),
        .port_id                                                                    (port_id),
        .write_strobe                                                               (write_strobe),
        .k_write_strobe                                                             (),
        .read_strobe                                                                (read_strobe),
        .interrupt                                                                  (interrupt),
        .interrupt_ack                                                              (interrupt_ack)
	);
    
///////////////////////////////////////////////
//GPIO CONTROL                               //
///////////////////////////////////////////////

genvar i;
generate
    for (i=0;i<(GPI_PORT_CNT);i=i+1) begin : DATA_IN_LOOP
        assign in_port = (port_id == i) ? gpi[i*PICO_IO_WIDTH+:PICO_IO_WIDTH] : 8'dz;
        assign gpi_rd_strobe[i] =  (port_id == i) ? read_strobe : 1'b0;
    end
endgenerate
genvar j;
generate
    for (j=0;j<(GPO_PORT_CNT);j=j+1) begin : DATA_OUT_LOOP
        always @(posedge clk) begin
            if (rst) begin
                gpo[j*PICO_IO_WIDTH+:PICO_IO_WIDTH] <= 0;
                gpo_wr_strobe[j] <= 0;
            end
            else begin
                if (port_id == j && write_strobe) begin
                    gpo[j*PICO_IO_WIDTH+:PICO_IO_WIDTH] <= out_port;
                    gpo_wr_strobe[j] <= 1;
                end
                else begin
                    gpo[j*PICO_IO_WIDTH+:PICO_IO_WIDTH] <= gpo[j*PICO_IO_WIDTH+:PICO_IO_WIDTH];
                    gpo_wr_strobe[j] <= 0;
                end
            end
        end
    end
endgenerate 
 
endmodule
