action = "simulation"
sim_tool = "modelsim"
sim_top = "tb.tb"

sim_post_cmd = "vsim -do vsim.do -i tb.tb"

modules = {
  "local" : [ "../tb_src" ],
}
