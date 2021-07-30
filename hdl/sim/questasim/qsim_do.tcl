


# if exists then else dont bother...
vlib lib_a
vmap work lib_a
vcom -work lib_a ../../rtl/lib_a/register_types_pkg.vhd
vcom -work lib_a ../../rtl/lib_a/register_access_fns_pkg.vhd
vcom -work lib_a ../../rtl/common_across_libs/axi_regs.vhd


vlib lib_b
vmap work lib_b
vcom -work lib_b ../../rtl/lib_b/register_types_pkg.vhd
vcom -work lib_b ../../rtl/lib_b/register_access_fns_pkg.vhd
vcom -work lib_b ../../rtl/common_across_libs/axi_regs.vhd



vlib lib_c
vmap work lib_c
vcom -work lib_c ../../rtl/lib_c/merged_top.vhd
vcom -work lib_c ../../rtl/lib_c/repinned_top.vhd


vlib tb
vmap work tb
vcom -work tb ../tb_src/ex_tb.vhd




vsim tb.ex_tb;