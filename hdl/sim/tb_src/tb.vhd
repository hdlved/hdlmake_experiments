-- Copyright Philip Clarke 2020 - 2021
--
-- ---------------------------------------------------------------------
-- This source describes Open Hardware and is licensed under the CERN-OHL-S v2.
-- You may redistribute and modify this source and make products using it
-- under the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt).
--
-- This source is distributed WITHOUT ANY EXPRESS OR IMPLIED
-- WARRANTY, INCLUDING OF MERCHANTABILITY, SATISFACTORY
-- QUALITY AND FITNESS FOR A PARTICULAR PURPOSE. Please see
-- the CERN-OHL-S v2 for applicable conditions.
--
-- Source location: https://github.com/hdlved/vhdl2008_testcases
--
-- As per CERN-OHL-S v2 section 4, should hardware be produced using this source,
-- the product must visibly display the source location in its documentation,
--
-- -----------------------------------------------------------------------------
--
-- This code is probably available to purchase from the orgional author under a
-- different license if that suits your project better.
--
-- -----------------------------------------------------------------------------
-- This VHDL entity implements a basic pipeline stage with behaviour that matches:


library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;


library lib_c;


entity tb is
   generic (
     g_AXI_Ax_ADDR_W : positive := 12;
     g_DAT_BW        : positive := 4
   );
end entity tb;

architecture behav of tb is
  signal clk   : std_logic := '0';
  signal rst_n : std_logic := '0';

begin


  clk <= not clk after 10 ns;
  rst_n <= '0', '1' after 50 ns;


   uut : entity lib_c.repinned_top
   generic map (
     g_AXI_Ax_ADDR_W => g_AXI_Ax_ADDR_W,
     g_DAT_BW        => g_DAT_BW
   ) port map (
      clk              => clk,             --: in std_logic;
      rst_n            => rst_n,           --: in std_logic;  -- sync reset
      aw_ready_a       => open,            --: out std_logic;
      aw_valid_a       => '0',             --: in  std_logic;
      aw_ready_b       => open,            --: out std_logic;
      aw_valid_b       => '0',             --: in  std_logic;
      aw_addr          => (others => '0'), --: in  std_logic_vector( g_AXI_Ax_ADDR_W-1 downto 0);
      aw_prot          => (others => '0'), --: in  std_logic_vector(          2 downto 0);
      w_ready_a        => open,            --: out std_logic;
      w_valid_a        => '0',             --: in  std_logic;
      w_ready_b        => open,            --: out std_logic;
      w_valid_b        => '0',             --: in  std_logic;
      w_data           => (others => '0'), --: in  std_logic_vector(g_DAT_BW*8 -1 downto 0);
      w_strb           => (others => '0'), --: in  std_logic_vector(g_DAT_BW   -1 downto 0);
      b_ready_a        => '0',             --: in  std_logic;
      b_valid_a        => open,            --: out std_logic;
      b_resp_a         => open,            --: out std_logic_vector(1 downto 0);
      b_ready_b        => '0',             --: in  std_logic;
      b_valid_b        => open,            --: out std_logic;
      b_resp_b         => open,            --: out std_logic_vector(1 downto 0);
      ar_ready_a       => open,            --: out std_logic;
      ar_valid_a       => '0',             --: in  std_logic;
      ar_ready_b       => open,            --: out std_logic;
      ar_valid_b       => '0',             --: in  std_logic;
      ar_addr          => (others => '0'), --: in  std_logic_vector(g_AXI_Ax_ADDR_W-1 downto 0);
      ar_prot          => (others => '0'), --: in  std_logic_vector(                2 downto 0);
      r_ready_a        => '1',             --: in  std_logic;
      r_valid_a        => open,            --: out std_logic;
      r_data_a         => open,            --: out std_logic_vector(g_DAT_BW*8 - 1 downto 0);
      r_resp_a         => open,            --: out std_logic_vector(             1 downto 0);
      r_ready_b        => '1',             --: in  std_logic;
      r_valid_b        => open,            --: out std_logic;
      r_data_b         => open,            --: out std_logic_vector(g_DAT_BW*8 - 1 downto 0);
      r_resp_b         => open,            --: out std_logic_vector(             1 downto 0);
      scratchpad_xor_a => open,            --: out std_logic_vector(31 downto 0);
      scratchpad_xor_b => open,            --: out std_logic_vector(31 downto 0);
      pb               => '0',             --: in  std_logic;
      switches         => "100",           --: in  std_logic_vector(2 downto 0);
      leds             => open             --: out std_logic_vector(2 downto 0)
   );



  -- Generate the test stimulus
  stimulus: process begin
    -- Wait for the Reset to be released before
    report "TODO: actually do some usefull testing!" severity error;
    
    wait until (rst_n = '1');

    for i in 0 to 100 loop
      wait until rising_edge(clk);
    end loop;
    -- Testing complete
    report "test finished" severity failure;
  end process stimulus;


end architecture behav;