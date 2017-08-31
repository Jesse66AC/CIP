--
-------------------------------------------------------------------------------------------
-- Copyright © 2010-2014, Xilinx, Inc.
-- This file contains confidential and proprietary information of Xilinx, Inc. and is
-- protected under U.S. and international copyright and other intellectual property laws.
-------------------------------------------------------------------------------------------
--
-- Disclaimer:
-- This disclaimer is not a license and does not grant any rights to the materials
-- distributed herewith. Except as otherwise provided in a valid license issued to
-- you by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE
-- MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY
-- DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
-- INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,
-- OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable
-- (whether in contract or tort, including negligence, or under any other theory
-- of liability) for any loss or damage of any kind or nature related to, arising
-- under or in connection with these materials, including for any direct, or any
-- indirect, special, incidental, or consequential loss or damage (including loss
-- of data, profits, goodwill, or any type of loss or damage suffered as a result
-- of any action brought by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-safe, or for use in any
-- application requiring fail-safe performance, such as life-support or safety
-- devices or systems, Class III medical devices, nuclear facilities, applications
-- related to the deployment of airbags, or any other applications that could lead
-- to death, personal injury, or severe property or environmental damage
-- (individually and collectively, "Critical Applications"). Customer assumes the
-- sole risk and liability of any use of Xilinx products in Critical Applications,
-- subject only to applicable laws and regulations governing limitations on product
-- liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
--
-------------------------------------------------------------------------------------------
--

ROM_form.vhd

Template for a KCPSM6 program memory. This template is primarily for use during code 
development including generic parameters for the convenient selection of device family,
program memory size and the ability to include the JTAG Loader hardware for rapid 
software development.  

Kris Chaplin and Ken Chapman (Xilinx Ltd)
17th September 2010 - First Release
  4th February 2011 - Correction to definition of 'we_b' in V6/1K/JTAG instance.
     3rd March 2011 - Minor adjustments to comments only.
   16th August 2011 - Additions and adjustments for support of 7-Series in ISE v13.2.
                      Simplification of JTAG Loader definition. 
 23rd November 2012 - 4K program for Spartan-6.
    14th March 2013 - Unused address inputs on Virtex-6 and 7-Series BRAMs connected 
                      High to reflect descriptions in UG363 and UG473.
      2nd June 2014 - Template for use with Vivado 2014.1 (and later).
                      Removal of Spartan-6 and Virtex-6 memories not supported by Vivado.
                      Addition of UltraScale memories which are only supported by Vivado.
                      Additional attributes for 7-Series BRAMs to reflect Vivado library.

This is a VHDL template file for the KCPSM6 assembler.

This VHDL file is not valid as input directly into a synthesis or a simulation tool.
The assembler will read this template and insert the information required to complete
the definition of program ROM and write it out to a new '.vhd' file that is ready for 
synthesis and simulation.

This template can be modified to define alternative memory definitions. However, you are 
responsible for ensuring the template is correct as the assembler does not perform any 
checking of the VHDL.

The assembler identifies all text enclosed by {} characters, and replaces these
character strings. All templates should include these {} character strings for 
the assembler to work correctly. 


The next line is used to determine where the template actually starts.
{begin template}
--
-------------------------------------------------------------------------------------------
-- Copyright © 2010-2014, Xilinx, Inc.
-- This file contains confidential and proprietary information of Xilinx, Inc. and is
-- protected under U.S. and international copyright and other intellectual property laws.
-------------------------------------------------------------------------------------------
--
-- Disclaimer:
-- This disclaimer is not a license and does not grant any rights to the materials
-- distributed herewith. Except as otherwise provided in a valid license issued to
-- you by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE
-- MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY
-- DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
-- INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,
-- OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable
-- (whether in contract or tort, including negligence, or under any other theory
-- of liability) for any loss or damage of any kind or nature related to, arising
-- under or in connection with these materials, including for any direct, or any
-- indirect, special, incidental, or consequential loss or damage (including loss
-- of data, profits, goodwill, or any type of loss or damage suffered as a result
-- of any action brought by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-safe, or for use in any
-- application requiring fail-safe performance, such as life-support or safety
-- devices or systems, Class III medical devices, nuclear facilities, applications
-- related to the deployment of airbags, or any other applications that could lead
-- to death, personal injury, or severe property or environmental damage
-- (individually and collectively, "Critical Applications"). Customer assumes the
-- sole risk and liability of any use of Xilinx products in Critical Applications,
-- subject only to applicable laws and regulations governing limitations on product
-- liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
--
-------------------------------------------------------------------------------------------
--
--
-- Definition of a program memory for KCPSM6 including generic parameters for the 
-- convenient selection of device family, program memory size and the ability to include 
-- the JTAG Loader hardware for rapid software development.
--
-- This file is primarily for use during code development and it is recommended that the 
-- appropriate simplified program memory definition be used in a final production design. 
--
--    Generic                  Values             Comments
--    Parameter                Supported
--  
--    C_FAMILY                 "7S"               7-Series device 
--                                                  (Artix-7, Kintex-7, Virtex-7 or Zynq)
--                             "US"               UltraScale device
--                                                  (Kintex UltraScale and Virtex UltraScale)
--
--    C_RAM_SIZE_KWORDS        1, 2 or 4          Size of program memory in K-instructions
--
--    C_JTAG_LOADER_ENABLE     0 or 1             Set to '1' to include JTAG Loader
--
-- Notes
--
-- If your design contains MULTIPLE KCPSM6 instances then only one should have the 
-- JTAG Loader enabled at a time (i.e. make sure that C_JTAG_LOADER_ENABLE is only set to 
-- '1' on one instance of the program memory). Advanced users may be interested to know 
-- that it is possible to connect JTAG Loader to multiple memories and then to use the 
-- JTAG Loader utility to specify which memory contents are to be modified. However, 
-- this scheme does require some effort to set up and the additional connectivity of the 
-- multiple BRAMs can impact the placement, routing and performance of the complete 
-- design. Please contact the author at Xilinx for more detailed information. 
--
-- Regardless of the size of program memory specified by C_RAM_SIZE_KWORDS, the complete 
-- 12-bit address bus is connected to KCPSM6. This enables the generic to be modified 
-- without requiring changes to the fundamental hardware definition. However, when the 
-- program memory is 1K then only the lower 10-bits of the address are actually used and 
-- the valid address range is 000 to 3FF hex. Likewise, for a 2K program only the lower 
-- 11-bits of the address are actually used and the valid address range is 000 to 7FF hex.
--
-- Programs are stored in Block Memory (BRAM) and the number of BRAM used depends on the 
-- size of the program and the device family. 
--
-- In any 7-Series or UltraScale device a BRAM is capable of holding 2K instructions so 
-- obviously a 2K program requires only a single BRAM. Each BRAM can also be divided into 
-- 2 smaller memories supporting programs of 1K in half of a 36k-bit BRAM (generally 
-- reported as being an 18k-bit BRAM). For a program of 4K instructions, 2 BRAMs are used.
--
--
-- Program defined by '{psmname}.psm'.
--
-- Generated by KCPSM6 Assembler: {timestamp}. 
--
-- Assembler used ROM_form template: ROM_form_JTAGLoader_Vivado_2June14.vhd
--
-- Standard IEEE libraries
--
--
package jtag_loader_pkg is
 function addr_width_calc (size_in_k: integer) return integer;
end jtag_loader_pkg;
--
package body jtag_loader_pkg is
  function addr_width_calc (size_in_k: integer) return integer is
   begin
    if (size_in_k = 1) then return 10;
      elsif (size_in_k = 2) then return 11;
      elsif (size_in_k = 4) then return 12;
      else report "Invalid BlockRAM size. Please set to 1, 2 or 4 K words." severity FAILURE;
    end if;
    return 0;
  end function addr_width_calc;
end package body;
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.jtag_loader_pkg.ALL;
--
-- The Unisim Library is used to define Xilinx primitives. It is also used during
-- simulation. The source can be viewed at %XILINX%\vhdl\src\unisims\unisim_VCOMP.vhd
--  
library unisim;
use unisim.vcomponents.all;
--
--
entity {name} is
  generic(             C_FAMILY : string := "7S"; 
              C_RAM_SIZE_KWORDS : integer := 2;
           C_JTAG_LOADER_ENABLE : integer := 0);
  Port (      address : in std_logic_vector(11 downto 0);
          instruction : out std_logic_vector(17 downto 0);
               enable : in std_logic;
                  rdl : out std_logic;                    
                  clk : in std_logic;
              rdl_bus : in std_logic;
              jtag_en : in std_logic;   
             jtag_clk : in std_logic;
             jtag_din : in std_logic_vector(17 downto 0);
            jtag_dout : out std_logic_vector(17 downto 0);
            jtag_addr : in std_logic_vector(11 downto 0);
              jtag_we : in std_logic
                  );
  end {name};
--
architecture low_level_definition of {name} is
--
signal       address_a : std_logic_vector(15 downto 0);
signal       data_in_a : std_logic_vector(35 downto 0);
signal      data_out_a : std_logic_vector(35 downto 0);
signal    data_out_a_l : std_logic_vector(35 downto 0);
signal    data_out_a_h : std_logic_vector(35 downto 0);
signal       address_b : std_logic_vector(15 downto 0);
signal       data_in_b : std_logic_vector(35 downto 0);
signal     data_in_b_l : std_logic_vector(35 downto 0);
signal      data_out_b : std_logic_vector(35 downto 0);
signal    data_out_b_l : std_logic_vector(35 downto 0);
signal     data_in_b_h : std_logic_vector(35 downto 0);
signal    data_out_b_h : std_logic_vector(35 downto 0);
signal        enable_b : std_logic;
signal           clk_b : std_logic;
signal            we_b : std_logic_vector(7 downto 0);
-- 
--signal       jtag_addr : std_logic_vector(11 downto 0);
--signal         jtag_we : std_logic;
signal       jtag_we_l : std_logic;
signal       jtag_we_h : std_logic;
--signal        jtag_clk : std_logic;
--signal        jtag_din : std_logic_vector(17 downto 0);
--signal       jtag_dout : std_logic_vector(17 downto 0);
signal     jtag_dout_1 : std_logic_vector(17 downto 0);
--signal         jtag_en : std_logic_vector(0 downto 0);
-- 
signal picoblaze_reset : std_logic_vector(0 downto 0);
--signal         rdl_bus : std_logic_vector(0 downto 0);
--
constant BRAM_ADDRESS_WIDTH  : integer := addr_width_calc(C_RAM_SIZE_KWORDS);
--

--
begin
  --
  --  
  ram_1k_generate : if (C_RAM_SIZE_KWORDS = 1) generate
    --
    akv7 : if (C_FAMILY = "7S") generate
      --
      address_a(13 downto 0) <= address(9 downto 0) & "1111";
      instruction <= data_out_a(17 downto 0);
      data_in_a(17 downto 0) <= "0000000000000000" & address(11 downto 10);
      jtag_dout <= data_out_b(17 downto 0);
      --
      no_loader : if (C_JTAG_LOADER_ENABLE = 0) generate
        data_in_b(17 downto 0) <= data_out_b(17 downto 0);
        address_b(13 downto 0) <= "11111111111111";
        we_b(3 downto 0) <= "0000";
        enable_b <= '0';
        rdl <= '0';
        clk_b <= '0';
      end generate no_loader;
      --
      loader : if (C_JTAG_LOADER_ENABLE = 1) generate
        data_in_b(17 downto 0) <= jtag_din(17 downto 0);
        address_b(13 downto 0) <= jtag_addr(9 downto 0) & "1111";
        we_b(3 downto 0) <= jtag_we & jtag_we & jtag_we & jtag_we;
        enable_b <= jtag_en;
        rdl <= rdl_bus;
        clk_b <= jtag_clk;
      end generate loader;
      -- 
      kcpsm6_rom: RAMB18E1
      generic map ( READ_WIDTH_A => 18,
                    WRITE_WIDTH_A => 18,
                    DOA_REG => 0,
                    INIT_A => "000000000000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => "000000000000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 18,
                    WRITE_WIDTH_B => 18,
                    DOB_REG => 0,
                    INIT_B => "000000000000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => "000000000000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    RAM_MODE => "TDP",
                    RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
                    SIM_DEVICE => "7SERIES",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{INIT_00}",
                    INIT_01 => X"{INIT_01}",
                    INIT_02 => X"{INIT_02}",
                    INIT_03 => X"{INIT_03}",
                    INIT_04 => X"{INIT_04}",
                    INIT_05 => X"{INIT_05}",
                    INIT_06 => X"{INIT_06}",
                    INIT_07 => X"{INIT_07}",
                    INIT_08 => X"{INIT_08}",
                    INIT_09 => X"{INIT_09}",
                    INIT_0A => X"{INIT_0A}",
                    INIT_0B => X"{INIT_0B}",
                    INIT_0C => X"{INIT_0C}",
                    INIT_0D => X"{INIT_0D}",
                    INIT_0E => X"{INIT_0E}",
                    INIT_0F => X"{INIT_0F}",
                    INIT_10 => X"{INIT_10}",
                    INIT_11 => X"{INIT_11}",
                    INIT_12 => X"{INIT_12}",
                    INIT_13 => X"{INIT_13}",
                    INIT_14 => X"{INIT_14}",
                    INIT_15 => X"{INIT_15}",
                    INIT_16 => X"{INIT_16}",
                    INIT_17 => X"{INIT_17}",
                    INIT_18 => X"{INIT_18}",
                    INIT_19 => X"{INIT_19}",
                    INIT_1A => X"{INIT_1A}",
                    INIT_1B => X"{INIT_1B}",
                    INIT_1C => X"{INIT_1C}",
                    INIT_1D => X"{INIT_1D}",
                    INIT_1E => X"{INIT_1E}",
                    INIT_1F => X"{INIT_1F}",
                    INIT_20 => X"{INIT_20}",
                    INIT_21 => X"{INIT_21}",
                    INIT_22 => X"{INIT_22}",
                    INIT_23 => X"{INIT_23}",
                    INIT_24 => X"{INIT_24}",
                    INIT_25 => X"{INIT_25}",
                    INIT_26 => X"{INIT_26}",
                    INIT_27 => X"{INIT_27}",
                    INIT_28 => X"{INIT_28}",
                    INIT_29 => X"{INIT_29}",
                    INIT_2A => X"{INIT_2A}",
                    INIT_2B => X"{INIT_2B}",
                    INIT_2C => X"{INIT_2C}",
                    INIT_2D => X"{INIT_2D}",
                    INIT_2E => X"{INIT_2E}",
                    INIT_2F => X"{INIT_2F}",
                    INIT_30 => X"{INIT_30}",
                    INIT_31 => X"{INIT_31}",
                    INIT_32 => X"{INIT_32}",
                    INIT_33 => X"{INIT_33}",
                    INIT_34 => X"{INIT_34}",
                    INIT_35 => X"{INIT_35}",
                    INIT_36 => X"{INIT_36}",
                    INIT_37 => X"{INIT_37}",
                    INIT_38 => X"{INIT_38}",
                    INIT_39 => X"{INIT_39}",
                    INIT_3A => X"{INIT_3A}",
                    INIT_3B => X"{INIT_3B}",
                    INIT_3C => X"{INIT_3C}",
                    INIT_3D => X"{INIT_3D}",
                    INIT_3E => X"{INIT_3E}",
                    INIT_3F => X"{INIT_3F}",
                   INITP_00 => X"{INITP_00}",
                   INITP_01 => X"{INITP_01}",
                   INITP_02 => X"{INITP_02}",
                   INITP_03 => X"{INITP_03}",
                   INITP_04 => X"{INITP_04}",
                   INITP_05 => X"{INITP_05}",
                   INITP_06 => X"{INITP_06}",
                   INITP_07 => X"{INITP_07}")
      port map(   ADDRARDADDR => address_a(13 downto 0),
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                        DOADO => data_out_a(15 downto 0),
                      DOPADOP => data_out_a(17 downto 16), 
                        DIADI => data_in_a(15 downto 0),
                      DIPADIP => data_in_a(17 downto 16), 
                          WEA => "00",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b(13 downto 0),
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                        DOBDO => data_out_b(15 downto 0),
                      DOPBDOP => data_out_b(17 downto 16), 
                        DIBDI => data_in_b(15 downto 0),
                      DIPBDIP => data_in_b(17 downto 16), 
                        WEBWE => we_b(3 downto 0),
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0');
      --
    end generate akv7;
    --
    --
    us : if (C_FAMILY = "US") generate
      --
      address_a(13 downto 0) <= address(9 downto 0) & "1111";
      instruction <= data_out_a(17 downto 0);
      data_in_a(17 downto 0) <= "0000000000000000" & address(11 downto 10);
      jtag_dout <= data_out_b(17 downto 0);
      --
      no_loader : if (C_JTAG_LOADER_ENABLE = 0) generate
        data_in_b(17 downto 0) <= data_out_b(17 downto 0);
        address_b(13 downto 0) <= "11111111111111";
        we_b(3 downto 0) <= "0000";
        enable_b <= '0';
        rdl <= '0';
        clk_b <= '0';
      end generate no_loader;
      --
      loader : if (C_JTAG_LOADER_ENABLE = 1) generate
        data_in_b(17 downto 0) <= jtag_din(17 downto 0);
        address_b(13 downto 0) <= jtag_addr(9 downto 0) & "1111";
        we_b(3 downto 0) <= jtag_we & jtag_we & jtag_we & jtag_we;
        enable_b <= jtag_en;
        rdl <= rdl_bus;
        clk_b <= jtag_clk;
      end generate loader;
      -- 
      kcpsm6_rom: RAMB18E2
      generic map ( READ_WIDTH_A => 18,
                    WRITE_WIDTH_A => 18,
                    DOA_REG => 0,
                    INIT_A => "000000000000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => "000000000000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 18,
                    WRITE_WIDTH_B => 18,
                    DOB_REG => 0,
                    INIT_B => "000000000000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => "000000000000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    CASCADE_ORDER_A => "NONE",
                    CASCADE_ORDER_B => "NONE",
                    CLOCK_DOMAINS => "INDEPENDENT",
                    ENADDRENA => "FALSE",
                    ENADDRENB => "FALSE",
                    RDADDRCHANGEA => "FALSE",
                    RDADDRCHANGEB => "FALSE",
                    SLEEP_ASYNC => "FALSE",
                    INIT_00 => X"{INIT_00}",
                    INIT_01 => X"{INIT_01}",
                    INIT_02 => X"{INIT_02}",
                    INIT_03 => X"{INIT_03}",
                    INIT_04 => X"{INIT_04}",
                    INIT_05 => X"{INIT_05}",
                    INIT_06 => X"{INIT_06}",
                    INIT_07 => X"{INIT_07}",
                    INIT_08 => X"{INIT_08}",
                    INIT_09 => X"{INIT_09}",
                    INIT_0A => X"{INIT_0A}",
                    INIT_0B => X"{INIT_0B}",
                    INIT_0C => X"{INIT_0C}",
                    INIT_0D => X"{INIT_0D}",
                    INIT_0E => X"{INIT_0E}",
                    INIT_0F => X"{INIT_0F}",
                    INIT_10 => X"{INIT_10}",
                    INIT_11 => X"{INIT_11}",
                    INIT_12 => X"{INIT_12}",
                    INIT_13 => X"{INIT_13}",
                    INIT_14 => X"{INIT_14}",
                    INIT_15 => X"{INIT_15}",
                    INIT_16 => X"{INIT_16}",
                    INIT_17 => X"{INIT_17}",
                    INIT_18 => X"{INIT_18}",
                    INIT_19 => X"{INIT_19}",
                    INIT_1A => X"{INIT_1A}",
                    INIT_1B => X"{INIT_1B}",
                    INIT_1C => X"{INIT_1C}",
                    INIT_1D => X"{INIT_1D}",
                    INIT_1E => X"{INIT_1E}",
                    INIT_1F => X"{INIT_1F}",
                    INIT_20 => X"{INIT_20}",
                    INIT_21 => X"{INIT_21}",
                    INIT_22 => X"{INIT_22}",
                    INIT_23 => X"{INIT_23}",
                    INIT_24 => X"{INIT_24}",
                    INIT_25 => X"{INIT_25}",
                    INIT_26 => X"{INIT_26}",
                    INIT_27 => X"{INIT_27}",
                    INIT_28 => X"{INIT_28}",
                    INIT_29 => X"{INIT_29}",
                    INIT_2A => X"{INIT_2A}",
                    INIT_2B => X"{INIT_2B}",
                    INIT_2C => X"{INIT_2C}",
                    INIT_2D => X"{INIT_2D}",
                    INIT_2E => X"{INIT_2E}",
                    INIT_2F => X"{INIT_2F}",
                    INIT_30 => X"{INIT_30}",
                    INIT_31 => X"{INIT_31}",
                    INIT_32 => X"{INIT_32}",
                    INIT_33 => X"{INIT_33}",
                    INIT_34 => X"{INIT_34}",
                    INIT_35 => X"{INIT_35}",
                    INIT_36 => X"{INIT_36}",
                    INIT_37 => X"{INIT_37}",
                    INIT_38 => X"{INIT_38}",
                    INIT_39 => X"{INIT_39}",
                    INIT_3A => X"{INIT_3A}",
                    INIT_3B => X"{INIT_3B}",
                    INIT_3C => X"{INIT_3C}",
                    INIT_3D => X"{INIT_3D}",
                    INIT_3E => X"{INIT_3E}",
                    INIT_3F => X"{INIT_3F}",
                   INITP_00 => X"{INITP_00}",
                   INITP_01 => X"{INITP_01}",
                   INITP_02 => X"{INITP_02}",
                   INITP_03 => X"{INITP_03}",
                   INITP_04 => X"{INITP_04}",
                   INITP_05 => X"{INITP_05}",
                   INITP_06 => X"{INITP_06}",
                   INITP_07 => X"{INITP_07}")
      port map(   ADDRARDADDR => address_a(13 downto 0),
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                    DOUTADOUT => data_out_a(15 downto 0),
                  DOUTPADOUTP => data_out_a(17 downto 16), 
                      DINADIN => data_in_a(15 downto 0),
                    DINPADINP => data_in_a(17 downto 16), 
                          WEA => "00",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b(13 downto 0),
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                    DOUTBDOUT => data_out_b(15 downto 0),
                  DOUTPBDOUTP => data_out_b(17 downto 16), 
                      DINBDIN => data_in_b(15 downto 0),
                    DINPBDINP => data_in_b(17 downto 16), 
                        WEBWE => we_b(3 downto 0),
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                      ADDRENA => '1',
                      ADDRENB => '1',
                    CASDIMUXA => '0',
                    CASDIMUXB => '0',
                      CASDINA => "0000000000000000",  
                      CASDINB => "0000000000000000",
                     CASDINPA => "00",
                     CASDINPB => "00",
                    CASDOMUXA => '0',
                    CASDOMUXB => '0',
                 CASDOMUXEN_A => '1',
                 CASDOMUXEN_B => '1',
                 CASOREGIMUXA => '0',
                 CASOREGIMUXB => '0',
              CASOREGIMUXEN_A => '0',
              CASOREGIMUXEN_B => '0',
                        SLEEP => '0');
      --
    end generate us;
    --
  end generate ram_1k_generate;
  --
  --
  --
  ram_2k_generate : if (C_RAM_SIZE_KWORDS = 2) generate
    --
    --
    akv7 : if (C_FAMILY = "7S") generate
      --
      address_a <= '1' & address(10 downto 0) & "1111";
      instruction <= data_out_a(33 downto 32) & data_out_a(15 downto 0);
      data_in_a <= "00000000000000000000000000000000000" & address(11);
      jtag_dout <= data_out_b(33 downto 32) & data_out_b(15 downto 0);
      --
      no_loader : if (C_JTAG_LOADER_ENABLE = 0) generate
        data_in_b <= "00" & data_out_b(33 downto 32) & "0000000000000000" & data_out_b(15 downto 0);
        address_b <= "1111111111111111";
        we_b <= "00000000";
        enable_b <= '0';
        rdl <= '0';
        clk_b <= '0';
      end generate no_loader;
      --
      loader : if (C_JTAG_LOADER_ENABLE = 1) generate
        data_in_b <= "00" & jtag_din(17 downto 16) & "0000000000000000" & jtag_din(15 downto 0);
        address_b <= '1' & jtag_addr(10 downto 0) & "1111";
        we_b <= jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we;
        enable_b <= jtag_en;
        rdl <= rdl_bus;
        clk_b <= jtag_clk;
      end generate loader;
      --
      kcpsm6_rom: RAMB36E1
      generic map ( READ_WIDTH_A => 18,
                    WRITE_WIDTH_A => 18,
                    DOA_REG => 0,
                    INIT_A => X"000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => X"000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 18,
                    WRITE_WIDTH_B => 18,
                    DOB_REG => 0,
                    INIT_B => X"000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => X"000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    RAM_MODE => "TDP",
                    RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
                    EN_ECC_READ => FALSE,
                    EN_ECC_WRITE => FALSE,
                    RAM_EXTENSION_A => "NONE",
                    RAM_EXTENSION_B => "NONE",
                    SIM_DEVICE => "7SERIES",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{INIT_00}",
                    INIT_01 => X"{INIT_01}",
                    INIT_02 => X"{INIT_02}",
                    INIT_03 => X"{INIT_03}",
                    INIT_04 => X"{INIT_04}",
                    INIT_05 => X"{INIT_05}",
                    INIT_06 => X"{INIT_06}",
                    INIT_07 => X"{INIT_07}",
                    INIT_08 => X"{INIT_08}",
                    INIT_09 => X"{INIT_09}",
                    INIT_0A => X"{INIT_0A}",
                    INIT_0B => X"{INIT_0B}",
                    INIT_0C => X"{INIT_0C}",
                    INIT_0D => X"{INIT_0D}",
                    INIT_0E => X"{INIT_0E}",
                    INIT_0F => X"{INIT_0F}",
                    INIT_10 => X"{INIT_10}",
                    INIT_11 => X"{INIT_11}",
                    INIT_12 => X"{INIT_12}",
                    INIT_13 => X"{INIT_13}",
                    INIT_14 => X"{INIT_14}",
                    INIT_15 => X"{INIT_15}",
                    INIT_16 => X"{INIT_16}",
                    INIT_17 => X"{INIT_17}",
                    INIT_18 => X"{INIT_18}",
                    INIT_19 => X"{INIT_19}",
                    INIT_1A => X"{INIT_1A}",
                    INIT_1B => X"{INIT_1B}",
                    INIT_1C => X"{INIT_1C}",
                    INIT_1D => X"{INIT_1D}",
                    INIT_1E => X"{INIT_1E}",
                    INIT_1F => X"{INIT_1F}",
                    INIT_20 => X"{INIT_20}",
                    INIT_21 => X"{INIT_21}",
                    INIT_22 => X"{INIT_22}",
                    INIT_23 => X"{INIT_23}",
                    INIT_24 => X"{INIT_24}",
                    INIT_25 => X"{INIT_25}",
                    INIT_26 => X"{INIT_26}",
                    INIT_27 => X"{INIT_27}",
                    INIT_28 => X"{INIT_28}",
                    INIT_29 => X"{INIT_29}",
                    INIT_2A => X"{INIT_2A}",
                    INIT_2B => X"{INIT_2B}",
                    INIT_2C => X"{INIT_2C}",
                    INIT_2D => X"{INIT_2D}",
                    INIT_2E => X"{INIT_2E}",
                    INIT_2F => X"{INIT_2F}",
                    INIT_30 => X"{INIT_30}",
                    INIT_31 => X"{INIT_31}",
                    INIT_32 => X"{INIT_32}",
                    INIT_33 => X"{INIT_33}",
                    INIT_34 => X"{INIT_34}",
                    INIT_35 => X"{INIT_35}",
                    INIT_36 => X"{INIT_36}",
                    INIT_37 => X"{INIT_37}",
                    INIT_38 => X"{INIT_38}",
                    INIT_39 => X"{INIT_39}",
                    INIT_3A => X"{INIT_3A}",
                    INIT_3B => X"{INIT_3B}",
                    INIT_3C => X"{INIT_3C}",
                    INIT_3D => X"{INIT_3D}",
                    INIT_3E => X"{INIT_3E}",
                    INIT_3F => X"{INIT_3F}",
                    INIT_40 => X"{INIT_40}",
                    INIT_41 => X"{INIT_41}",
                    INIT_42 => X"{INIT_42}",
                    INIT_43 => X"{INIT_43}",
                    INIT_44 => X"{INIT_44}",
                    INIT_45 => X"{INIT_45}",
                    INIT_46 => X"{INIT_46}",
                    INIT_47 => X"{INIT_47}",
                    INIT_48 => X"{INIT_48}",
                    INIT_49 => X"{INIT_49}",
                    INIT_4A => X"{INIT_4A}",
                    INIT_4B => X"{INIT_4B}",
                    INIT_4C => X"{INIT_4C}",
                    INIT_4D => X"{INIT_4D}",
                    INIT_4E => X"{INIT_4E}",
                    INIT_4F => X"{INIT_4F}",
                    INIT_50 => X"{INIT_50}",
                    INIT_51 => X"{INIT_51}",
                    INIT_52 => X"{INIT_52}",
                    INIT_53 => X"{INIT_53}",
                    INIT_54 => X"{INIT_54}",
                    INIT_55 => X"{INIT_55}",
                    INIT_56 => X"{INIT_56}",
                    INIT_57 => X"{INIT_57}",
                    INIT_58 => X"{INIT_58}",
                    INIT_59 => X"{INIT_59}",
                    INIT_5A => X"{INIT_5A}",
                    INIT_5B => X"{INIT_5B}",
                    INIT_5C => X"{INIT_5C}",
                    INIT_5D => X"{INIT_5D}",
                    INIT_5E => X"{INIT_5E}",
                    INIT_5F => X"{INIT_5F}",
                    INIT_60 => X"{INIT_60}",
                    INIT_61 => X"{INIT_61}",
                    INIT_62 => X"{INIT_62}",
                    INIT_63 => X"{INIT_63}",
                    INIT_64 => X"{INIT_64}",
                    INIT_65 => X"{INIT_65}",
                    INIT_66 => X"{INIT_66}",
                    INIT_67 => X"{INIT_67}",
                    INIT_68 => X"{INIT_68}",
                    INIT_69 => X"{INIT_69}",
                    INIT_6A => X"{INIT_6A}",
                    INIT_6B => X"{INIT_6B}",
                    INIT_6C => X"{INIT_6C}",
                    INIT_6D => X"{INIT_6D}",
                    INIT_6E => X"{INIT_6E}",
                    INIT_6F => X"{INIT_6F}",
                    INIT_70 => X"{INIT_70}",
                    INIT_71 => X"{INIT_71}",
                    INIT_72 => X"{INIT_72}",
                    INIT_73 => X"{INIT_73}",
                    INIT_74 => X"{INIT_74}",
                    INIT_75 => X"{INIT_75}",
                    INIT_76 => X"{INIT_76}",
                    INIT_77 => X"{INIT_77}",
                    INIT_78 => X"{INIT_78}",
                    INIT_79 => X"{INIT_79}",
                    INIT_7A => X"{INIT_7A}",
                    INIT_7B => X"{INIT_7B}",
                    INIT_7C => X"{INIT_7C}",
                    INIT_7D => X"{INIT_7D}",
                    INIT_7E => X"{INIT_7E}",
                    INIT_7F => X"{INIT_7F}",
                   INITP_00 => X"{INITP_00}",
                   INITP_01 => X"{INITP_01}",
                   INITP_02 => X"{INITP_02}",
                   INITP_03 => X"{INITP_03}",
                   INITP_04 => X"{INITP_04}",
                   INITP_05 => X"{INITP_05}",
                   INITP_06 => X"{INITP_06}",
                   INITP_07 => X"{INITP_07}",
                   INITP_08 => X"{INITP_08}",
                   INITP_09 => X"{INITP_09}",
                   INITP_0A => X"{INITP_0A}",
                   INITP_0B => X"{INITP_0B}",
                   INITP_0C => X"{INITP_0C}",
                   INITP_0D => X"{INITP_0D}",
                   INITP_0E => X"{INITP_0E}",
                   INITP_0F => X"{INITP_0F}")
      port map(   ADDRARDADDR => address_a,
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                        DOADO => data_out_a(31 downto 0),
                      DOPADOP => data_out_a(35 downto 32), 
                        DIADI => data_in_a(31 downto 0),
                      DIPADIP => data_in_a(35 downto 32), 
                          WEA => "0000",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b,
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                        DOBDO => data_out_b(31 downto 0),
                      DOPBDOP => data_out_b(35 downto 32), 
                        DIBDI => data_in_b(31 downto 0),
                      DIPBDIP => data_in_b(35 downto 32), 
                        WEBWE => we_b,
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                   CASCADEINA => '0',
                   CASCADEINB => '0',
                INJECTDBITERR => '0',
                INJECTSBITERR => '0');
      --
    end generate akv7;
    --
    --
    us : if (C_FAMILY = "US") generate
      --
      address_a(14 downto 0) <= address(10 downto 0) & "1111";
      instruction <= data_out_a(33 downto 32) & data_out_a(15 downto 0);
      data_in_a <= "00000000000000000000000000000000000" & address(11);
      jtag_dout <= data_out_b(33 downto 32) & data_out_b(15 downto 0);
      --
      no_loader : if (C_JTAG_LOADER_ENABLE = 0) generate
        data_in_b <= "00" & data_out_b(33 downto 32) & "0000000000000000" & data_out_b(15 downto 0);
        address_b(14 downto 0) <= "111111111111111";
        we_b <= "00000000";
        enable_b <= '0';
        rdl <= '0';
        clk_b <= '0';
      end generate no_loader;
      --
      loader : if (C_JTAG_LOADER_ENABLE = 1) generate
        data_in_b <= "00" & jtag_din(17 downto 16) & "0000000000000000" & jtag_din(15 downto 0);
        address_b(14 downto 0) <= jtag_addr(10 downto 0) & "1111";
        we_b <= jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we;
        enable_b <= jtag_en;
        rdl <= rdl_bus;
        clk_b <= jtag_clk;
      end generate loader;
      --
      kcpsm6_rom: RAMB36E2
      generic map ( READ_WIDTH_A => 18,
                    WRITE_WIDTH_A => 18,
                    DOA_REG => 0,
                    INIT_A => X"000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => X"000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 18,
                    WRITE_WIDTH_B => 18,
                    DOB_REG => 0,
                    INIT_B => X"000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => X"000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    EN_ECC_READ => "FALSE",
                    EN_ECC_WRITE => "FALSE",
                    CASCADE_ORDER_A => "NONE",
                    CASCADE_ORDER_B => "NONE",
                    CLOCK_DOMAINS => "INDEPENDENT",
                    ENADDRENA => "FALSE",
                    ENADDRENB => "FALSE",
                    EN_ECC_PIPE => "FALSE",
                    RDADDRCHANGEA => "FALSE",
                    RDADDRCHANGEB => "FALSE",
                    SLEEP_ASYNC => "FALSE",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{INIT_00}",
                    INIT_01 => X"{INIT_01}",
                    INIT_02 => X"{INIT_02}",
                    INIT_03 => X"{INIT_03}",
                    INIT_04 => X"{INIT_04}",
                    INIT_05 => X"{INIT_05}",
                    INIT_06 => X"{INIT_06}",
                    INIT_07 => X"{INIT_07}",
                    INIT_08 => X"{INIT_08}",
                    INIT_09 => X"{INIT_09}",
                    INIT_0A => X"{INIT_0A}",
                    INIT_0B => X"{INIT_0B}",
                    INIT_0C => X"{INIT_0C}",
                    INIT_0D => X"{INIT_0D}",
                    INIT_0E => X"{INIT_0E}",
                    INIT_0F => X"{INIT_0F}",
                    INIT_10 => X"{INIT_10}",
                    INIT_11 => X"{INIT_11}",
                    INIT_12 => X"{INIT_12}",
                    INIT_13 => X"{INIT_13}",
                    INIT_14 => X"{INIT_14}",
                    INIT_15 => X"{INIT_15}",
                    INIT_16 => X"{INIT_16}",
                    INIT_17 => X"{INIT_17}",
                    INIT_18 => X"{INIT_18}",
                    INIT_19 => X"{INIT_19}",
                    INIT_1A => X"{INIT_1A}",
                    INIT_1B => X"{INIT_1B}",
                    INIT_1C => X"{INIT_1C}",
                    INIT_1D => X"{INIT_1D}",
                    INIT_1E => X"{INIT_1E}",
                    INIT_1F => X"{INIT_1F}",
                    INIT_20 => X"{INIT_20}",
                    INIT_21 => X"{INIT_21}",
                    INIT_22 => X"{INIT_22}",
                    INIT_23 => X"{INIT_23}",
                    INIT_24 => X"{INIT_24}",
                    INIT_25 => X"{INIT_25}",
                    INIT_26 => X"{INIT_26}",
                    INIT_27 => X"{INIT_27}",
                    INIT_28 => X"{INIT_28}",
                    INIT_29 => X"{INIT_29}",
                    INIT_2A => X"{INIT_2A}",
                    INIT_2B => X"{INIT_2B}",
                    INIT_2C => X"{INIT_2C}",
                    INIT_2D => X"{INIT_2D}",
                    INIT_2E => X"{INIT_2E}",
                    INIT_2F => X"{INIT_2F}",
                    INIT_30 => X"{INIT_30}",
                    INIT_31 => X"{INIT_31}",
                    INIT_32 => X"{INIT_32}",
                    INIT_33 => X"{INIT_33}",
                    INIT_34 => X"{INIT_34}",
                    INIT_35 => X"{INIT_35}",
                    INIT_36 => X"{INIT_36}",
                    INIT_37 => X"{INIT_37}",
                    INIT_38 => X"{INIT_38}",
                    INIT_39 => X"{INIT_39}",
                    INIT_3A => X"{INIT_3A}",
                    INIT_3B => X"{INIT_3B}",
                    INIT_3C => X"{INIT_3C}",
                    INIT_3D => X"{INIT_3D}",
                    INIT_3E => X"{INIT_3E}",
                    INIT_3F => X"{INIT_3F}",
                    INIT_40 => X"{INIT_40}",
                    INIT_41 => X"{INIT_41}",
                    INIT_42 => X"{INIT_42}",
                    INIT_43 => X"{INIT_43}",
                    INIT_44 => X"{INIT_44}",
                    INIT_45 => X"{INIT_45}",
                    INIT_46 => X"{INIT_46}",
                    INIT_47 => X"{INIT_47}",
                    INIT_48 => X"{INIT_48}",
                    INIT_49 => X"{INIT_49}",
                    INIT_4A => X"{INIT_4A}",
                    INIT_4B => X"{INIT_4B}",
                    INIT_4C => X"{INIT_4C}",
                    INIT_4D => X"{INIT_4D}",
                    INIT_4E => X"{INIT_4E}",
                    INIT_4F => X"{INIT_4F}",
                    INIT_50 => X"{INIT_50}",
                    INIT_51 => X"{INIT_51}",
                    INIT_52 => X"{INIT_52}",
                    INIT_53 => X"{INIT_53}",
                    INIT_54 => X"{INIT_54}",
                    INIT_55 => X"{INIT_55}",
                    INIT_56 => X"{INIT_56}",
                    INIT_57 => X"{INIT_57}",
                    INIT_58 => X"{INIT_58}",
                    INIT_59 => X"{INIT_59}",
                    INIT_5A => X"{INIT_5A}",
                    INIT_5B => X"{INIT_5B}",
                    INIT_5C => X"{INIT_5C}",
                    INIT_5D => X"{INIT_5D}",
                    INIT_5E => X"{INIT_5E}",
                    INIT_5F => X"{INIT_5F}",
                    INIT_60 => X"{INIT_60}",
                    INIT_61 => X"{INIT_61}",
                    INIT_62 => X"{INIT_62}",
                    INIT_63 => X"{INIT_63}",
                    INIT_64 => X"{INIT_64}",
                    INIT_65 => X"{INIT_65}",
                    INIT_66 => X"{INIT_66}",
                    INIT_67 => X"{INIT_67}",
                    INIT_68 => X"{INIT_68}",
                    INIT_69 => X"{INIT_69}",
                    INIT_6A => X"{INIT_6A}",
                    INIT_6B => X"{INIT_6B}",
                    INIT_6C => X"{INIT_6C}",
                    INIT_6D => X"{INIT_6D}",
                    INIT_6E => X"{INIT_6E}",
                    INIT_6F => X"{INIT_6F}",
                    INIT_70 => X"{INIT_70}",
                    INIT_71 => X"{INIT_71}",
                    INIT_72 => X"{INIT_72}",
                    INIT_73 => X"{INIT_73}",
                    INIT_74 => X"{INIT_74}",
                    INIT_75 => X"{INIT_75}",
                    INIT_76 => X"{INIT_76}",
                    INIT_77 => X"{INIT_77}",
                    INIT_78 => X"{INIT_78}",
                    INIT_79 => X"{INIT_79}",
                    INIT_7A => X"{INIT_7A}",
                    INIT_7B => X"{INIT_7B}",
                    INIT_7C => X"{INIT_7C}",
                    INIT_7D => X"{INIT_7D}",
                    INIT_7E => X"{INIT_7E}",
                    INIT_7F => X"{INIT_7F}",
                   INITP_00 => X"{INITP_00}",
                   INITP_01 => X"{INITP_01}",
                   INITP_02 => X"{INITP_02}",
                   INITP_03 => X"{INITP_03}",
                   INITP_04 => X"{INITP_04}",
                   INITP_05 => X"{INITP_05}",
                   INITP_06 => X"{INITP_06}",
                   INITP_07 => X"{INITP_07}",
                   INITP_08 => X"{INITP_08}",
                   INITP_09 => X"{INITP_09}",
                   INITP_0A => X"{INITP_0A}",
                   INITP_0B => X"{INITP_0B}",
                   INITP_0C => X"{INITP_0C}",
                   INITP_0D => X"{INITP_0D}",
                   INITP_0E => X"{INITP_0E}",
                   INITP_0F => X"{INITP_0F}")
      port map(   ADDRARDADDR => address_a(14 downto 0),
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                    DOUTADOUT => data_out_a(31 downto 0),
                  DOUTPADOUTP => data_out_a(35 downto 32), 
                      DINADIN => data_in_a(31 downto 0),
                    DINPADINP => data_in_a(35 downto 32), 
                          WEA => "0000",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b(14 downto 0),
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                    DOUTBDOUT => data_out_b(31 downto 0),
                  DOUTPBDOUTP => data_out_b(35 downto 32), 
                      DINBDIN => data_in_b(31 downto 0),
                    DINPBDINP => data_in_b(35 downto 32), 
                        WEBWE => we_b,
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                INJECTDBITERR => '0',
                INJECTSBITERR => '0',
                      ADDRENA => '1',
                      ADDRENB => '1',
                    CASDIMUXA => '0',
                    CASDIMUXB => '0',
                      CASDINA => "00000000000000000000000000000000",  
                      CASDINB => "00000000000000000000000000000000",
                     CASDINPA => "0000",
                     CASDINPB => "0000",
                    CASDOMUXA => '0',
                    CASDOMUXB => '0',
                 CASDOMUXEN_A => '1',
                 CASDOMUXEN_B => '1',
                 CASINDBITERR => '0',
                 CASINSBITERR => '0',
                 CASOREGIMUXA => '0',
                 CASOREGIMUXB => '0',
              CASOREGIMUXEN_A => '0',
              CASOREGIMUXEN_B => '0',
                    ECCPIPECE => '0',
                        SLEEP => '0');
      --
    end generate us;
    --
  end generate ram_2k_generate;
  --
  --	
  ram_4k_generate : if (C_RAM_SIZE_KWORDS = 4) generate
    --
    --
    akv7 : if (C_FAMILY = "7S") generate
      --
      address_a <= '1' & address(11 downto 0) & "111";
      instruction <= data_out_a_h(32) & data_out_a_h(7 downto 0) & data_out_a_l(32) & data_out_a_l(7 downto 0);
      data_in_a <= "000000000000000000000000000000000000";
      jtag_dout <= data_out_b_h(32) & data_out_b_h(7 downto 0) & data_out_b_l(32) & data_out_b_l(7 downto 0);
      --
      no_loader : if (C_JTAG_LOADER_ENABLE = 0) generate
        data_in_b_l <= "000" & data_out_b_l(32) & "000000000000000000000000" & data_out_b_l(7 downto 0);
        data_in_b_h <= "000" & data_out_b_h(32) & "000000000000000000000000" & data_out_b_h(7 downto 0);
        address_b <= "1111111111111111";
        we_b <= "00000000";
        enable_b <= '0';
        rdl <= '0';
        clk_b <= '0';
      end generate no_loader;
      --
      loader : if (C_JTAG_LOADER_ENABLE = 1) generate
        data_in_b_h <= "000" & jtag_din(17) & "000000000000000000000000" & jtag_din(16 downto 9);
        data_in_b_l <= "000" & jtag_din(8) & "000000000000000000000000" & jtag_din(7 downto 0);
        address_b <= '1' & jtag_addr(11 downto 0) & "111";
        we_b <= jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we;
        enable_b <= jtag_en;
        rdl <= rdl_bus;
        clk_b <= jtag_clk;
      end generate loader;
      --
      kcpsm6_rom_l: RAMB36E1
      generic map ( READ_WIDTH_A => 9,
                    WRITE_WIDTH_A => 9,
                    DOA_REG => 0,
                    INIT_A => X"000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => X"000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 9,
                    WRITE_WIDTH_B => 9,
                    DOB_REG => 0,
                    INIT_B => X"000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => X"000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    RAM_MODE => "TDP",
                    RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
                    EN_ECC_READ => FALSE,
                    EN_ECC_WRITE => FALSE,
                    RAM_EXTENSION_A => "NONE",
                    RAM_EXTENSION_B => "NONE",
                    SIM_DEVICE => "7SERIES",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{[8:0]_INIT_00}",
                    INIT_01 => X"{[8:0]_INIT_01}",
                    INIT_02 => X"{[8:0]_INIT_02}",
                    INIT_03 => X"{[8:0]_INIT_03}",
                    INIT_04 => X"{[8:0]_INIT_04}",
                    INIT_05 => X"{[8:0]_INIT_05}",
                    INIT_06 => X"{[8:0]_INIT_06}",
                    INIT_07 => X"{[8:0]_INIT_07}",
                    INIT_08 => X"{[8:0]_INIT_08}",
                    INIT_09 => X"{[8:0]_INIT_09}",
                    INIT_0A => X"{[8:0]_INIT_0A}",
                    INIT_0B => X"{[8:0]_INIT_0B}",
                    INIT_0C => X"{[8:0]_INIT_0C}",
                    INIT_0D => X"{[8:0]_INIT_0D}",
                    INIT_0E => X"{[8:0]_INIT_0E}",
                    INIT_0F => X"{[8:0]_INIT_0F}",
                    INIT_10 => X"{[8:0]_INIT_10}",
                    INIT_11 => X"{[8:0]_INIT_11}",
                    INIT_12 => X"{[8:0]_INIT_12}",
                    INIT_13 => X"{[8:0]_INIT_13}",
                    INIT_14 => X"{[8:0]_INIT_14}",
                    INIT_15 => X"{[8:0]_INIT_15}",
                    INIT_16 => X"{[8:0]_INIT_16}",
                    INIT_17 => X"{[8:0]_INIT_17}",
                    INIT_18 => X"{[8:0]_INIT_18}",
                    INIT_19 => X"{[8:0]_INIT_19}",
                    INIT_1A => X"{[8:0]_INIT_1A}",
                    INIT_1B => X"{[8:0]_INIT_1B}",
                    INIT_1C => X"{[8:0]_INIT_1C}",
                    INIT_1D => X"{[8:0]_INIT_1D}",
                    INIT_1E => X"{[8:0]_INIT_1E}",
                    INIT_1F => X"{[8:0]_INIT_1F}",
                    INIT_20 => X"{[8:0]_INIT_20}",
                    INIT_21 => X"{[8:0]_INIT_21}",
                    INIT_22 => X"{[8:0]_INIT_22}",
                    INIT_23 => X"{[8:0]_INIT_23}",
                    INIT_24 => X"{[8:0]_INIT_24}",
                    INIT_25 => X"{[8:0]_INIT_25}",
                    INIT_26 => X"{[8:0]_INIT_26}",
                    INIT_27 => X"{[8:0]_INIT_27}",
                    INIT_28 => X"{[8:0]_INIT_28}",
                    INIT_29 => X"{[8:0]_INIT_29}",
                    INIT_2A => X"{[8:0]_INIT_2A}",
                    INIT_2B => X"{[8:0]_INIT_2B}",
                    INIT_2C => X"{[8:0]_INIT_2C}",
                    INIT_2D => X"{[8:0]_INIT_2D}",
                    INIT_2E => X"{[8:0]_INIT_2E}",
                    INIT_2F => X"{[8:0]_INIT_2F}",
                    INIT_30 => X"{[8:0]_INIT_30}",
                    INIT_31 => X"{[8:0]_INIT_31}",
                    INIT_32 => X"{[8:0]_INIT_32}",
                    INIT_33 => X"{[8:0]_INIT_33}",
                    INIT_34 => X"{[8:0]_INIT_34}",
                    INIT_35 => X"{[8:0]_INIT_35}",
                    INIT_36 => X"{[8:0]_INIT_36}",
                    INIT_37 => X"{[8:0]_INIT_37}",
                    INIT_38 => X"{[8:0]_INIT_38}",
                    INIT_39 => X"{[8:0]_INIT_39}",
                    INIT_3A => X"{[8:0]_INIT_3A}",
                    INIT_3B => X"{[8:0]_INIT_3B}",
                    INIT_3C => X"{[8:0]_INIT_3C}",
                    INIT_3D => X"{[8:0]_INIT_3D}",
                    INIT_3E => X"{[8:0]_INIT_3E}",
                    INIT_3F => X"{[8:0]_INIT_3F}",
                    INIT_40 => X"{[8:0]_INIT_40}",
                    INIT_41 => X"{[8:0]_INIT_41}",
                    INIT_42 => X"{[8:0]_INIT_42}",
                    INIT_43 => X"{[8:0]_INIT_43}",
                    INIT_44 => X"{[8:0]_INIT_44}",
                    INIT_45 => X"{[8:0]_INIT_45}",
                    INIT_46 => X"{[8:0]_INIT_46}",
                    INIT_47 => X"{[8:0]_INIT_47}",
                    INIT_48 => X"{[8:0]_INIT_48}",
                    INIT_49 => X"{[8:0]_INIT_49}",
                    INIT_4A => X"{[8:0]_INIT_4A}",
                    INIT_4B => X"{[8:0]_INIT_4B}",
                    INIT_4C => X"{[8:0]_INIT_4C}",
                    INIT_4D => X"{[8:0]_INIT_4D}",
                    INIT_4E => X"{[8:0]_INIT_4E}",
                    INIT_4F => X"{[8:0]_INIT_4F}",
                    INIT_50 => X"{[8:0]_INIT_50}",
                    INIT_51 => X"{[8:0]_INIT_51}",
                    INIT_52 => X"{[8:0]_INIT_52}",
                    INIT_53 => X"{[8:0]_INIT_53}",
                    INIT_54 => X"{[8:0]_INIT_54}",
                    INIT_55 => X"{[8:0]_INIT_55}",
                    INIT_56 => X"{[8:0]_INIT_56}",
                    INIT_57 => X"{[8:0]_INIT_57}",
                    INIT_58 => X"{[8:0]_INIT_58}",
                    INIT_59 => X"{[8:0]_INIT_59}",
                    INIT_5A => X"{[8:0]_INIT_5A}",
                    INIT_5B => X"{[8:0]_INIT_5B}",
                    INIT_5C => X"{[8:0]_INIT_5C}",
                    INIT_5D => X"{[8:0]_INIT_5D}",
                    INIT_5E => X"{[8:0]_INIT_5E}",
                    INIT_5F => X"{[8:0]_INIT_5F}",
                    INIT_60 => X"{[8:0]_INIT_60}",
                    INIT_61 => X"{[8:0]_INIT_61}",
                    INIT_62 => X"{[8:0]_INIT_62}",
                    INIT_63 => X"{[8:0]_INIT_63}",
                    INIT_64 => X"{[8:0]_INIT_64}",
                    INIT_65 => X"{[8:0]_INIT_65}",
                    INIT_66 => X"{[8:0]_INIT_66}",
                    INIT_67 => X"{[8:0]_INIT_67}",
                    INIT_68 => X"{[8:0]_INIT_68}",
                    INIT_69 => X"{[8:0]_INIT_69}",
                    INIT_6A => X"{[8:0]_INIT_6A}",
                    INIT_6B => X"{[8:0]_INIT_6B}",
                    INIT_6C => X"{[8:0]_INIT_6C}",
                    INIT_6D => X"{[8:0]_INIT_6D}",
                    INIT_6E => X"{[8:0]_INIT_6E}",
                    INIT_6F => X"{[8:0]_INIT_6F}",
                    INIT_70 => X"{[8:0]_INIT_70}",
                    INIT_71 => X"{[8:0]_INIT_71}",
                    INIT_72 => X"{[8:0]_INIT_72}",
                    INIT_73 => X"{[8:0]_INIT_73}",
                    INIT_74 => X"{[8:0]_INIT_74}",
                    INIT_75 => X"{[8:0]_INIT_75}",
                    INIT_76 => X"{[8:0]_INIT_76}",
                    INIT_77 => X"{[8:0]_INIT_77}",
                    INIT_78 => X"{[8:0]_INIT_78}",
                    INIT_79 => X"{[8:0]_INIT_79}",
                    INIT_7A => X"{[8:0]_INIT_7A}",
                    INIT_7B => X"{[8:0]_INIT_7B}",
                    INIT_7C => X"{[8:0]_INIT_7C}",
                    INIT_7D => X"{[8:0]_INIT_7D}",
                    INIT_7E => X"{[8:0]_INIT_7E}",
                    INIT_7F => X"{[8:0]_INIT_7F}",
                   INITP_00 => X"{[8:0]_INITP_00}",
                   INITP_01 => X"{[8:0]_INITP_01}",
                   INITP_02 => X"{[8:0]_INITP_02}",
                   INITP_03 => X"{[8:0]_INITP_03}",
                   INITP_04 => X"{[8:0]_INITP_04}",
                   INITP_05 => X"{[8:0]_INITP_05}",
                   INITP_06 => X"{[8:0]_INITP_06}",
                   INITP_07 => X"{[8:0]_INITP_07}",
                   INITP_08 => X"{[8:0]_INITP_08}",
                   INITP_09 => X"{[8:0]_INITP_09}",
                   INITP_0A => X"{[8:0]_INITP_0A}",
                   INITP_0B => X"{[8:0]_INITP_0B}",
                   INITP_0C => X"{[8:0]_INITP_0C}",
                   INITP_0D => X"{[8:0]_INITP_0D}",
                   INITP_0E => X"{[8:0]_INITP_0E}",
                   INITP_0F => X"{[8:0]_INITP_0F}")
      port map(   ADDRARDADDR => address_a,
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                        DOADO => data_out_a_l(31 downto 0),
                      DOPADOP => data_out_a_l(35 downto 32), 
                        DIADI => data_in_a(31 downto 0),
                      DIPADIP => data_in_a(35 downto 32), 
                          WEA => "0000",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b,
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                        DOBDO => data_out_b_l(31 downto 0),
                      DOPBDOP => data_out_b_l(35 downto 32), 
                        DIBDI => data_in_b_l(31 downto 0),
                      DIPBDIP => data_in_b_l(35 downto 32), 
                        WEBWE => we_b,
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                   CASCADEINA => '0',
                   CASCADEINB => '0',
                INJECTDBITERR => '0',
                INJECTSBITERR => '0');
      --
      kcpsm6_rom_h: RAMB36E1
      generic map ( READ_WIDTH_A => 9,
                    WRITE_WIDTH_A => 9,
                    DOA_REG => 0,
                    INIT_A => X"000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => X"000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 9,
                    WRITE_WIDTH_B => 9,
                    DOB_REG => 0,
                    INIT_B => X"000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => X"000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    RAM_MODE => "TDP",
                    RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
                    EN_ECC_READ => FALSE,
                    EN_ECC_WRITE => FALSE,
                    RAM_EXTENSION_A => "NONE",
                    RAM_EXTENSION_B => "NONE",
                    SIM_DEVICE => "7SERIES",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{[17:9]_INIT_00}",
                    INIT_01 => X"{[17:9]_INIT_01}",
                    INIT_02 => X"{[17:9]_INIT_02}",
                    INIT_03 => X"{[17:9]_INIT_03}",
                    INIT_04 => X"{[17:9]_INIT_04}",
                    INIT_05 => X"{[17:9]_INIT_05}",
                    INIT_06 => X"{[17:9]_INIT_06}",
                    INIT_07 => X"{[17:9]_INIT_07}",
                    INIT_08 => X"{[17:9]_INIT_08}",
                    INIT_09 => X"{[17:9]_INIT_09}",
                    INIT_0A => X"{[17:9]_INIT_0A}",
                    INIT_0B => X"{[17:9]_INIT_0B}",
                    INIT_0C => X"{[17:9]_INIT_0C}",
                    INIT_0D => X"{[17:9]_INIT_0D}",
                    INIT_0E => X"{[17:9]_INIT_0E}",
                    INIT_0F => X"{[17:9]_INIT_0F}",
                    INIT_10 => X"{[17:9]_INIT_10}",
                    INIT_11 => X"{[17:9]_INIT_11}",
                    INIT_12 => X"{[17:9]_INIT_12}",
                    INIT_13 => X"{[17:9]_INIT_13}",
                    INIT_14 => X"{[17:9]_INIT_14}",
                    INIT_15 => X"{[17:9]_INIT_15}",
                    INIT_16 => X"{[17:9]_INIT_16}",
                    INIT_17 => X"{[17:9]_INIT_17}",
                    INIT_18 => X"{[17:9]_INIT_18}",
                    INIT_19 => X"{[17:9]_INIT_19}",
                    INIT_1A => X"{[17:9]_INIT_1A}",
                    INIT_1B => X"{[17:9]_INIT_1B}",
                    INIT_1C => X"{[17:9]_INIT_1C}",
                    INIT_1D => X"{[17:9]_INIT_1D}",
                    INIT_1E => X"{[17:9]_INIT_1E}",
                    INIT_1F => X"{[17:9]_INIT_1F}",
                    INIT_20 => X"{[17:9]_INIT_20}",
                    INIT_21 => X"{[17:9]_INIT_21}",
                    INIT_22 => X"{[17:9]_INIT_22}",
                    INIT_23 => X"{[17:9]_INIT_23}",
                    INIT_24 => X"{[17:9]_INIT_24}",
                    INIT_25 => X"{[17:9]_INIT_25}",
                    INIT_26 => X"{[17:9]_INIT_26}",
                    INIT_27 => X"{[17:9]_INIT_27}",
                    INIT_28 => X"{[17:9]_INIT_28}",
                    INIT_29 => X"{[17:9]_INIT_29}",
                    INIT_2A => X"{[17:9]_INIT_2A}",
                    INIT_2B => X"{[17:9]_INIT_2B}",
                    INIT_2C => X"{[17:9]_INIT_2C}",
                    INIT_2D => X"{[17:9]_INIT_2D}",
                    INIT_2E => X"{[17:9]_INIT_2E}",
                    INIT_2F => X"{[17:9]_INIT_2F}",
                    INIT_30 => X"{[17:9]_INIT_30}",
                    INIT_31 => X"{[17:9]_INIT_31}",
                    INIT_32 => X"{[17:9]_INIT_32}",
                    INIT_33 => X"{[17:9]_INIT_33}",
                    INIT_34 => X"{[17:9]_INIT_34}",
                    INIT_35 => X"{[17:9]_INIT_35}",
                    INIT_36 => X"{[17:9]_INIT_36}",
                    INIT_37 => X"{[17:9]_INIT_37}",
                    INIT_38 => X"{[17:9]_INIT_38}",
                    INIT_39 => X"{[17:9]_INIT_39}",
                    INIT_3A => X"{[17:9]_INIT_3A}",
                    INIT_3B => X"{[17:9]_INIT_3B}",
                    INIT_3C => X"{[17:9]_INIT_3C}",
                    INIT_3D => X"{[17:9]_INIT_3D}",
                    INIT_3E => X"{[17:9]_INIT_3E}",
                    INIT_3F => X"{[17:9]_INIT_3F}",
                    INIT_40 => X"{[17:9]_INIT_40}",
                    INIT_41 => X"{[17:9]_INIT_41}",
                    INIT_42 => X"{[17:9]_INIT_42}",
                    INIT_43 => X"{[17:9]_INIT_43}",
                    INIT_44 => X"{[17:9]_INIT_44}",
                    INIT_45 => X"{[17:9]_INIT_45}",
                    INIT_46 => X"{[17:9]_INIT_46}",
                    INIT_47 => X"{[17:9]_INIT_47}",
                    INIT_48 => X"{[17:9]_INIT_48}",
                    INIT_49 => X"{[17:9]_INIT_49}",
                    INIT_4A => X"{[17:9]_INIT_4A}",
                    INIT_4B => X"{[17:9]_INIT_4B}",
                    INIT_4C => X"{[17:9]_INIT_4C}",
                    INIT_4D => X"{[17:9]_INIT_4D}",
                    INIT_4E => X"{[17:9]_INIT_4E}",
                    INIT_4F => X"{[17:9]_INIT_4F}",
                    INIT_50 => X"{[17:9]_INIT_50}",
                    INIT_51 => X"{[17:9]_INIT_51}",
                    INIT_52 => X"{[17:9]_INIT_52}",
                    INIT_53 => X"{[17:9]_INIT_53}",
                    INIT_54 => X"{[17:9]_INIT_54}",
                    INIT_55 => X"{[17:9]_INIT_55}",
                    INIT_56 => X"{[17:9]_INIT_56}",
                    INIT_57 => X"{[17:9]_INIT_57}",
                    INIT_58 => X"{[17:9]_INIT_58}",
                    INIT_59 => X"{[17:9]_INIT_59}",
                    INIT_5A => X"{[17:9]_INIT_5A}",
                    INIT_5B => X"{[17:9]_INIT_5B}",
                    INIT_5C => X"{[17:9]_INIT_5C}",
                    INIT_5D => X"{[17:9]_INIT_5D}",
                    INIT_5E => X"{[17:9]_INIT_5E}",
                    INIT_5F => X"{[17:9]_INIT_5F}",
                    INIT_60 => X"{[17:9]_INIT_60}",
                    INIT_61 => X"{[17:9]_INIT_61}",
                    INIT_62 => X"{[17:9]_INIT_62}",
                    INIT_63 => X"{[17:9]_INIT_63}",
                    INIT_64 => X"{[17:9]_INIT_64}",
                    INIT_65 => X"{[17:9]_INIT_65}",
                    INIT_66 => X"{[17:9]_INIT_66}",
                    INIT_67 => X"{[17:9]_INIT_67}",
                    INIT_68 => X"{[17:9]_INIT_68}",
                    INIT_69 => X"{[17:9]_INIT_69}",
                    INIT_6A => X"{[17:9]_INIT_6A}",
                    INIT_6B => X"{[17:9]_INIT_6B}",
                    INIT_6C => X"{[17:9]_INIT_6C}",
                    INIT_6D => X"{[17:9]_INIT_6D}",
                    INIT_6E => X"{[17:9]_INIT_6E}",
                    INIT_6F => X"{[17:9]_INIT_6F}",
                    INIT_70 => X"{[17:9]_INIT_70}",
                    INIT_71 => X"{[17:9]_INIT_71}",
                    INIT_72 => X"{[17:9]_INIT_72}",
                    INIT_73 => X"{[17:9]_INIT_73}",
                    INIT_74 => X"{[17:9]_INIT_74}",
                    INIT_75 => X"{[17:9]_INIT_75}",
                    INIT_76 => X"{[17:9]_INIT_76}",
                    INIT_77 => X"{[17:9]_INIT_77}",
                    INIT_78 => X"{[17:9]_INIT_78}",
                    INIT_79 => X"{[17:9]_INIT_79}",
                    INIT_7A => X"{[17:9]_INIT_7A}",
                    INIT_7B => X"{[17:9]_INIT_7B}",
                    INIT_7C => X"{[17:9]_INIT_7C}",
                    INIT_7D => X"{[17:9]_INIT_7D}",
                    INIT_7E => X"{[17:9]_INIT_7E}",
                    INIT_7F => X"{[17:9]_INIT_7F}",
                   INITP_00 => X"{[17:9]_INITP_00}",
                   INITP_01 => X"{[17:9]_INITP_01}",
                   INITP_02 => X"{[17:9]_INITP_02}",
                   INITP_03 => X"{[17:9]_INITP_03}",
                   INITP_04 => X"{[17:9]_INITP_04}",
                   INITP_05 => X"{[17:9]_INITP_05}",
                   INITP_06 => X"{[17:9]_INITP_06}",
                   INITP_07 => X"{[17:9]_INITP_07}",
                   INITP_08 => X"{[17:9]_INITP_08}",
                   INITP_09 => X"{[17:9]_INITP_09}",
                   INITP_0A => X"{[17:9]_INITP_0A}",
                   INITP_0B => X"{[17:9]_INITP_0B}",
                   INITP_0C => X"{[17:9]_INITP_0C}",
                   INITP_0D => X"{[17:9]_INITP_0D}",
                   INITP_0E => X"{[17:9]_INITP_0E}",
                   INITP_0F => X"{[17:9]_INITP_0F}")
      port map(   ADDRARDADDR => address_a,
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                        DOADO => data_out_a_h(31 downto 0),
                      DOPADOP => data_out_a_h(35 downto 32), 
                        DIADI => data_in_a(31 downto 0),
                      DIPADIP => data_in_a(35 downto 32), 
                          WEA => "0000",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b,
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                        DOBDO => data_out_b_h(31 downto 0),
                      DOPBDOP => data_out_b_h(35 downto 32), 
                        DIBDI => data_in_b_h(31 downto 0),
                      DIPBDIP => data_in_b_h(35 downto 32), 
                        WEBWE => we_b,
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                   CASCADEINA => '0',
                   CASCADEINB => '0',
                INJECTDBITERR => '0',
                INJECTSBITERR => '0');
      --
    end generate akv7;
    --
    --
    us : if (C_FAMILY = "US") generate
      --
      address_a(14 downto 0) <= address(11 downto 0) & "111";
      instruction <= data_out_a_h(32) & data_out_a_h(7 downto 0) & data_out_a_l(32) & data_out_a_l(7 downto 0);
      data_in_a <= "000000000000000000000000000000000000";
      jtag_dout <= data_out_b_h(32) & data_out_b_h(7 downto 0) & data_out_b_l(32) & data_out_b_l(7 downto 0);
      --
      no_loader : if (C_JTAG_LOADER_ENABLE = 0) generate
        data_in_b_l <= "000" & data_out_b_l(32) & "000000000000000000000000" & data_out_b_l(7 downto 0);
        data_in_b_h <= "000" & data_out_b_h(32) & "000000000000000000000000" & data_out_b_h(7 downto 0);
        address_b(14 downto 0) <= "111111111111111";
        we_b <= "00000000";
        enable_b <= '0';
        rdl <= '0';
        clk_b <= '0';
      end generate no_loader;
      --
      loader : if (C_JTAG_LOADER_ENABLE = 1) generate
        data_in_b_h <= "000" & jtag_din(17) & "000000000000000000000000" & jtag_din(16 downto 9);
        data_in_b_l <= "000" & jtag_din(8) & "000000000000000000000000" & jtag_din(7 downto 0);
        address_b(14 downto 0) <= jtag_addr(11 downto 0) & "111";
        we_b <= jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we & jtag_we;
        enable_b <= jtag_en;
        rdl <= rdl_bus;
        clk_b <= jtag_clk;
      end generate loader;
      --
      kcpsm6_rom_l: RAMB36E2
      generic map ( READ_WIDTH_A => 9,
                    WRITE_WIDTH_A => 9,
                    DOA_REG => 0,
                    INIT_A => X"000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => X"000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 9,
                    WRITE_WIDTH_B => 9,
                    DOB_REG => 0,
                    INIT_B => X"000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => X"000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    EN_ECC_READ => "FALSE",
                    EN_ECC_WRITE => "FALSE",
                    CASCADE_ORDER_A => "NONE",
                    CASCADE_ORDER_B => "NONE",
                    CLOCK_DOMAINS => "INDEPENDENT",
                    ENADDRENA => "FALSE",
                    ENADDRENB => "FALSE",
                    EN_ECC_PIPE => "FALSE",
                    RDADDRCHANGEA => "FALSE",
                    RDADDRCHANGEB => "FALSE",
                    SLEEP_ASYNC => "FALSE",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{[8:0]_INIT_00}",
                    INIT_01 => X"{[8:0]_INIT_01}",
                    INIT_02 => X"{[8:0]_INIT_02}",
                    INIT_03 => X"{[8:0]_INIT_03}",
                    INIT_04 => X"{[8:0]_INIT_04}",
                    INIT_05 => X"{[8:0]_INIT_05}",
                    INIT_06 => X"{[8:0]_INIT_06}",
                    INIT_07 => X"{[8:0]_INIT_07}",
                    INIT_08 => X"{[8:0]_INIT_08}",
                    INIT_09 => X"{[8:0]_INIT_09}",
                    INIT_0A => X"{[8:0]_INIT_0A}",
                    INIT_0B => X"{[8:0]_INIT_0B}",
                    INIT_0C => X"{[8:0]_INIT_0C}",
                    INIT_0D => X"{[8:0]_INIT_0D}",
                    INIT_0E => X"{[8:0]_INIT_0E}",
                    INIT_0F => X"{[8:0]_INIT_0F}",
                    INIT_10 => X"{[8:0]_INIT_10}",
                    INIT_11 => X"{[8:0]_INIT_11}",
                    INIT_12 => X"{[8:0]_INIT_12}",
                    INIT_13 => X"{[8:0]_INIT_13}",
                    INIT_14 => X"{[8:0]_INIT_14}",
                    INIT_15 => X"{[8:0]_INIT_15}",
                    INIT_16 => X"{[8:0]_INIT_16}",
                    INIT_17 => X"{[8:0]_INIT_17}",
                    INIT_18 => X"{[8:0]_INIT_18}",
                    INIT_19 => X"{[8:0]_INIT_19}",
                    INIT_1A => X"{[8:0]_INIT_1A}",
                    INIT_1B => X"{[8:0]_INIT_1B}",
                    INIT_1C => X"{[8:0]_INIT_1C}",
                    INIT_1D => X"{[8:0]_INIT_1D}",
                    INIT_1E => X"{[8:0]_INIT_1E}",
                    INIT_1F => X"{[8:0]_INIT_1F}",
                    INIT_20 => X"{[8:0]_INIT_20}",
                    INIT_21 => X"{[8:0]_INIT_21}",
                    INIT_22 => X"{[8:0]_INIT_22}",
                    INIT_23 => X"{[8:0]_INIT_23}",
                    INIT_24 => X"{[8:0]_INIT_24}",
                    INIT_25 => X"{[8:0]_INIT_25}",
                    INIT_26 => X"{[8:0]_INIT_26}",
                    INIT_27 => X"{[8:0]_INIT_27}",
                    INIT_28 => X"{[8:0]_INIT_28}",
                    INIT_29 => X"{[8:0]_INIT_29}",
                    INIT_2A => X"{[8:0]_INIT_2A}",
                    INIT_2B => X"{[8:0]_INIT_2B}",
                    INIT_2C => X"{[8:0]_INIT_2C}",
                    INIT_2D => X"{[8:0]_INIT_2D}",
                    INIT_2E => X"{[8:0]_INIT_2E}",
                    INIT_2F => X"{[8:0]_INIT_2F}",
                    INIT_30 => X"{[8:0]_INIT_30}",
                    INIT_31 => X"{[8:0]_INIT_31}",
                    INIT_32 => X"{[8:0]_INIT_32}",
                    INIT_33 => X"{[8:0]_INIT_33}",
                    INIT_34 => X"{[8:0]_INIT_34}",
                    INIT_35 => X"{[8:0]_INIT_35}",
                    INIT_36 => X"{[8:0]_INIT_36}",
                    INIT_37 => X"{[8:0]_INIT_37}",
                    INIT_38 => X"{[8:0]_INIT_38}",
                    INIT_39 => X"{[8:0]_INIT_39}",
                    INIT_3A => X"{[8:0]_INIT_3A}",
                    INIT_3B => X"{[8:0]_INIT_3B}",
                    INIT_3C => X"{[8:0]_INIT_3C}",
                    INIT_3D => X"{[8:0]_INIT_3D}",
                    INIT_3E => X"{[8:0]_INIT_3E}",
                    INIT_3F => X"{[8:0]_INIT_3F}",
                    INIT_40 => X"{[8:0]_INIT_40}",
                    INIT_41 => X"{[8:0]_INIT_41}",
                    INIT_42 => X"{[8:0]_INIT_42}",
                    INIT_43 => X"{[8:0]_INIT_43}",
                    INIT_44 => X"{[8:0]_INIT_44}",
                    INIT_45 => X"{[8:0]_INIT_45}",
                    INIT_46 => X"{[8:0]_INIT_46}",
                    INIT_47 => X"{[8:0]_INIT_47}",
                    INIT_48 => X"{[8:0]_INIT_48}",
                    INIT_49 => X"{[8:0]_INIT_49}",
                    INIT_4A => X"{[8:0]_INIT_4A}",
                    INIT_4B => X"{[8:0]_INIT_4B}",
                    INIT_4C => X"{[8:0]_INIT_4C}",
                    INIT_4D => X"{[8:0]_INIT_4D}",
                    INIT_4E => X"{[8:0]_INIT_4E}",
                    INIT_4F => X"{[8:0]_INIT_4F}",
                    INIT_50 => X"{[8:0]_INIT_50}",
                    INIT_51 => X"{[8:0]_INIT_51}",
                    INIT_52 => X"{[8:0]_INIT_52}",
                    INIT_53 => X"{[8:0]_INIT_53}",
                    INIT_54 => X"{[8:0]_INIT_54}",
                    INIT_55 => X"{[8:0]_INIT_55}",
                    INIT_56 => X"{[8:0]_INIT_56}",
                    INIT_57 => X"{[8:0]_INIT_57}",
                    INIT_58 => X"{[8:0]_INIT_58}",
                    INIT_59 => X"{[8:0]_INIT_59}",
                    INIT_5A => X"{[8:0]_INIT_5A}",
                    INIT_5B => X"{[8:0]_INIT_5B}",
                    INIT_5C => X"{[8:0]_INIT_5C}",
                    INIT_5D => X"{[8:0]_INIT_5D}",
                    INIT_5E => X"{[8:0]_INIT_5E}",
                    INIT_5F => X"{[8:0]_INIT_5F}",
                    INIT_60 => X"{[8:0]_INIT_60}",
                    INIT_61 => X"{[8:0]_INIT_61}",
                    INIT_62 => X"{[8:0]_INIT_62}",
                    INIT_63 => X"{[8:0]_INIT_63}",
                    INIT_64 => X"{[8:0]_INIT_64}",
                    INIT_65 => X"{[8:0]_INIT_65}",
                    INIT_66 => X"{[8:0]_INIT_66}",
                    INIT_67 => X"{[8:0]_INIT_67}",
                    INIT_68 => X"{[8:0]_INIT_68}",
                    INIT_69 => X"{[8:0]_INIT_69}",
                    INIT_6A => X"{[8:0]_INIT_6A}",
                    INIT_6B => X"{[8:0]_INIT_6B}",
                    INIT_6C => X"{[8:0]_INIT_6C}",
                    INIT_6D => X"{[8:0]_INIT_6D}",
                    INIT_6E => X"{[8:0]_INIT_6E}",
                    INIT_6F => X"{[8:0]_INIT_6F}",
                    INIT_70 => X"{[8:0]_INIT_70}",
                    INIT_71 => X"{[8:0]_INIT_71}",
                    INIT_72 => X"{[8:0]_INIT_72}",
                    INIT_73 => X"{[8:0]_INIT_73}",
                    INIT_74 => X"{[8:0]_INIT_74}",
                    INIT_75 => X"{[8:0]_INIT_75}",
                    INIT_76 => X"{[8:0]_INIT_76}",
                    INIT_77 => X"{[8:0]_INIT_77}",
                    INIT_78 => X"{[8:0]_INIT_78}",
                    INIT_79 => X"{[8:0]_INIT_79}",
                    INIT_7A => X"{[8:0]_INIT_7A}",
                    INIT_7B => X"{[8:0]_INIT_7B}",
                    INIT_7C => X"{[8:0]_INIT_7C}",
                    INIT_7D => X"{[8:0]_INIT_7D}",
                    INIT_7E => X"{[8:0]_INIT_7E}",
                    INIT_7F => X"{[8:0]_INIT_7F}",
                   INITP_00 => X"{[8:0]_INITP_00}",
                   INITP_01 => X"{[8:0]_INITP_01}",
                   INITP_02 => X"{[8:0]_INITP_02}",
                   INITP_03 => X"{[8:0]_INITP_03}",
                   INITP_04 => X"{[8:0]_INITP_04}",
                   INITP_05 => X"{[8:0]_INITP_05}",
                   INITP_06 => X"{[8:0]_INITP_06}",
                   INITP_07 => X"{[8:0]_INITP_07}",
                   INITP_08 => X"{[8:0]_INITP_08}",
                   INITP_09 => X"{[8:0]_INITP_09}",
                   INITP_0A => X"{[8:0]_INITP_0A}",
                   INITP_0B => X"{[8:0]_INITP_0B}",
                   INITP_0C => X"{[8:0]_INITP_0C}",
                   INITP_0D => X"{[8:0]_INITP_0D}",
                   INITP_0E => X"{[8:0]_INITP_0E}",
                   INITP_0F => X"{[8:0]_INITP_0F}")
      port map(   ADDRARDADDR => address_a(14 downto 0),
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                    DOUTADOUT => data_out_a_l(31 downto 0),
                  DOUTPADOUTP => data_out_a_l(35 downto 32), 
                      DINADIN => data_in_a(31 downto 0),
                    DINPADINP => data_in_a(35 downto 32), 
                          WEA => "0000",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b(14 downto 0),
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                    DOUTBDOUT => data_out_b_l(31 downto 0),
                  DOUTPBDOUTP => data_out_b_l(35 downto 32), 
                      DINBDIN => data_in_b_l(31 downto 0),
                    DINPBDINP => data_in_b_l(35 downto 32), 
                        WEBWE => we_b,
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                INJECTDBITERR => '0',
                INJECTSBITERR => '0',
                      ADDRENA => '1',
                      ADDRENB => '1',
                    CASDIMUXA => '0',
                    CASDIMUXB => '0',
                      CASDINA => "00000000000000000000000000000000",  
                      CASDINB => "00000000000000000000000000000000",
                     CASDINPA => "0000",
                     CASDINPB => "0000",
                    CASDOMUXA => '0',
                    CASDOMUXB => '0',
                 CASDOMUXEN_A => '1',
                 CASDOMUXEN_B => '1',
                 CASINDBITERR => '0',
                 CASINSBITERR => '0',
                 CASOREGIMUXA => '0',
                 CASOREGIMUXB => '0',
              CASOREGIMUXEN_A => '0',
              CASOREGIMUXEN_B => '0',
                    ECCPIPECE => '0',
                        SLEEP => '0');
      --
      kcpsm6_rom_h: RAMB36E2
      generic map ( READ_WIDTH_A => 9,
                    WRITE_WIDTH_A => 9,
                    DOA_REG => 0,
                    INIT_A => X"000000000",
                    RSTREG_PRIORITY_A => "REGCE",
                    SRVAL_A => X"000000000",
                    WRITE_MODE_A => "WRITE_FIRST",
                    READ_WIDTH_B => 9,
                    WRITE_WIDTH_B => 9,
                    DOB_REG => 0,
                    INIT_B => X"000000000",
                    RSTREG_PRIORITY_B => "REGCE",
                    SRVAL_B => X"000000000",
                    WRITE_MODE_B => "WRITE_FIRST",
                    INIT_FILE => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    EN_ECC_READ => "FALSE",
                    EN_ECC_WRITE => "FALSE",
                    CASCADE_ORDER_A => "NONE",
                    CASCADE_ORDER_B => "NONE",
                    CLOCK_DOMAINS => "INDEPENDENT",
                    ENADDRENA => "FALSE",
                    ENADDRENB => "FALSE",
                    EN_ECC_PIPE => "FALSE",
                    RDADDRCHANGEA => "FALSE",
                    RDADDRCHANGEB => "FALSE",
                    SLEEP_ASYNC => "FALSE",
                    IS_CLKARDCLK_INVERTED => '0',
                    IS_CLKBWRCLK_INVERTED => '0',
                    IS_ENARDEN_INVERTED => '0',
                    IS_ENBWREN_INVERTED => '0',
                    IS_RSTRAMARSTRAM_INVERTED => '0',
                    IS_RSTRAMB_INVERTED => '0',
                    IS_RSTREGARSTREG_INVERTED => '0',
                    IS_RSTREGB_INVERTED => '0',
                    INIT_00 => X"{[17:9]_INIT_00}",
                    INIT_01 => X"{[17:9]_INIT_01}",
                    INIT_02 => X"{[17:9]_INIT_02}",
                    INIT_03 => X"{[17:9]_INIT_03}",
                    INIT_04 => X"{[17:9]_INIT_04}",
                    INIT_05 => X"{[17:9]_INIT_05}",
                    INIT_06 => X"{[17:9]_INIT_06}",
                    INIT_07 => X"{[17:9]_INIT_07}",
                    INIT_08 => X"{[17:9]_INIT_08}",
                    INIT_09 => X"{[17:9]_INIT_09}",
                    INIT_0A => X"{[17:9]_INIT_0A}",
                    INIT_0B => X"{[17:9]_INIT_0B}",
                    INIT_0C => X"{[17:9]_INIT_0C}",
                    INIT_0D => X"{[17:9]_INIT_0D}",
                    INIT_0E => X"{[17:9]_INIT_0E}",
                    INIT_0F => X"{[17:9]_INIT_0F}",
                    INIT_10 => X"{[17:9]_INIT_10}",
                    INIT_11 => X"{[17:9]_INIT_11}",
                    INIT_12 => X"{[17:9]_INIT_12}",
                    INIT_13 => X"{[17:9]_INIT_13}",
                    INIT_14 => X"{[17:9]_INIT_14}",
                    INIT_15 => X"{[17:9]_INIT_15}",
                    INIT_16 => X"{[17:9]_INIT_16}",
                    INIT_17 => X"{[17:9]_INIT_17}",
                    INIT_18 => X"{[17:9]_INIT_18}",
                    INIT_19 => X"{[17:9]_INIT_19}",
                    INIT_1A => X"{[17:9]_INIT_1A}",
                    INIT_1B => X"{[17:9]_INIT_1B}",
                    INIT_1C => X"{[17:9]_INIT_1C}",
                    INIT_1D => X"{[17:9]_INIT_1D}",
                    INIT_1E => X"{[17:9]_INIT_1E}",
                    INIT_1F => X"{[17:9]_INIT_1F}",
                    INIT_20 => X"{[17:9]_INIT_20}",
                    INIT_21 => X"{[17:9]_INIT_21}",
                    INIT_22 => X"{[17:9]_INIT_22}",
                    INIT_23 => X"{[17:9]_INIT_23}",
                    INIT_24 => X"{[17:9]_INIT_24}",
                    INIT_25 => X"{[17:9]_INIT_25}",
                    INIT_26 => X"{[17:9]_INIT_26}",
                    INIT_27 => X"{[17:9]_INIT_27}",
                    INIT_28 => X"{[17:9]_INIT_28}",
                    INIT_29 => X"{[17:9]_INIT_29}",
                    INIT_2A => X"{[17:9]_INIT_2A}",
                    INIT_2B => X"{[17:9]_INIT_2B}",
                    INIT_2C => X"{[17:9]_INIT_2C}",
                    INIT_2D => X"{[17:9]_INIT_2D}",
                    INIT_2E => X"{[17:9]_INIT_2E}",
                    INIT_2F => X"{[17:9]_INIT_2F}",
                    INIT_30 => X"{[17:9]_INIT_30}",
                    INIT_31 => X"{[17:9]_INIT_31}",
                    INIT_32 => X"{[17:9]_INIT_32}",
                    INIT_33 => X"{[17:9]_INIT_33}",
                    INIT_34 => X"{[17:9]_INIT_34}",
                    INIT_35 => X"{[17:9]_INIT_35}",
                    INIT_36 => X"{[17:9]_INIT_36}",
                    INIT_37 => X"{[17:9]_INIT_37}",
                    INIT_38 => X"{[17:9]_INIT_38}",
                    INIT_39 => X"{[17:9]_INIT_39}",
                    INIT_3A => X"{[17:9]_INIT_3A}",
                    INIT_3B => X"{[17:9]_INIT_3B}",
                    INIT_3C => X"{[17:9]_INIT_3C}",
                    INIT_3D => X"{[17:9]_INIT_3D}",
                    INIT_3E => X"{[17:9]_INIT_3E}",
                    INIT_3F => X"{[17:9]_INIT_3F}",
                    INIT_40 => X"{[17:9]_INIT_40}",
                    INIT_41 => X"{[17:9]_INIT_41}",
                    INIT_42 => X"{[17:9]_INIT_42}",
                    INIT_43 => X"{[17:9]_INIT_43}",
                    INIT_44 => X"{[17:9]_INIT_44}",
                    INIT_45 => X"{[17:9]_INIT_45}",
                    INIT_46 => X"{[17:9]_INIT_46}",
                    INIT_47 => X"{[17:9]_INIT_47}",
                    INIT_48 => X"{[17:9]_INIT_48}",
                    INIT_49 => X"{[17:9]_INIT_49}",
                    INIT_4A => X"{[17:9]_INIT_4A}",
                    INIT_4B => X"{[17:9]_INIT_4B}",
                    INIT_4C => X"{[17:9]_INIT_4C}",
                    INIT_4D => X"{[17:9]_INIT_4D}",
                    INIT_4E => X"{[17:9]_INIT_4E}",
                    INIT_4F => X"{[17:9]_INIT_4F}",
                    INIT_50 => X"{[17:9]_INIT_50}",
                    INIT_51 => X"{[17:9]_INIT_51}",
                    INIT_52 => X"{[17:9]_INIT_52}",
                    INIT_53 => X"{[17:9]_INIT_53}",
                    INIT_54 => X"{[17:9]_INIT_54}",
                    INIT_55 => X"{[17:9]_INIT_55}",
                    INIT_56 => X"{[17:9]_INIT_56}",
                    INIT_57 => X"{[17:9]_INIT_57}",
                    INIT_58 => X"{[17:9]_INIT_58}",
                    INIT_59 => X"{[17:9]_INIT_59}",
                    INIT_5A => X"{[17:9]_INIT_5A}",
                    INIT_5B => X"{[17:9]_INIT_5B}",
                    INIT_5C => X"{[17:9]_INIT_5C}",
                    INIT_5D => X"{[17:9]_INIT_5D}",
                    INIT_5E => X"{[17:9]_INIT_5E}",
                    INIT_5F => X"{[17:9]_INIT_5F}",
                    INIT_60 => X"{[17:9]_INIT_60}",
                    INIT_61 => X"{[17:9]_INIT_61}",
                    INIT_62 => X"{[17:9]_INIT_62}",
                    INIT_63 => X"{[17:9]_INIT_63}",
                    INIT_64 => X"{[17:9]_INIT_64}",
                    INIT_65 => X"{[17:9]_INIT_65}",
                    INIT_66 => X"{[17:9]_INIT_66}",
                    INIT_67 => X"{[17:9]_INIT_67}",
                    INIT_68 => X"{[17:9]_INIT_68}",
                    INIT_69 => X"{[17:9]_INIT_69}",
                    INIT_6A => X"{[17:9]_INIT_6A}",
                    INIT_6B => X"{[17:9]_INIT_6B}",
                    INIT_6C => X"{[17:9]_INIT_6C}",
                    INIT_6D => X"{[17:9]_INIT_6D}",
                    INIT_6E => X"{[17:9]_INIT_6E}",
                    INIT_6F => X"{[17:9]_INIT_6F}",
                    INIT_70 => X"{[17:9]_INIT_70}",
                    INIT_71 => X"{[17:9]_INIT_71}",
                    INIT_72 => X"{[17:9]_INIT_72}",
                    INIT_73 => X"{[17:9]_INIT_73}",
                    INIT_74 => X"{[17:9]_INIT_74}",
                    INIT_75 => X"{[17:9]_INIT_75}",
                    INIT_76 => X"{[17:9]_INIT_76}",
                    INIT_77 => X"{[17:9]_INIT_77}",
                    INIT_78 => X"{[17:9]_INIT_78}",
                    INIT_79 => X"{[17:9]_INIT_79}",
                    INIT_7A => X"{[17:9]_INIT_7A}",
                    INIT_7B => X"{[17:9]_INIT_7B}",
                    INIT_7C => X"{[17:9]_INIT_7C}",
                    INIT_7D => X"{[17:9]_INIT_7D}",
                    INIT_7E => X"{[17:9]_INIT_7E}",
                    INIT_7F => X"{[17:9]_INIT_7F}",
                   INITP_00 => X"{[17:9]_INITP_00}",
                   INITP_01 => X"{[17:9]_INITP_01}",
                   INITP_02 => X"{[17:9]_INITP_02}",
                   INITP_03 => X"{[17:9]_INITP_03}",
                   INITP_04 => X"{[17:9]_INITP_04}",
                   INITP_05 => X"{[17:9]_INITP_05}",
                   INITP_06 => X"{[17:9]_INITP_06}",
                   INITP_07 => X"{[17:9]_INITP_07}",
                   INITP_08 => X"{[17:9]_INITP_08}",
                   INITP_09 => X"{[17:9]_INITP_09}",
                   INITP_0A => X"{[17:9]_INITP_0A}",
                   INITP_0B => X"{[17:9]_INITP_0B}",
                   INITP_0C => X"{[17:9]_INITP_0C}",
                   INITP_0D => X"{[17:9]_INITP_0D}",
                   INITP_0E => X"{[17:9]_INITP_0E}",
                   INITP_0F => X"{[17:9]_INITP_0F}")
      port map(   ADDRARDADDR => address_a(14 downto 0),
                      ENARDEN => enable,
                    CLKARDCLK => clk,
                    DOUTADOUT => data_out_a_h(31 downto 0),
                  DOUTPADOUTP => data_out_a_h(35 downto 32), 
                      DINADIN => data_in_a(31 downto 0),
                    DINPADINP => data_in_a(35 downto 32), 
                          WEA => "0000",
                  REGCEAREGCE => '0',
                RSTRAMARSTRAM => '0',
                RSTREGARSTREG => '0',
                  ADDRBWRADDR => address_b(14 downto 0),
                      ENBWREN => enable_b,
                    CLKBWRCLK => clk_b,
                    DOUTBDOUT => data_out_b_h(31 downto 0),
                  DOUTPBDOUTP => data_out_b_h(35 downto 32), 
                      DINBDIN => data_in_b_h(31 downto 0),
                    DINPBDINP => data_in_b_h(35 downto 32), 
                        WEBWE => we_b,
                       REGCEB => '0',
                      RSTRAMB => '0',
                      RSTREGB => '0',
                INJECTDBITERR => '0',
                INJECTSBITERR => '0',
                      ADDRENA => '1',
                      ADDRENB => '1',
                    CASDIMUXA => '0',
                    CASDIMUXB => '0',
                      CASDINA => "00000000000000000000000000000000",  
                      CASDINB => "00000000000000000000000000000000",
                     CASDINPA => "0000",
                     CASDINPB => "0000",
                    CASDOMUXA => '0',
                    CASDOMUXB => '0',
                 CASDOMUXEN_A => '1',
                 CASDOMUXEN_B => '1',
                 CASINDBITERR => '0',
                 CASINSBITERR => '0',
                 CASOREGIMUXA => '0',
                 CASOREGIMUXB => '0',
              CASOREGIMUXEN_A => '0',
              CASOREGIMUXEN_B => '0',
                    ECCPIPECE => '0',
                        SLEEP => '0');
      --
    end generate us;
    --
  end generate ram_4k_generate;	              
  --
  --

  --
end low_level_definition;
--

