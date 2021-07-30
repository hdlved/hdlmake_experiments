action = "simulation"
sim_tool = "ghdl"
sim_top = "tb.tb"

sim_post_cmd = "ghdl -r --work=tb tb --stop-time=6us --vcd=eg_tb.vcd && gtkwave eg_tb.vcd"

modules = {
  "local" : [ "../tb_src" ],
}
