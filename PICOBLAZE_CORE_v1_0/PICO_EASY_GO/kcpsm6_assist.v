
`timescale 1 ns / 1 ps

	module kcpsm6_assist #(
		parameter				CORE_CS = 1
	)
	(
        input   clk,
        input   rst,
        
        input   jtag_rst,
        input   jtag_en,  
        input   jtag_clk,
        input   [17:0]      jtag_din,
        output   [17:0]      jtag_dout,
        input   [11:0]      jtag_addr,
        input               jtag_we,
        
        input   [7:0]       in_port,
        output  [7:0]       out_port,
        output  [7:0]       port_id,
        output              write_strobe,
        output              k_write_strobe,
        output              read_strobe,
        input               interrupt,
        output              interrupt_ack
	);
(*mark_debug="true"*)    wire    [11:0]      address;
    wire    [17:0]      instruction;
    wire                bram_enable;
(*mark_debug="true"*)    wire                reset;
(*mark_debug="true"*)    reg                 interrupt_r = 0;
    always @(posedge clk) begin
        if (interrupt_ack) begin
            interrupt_r <= 0;
        end
        else begin
            interrupt_r <= interrupt_r | interrupt;
        end
    end
	kcpsm6 # ( 
		.hwbuild(8'h00),
		.interrupt_vector(12'h2FF),
		.scratch_pad_memory_size(64)
	) kcpsm6 (
		.        address (address),
		.    instruction (instruction),
		.    bram_enable (bram_enable),
		.        in_port (in_port),
		.       out_port (out_port),
		.        port_id (port_id),
		.   write_strobe (write_strobe),
		. k_write_strobe (k_write_strobe),
		.    read_strobe (read_strobe),
		.      interrupt (interrupt_r),
		.  interrupt_ack (interrupt_ack),
		.          sleep (1'b0),
		.          reset (reset || rst),
		.            clk (clk)
	);
	generate
		if (CORE_CS == 0) begin
        PICO_ROM_0 # ( 
            .C_FAMILY("7S"),
            .C_RAM_SIZE_KWORDS(1),
            .C_JTAG_LOADER_ENABLE(1)
        ) PICO_ROM_0 (
            .        address (address),
            .    instruction (instruction),
            .         enable (bram_enable),
            .            rdl (reset),
            .            clk (clk),
            .        rdl_bus (jtag_rst),
            .        jtag_en (jtag_en),
            .       jtag_clk (jtag_clk),
            .       jtag_din (jtag_din),
            .      jtag_dout (jtag_dout),
            .      jtag_addr (jtag_addr),
            .        jtag_we (jtag_we)
        );      
    end	   
		if (CORE_CS == 1) begin
			PICO_ROM_1 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_1 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
		if (CORE_CS == 2) begin
			PICO_ROM_2 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_2 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
		if (CORE_CS == 3) begin
			PICO_ROM_3 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_3 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
		if (CORE_CS == 4) begin
			PICO_ROM_4 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_4 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
		if (CORE_CS == 5) begin
			PICO_ROM_5 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_5 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
		if (CORE_CS == 6) begin
			PICO_ROM_6 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_6 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
		if (CORE_CS == 7) begin
			PICO_ROM_7 # ( 
				.C_FAMILY("7S"),
				.C_RAM_SIZE_KWORDS(1),
				.C_JTAG_LOADER_ENABLE(1)
			) PICO_ROM_7 (
				.        address (address),
				.    instruction (instruction),
				.         enable (bram_enable),
				.            rdl (reset),
				.            clk (clk),
				.        rdl_bus (jtag_rst),
				.        jtag_en (jtag_en),
				.       jtag_clk (jtag_clk),
				.       jtag_din (jtag_din),
				.      jtag_dout (jtag_dout),
				.      jtag_addr (jtag_addr),
				.        jtag_we (jtag_we)
			);  	
		end
	endgenerate
	
endmodule
